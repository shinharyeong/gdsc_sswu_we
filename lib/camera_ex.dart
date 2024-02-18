import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'imagecount.dart';
import 'package:google_gemini/google_gemini.dart';

class CameraExample extends StatefulWidget {
  const CameraExample({Key? key}) : super(key: key);

  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
  File? _image;
  final picker = ImagePicker();
  List? _outputs;
  Interpreter? _interpreter;
  String _geminiResult = '';

  @override
  void initState() {
    super.initState();
  }

  final gemini = GoogleGemini(
    apiKey: "AIzaSyCnhMuwvax6kOljlO1Lv5hEsQUyLqzHXtU",
  );

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    if (image != null) {
      setState(() {
        _image = File(image.path); // 가져온 이미지를 _image에 저장
        imageCount++;
      });

      gemini.generateFromTextAndImages(
          query: "Please tell me how to recycle the objects seen in the photo in two lines.",
          image: _image!
      ).then((value) {
        setState(() {
          _geminiResult = value.text; // 결과를 상태 변수에 저장
        });
      }).catchError((e) {
        print(e);
        setState(() {
          _geminiResult = 'Error: $e';
          imageCount--;
        });
      });
    }
  }

  Future classifyImage(File image) async {
    var imageBytes = image.readAsBytesSync();
    img.Image? imageTemp = img.decodeImage(imageBytes);
    var inputImage = img.copyResize(imageTemp!, width: 224, height: 224);
    var input = inputImage.getBytes(); // 이미지를 바이트 배열로 변환

    // 모델 실행
    var output = List<double>.filled(2, 0); // 예시: 결과를 저장할 공간 (모델의 출력 크기에 따라 조정 필요)
    _interpreter?.run(input, output);

    // 결과 처리
    setState(() {
      _outputs = [output];
    });
  }

  Widget showImage() {
    return Container(
        margin: EdgeInsets.only(left: 95, right: 95),
        child: Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(File(_image!.path))));
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            showImage(),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 150,
              child: TextField(
                controller: TextEditingController(
                    text: _geminiResult.isEmpty ? 'Image analysis result will appear here. \n Please wait a moment.' : _geminiResult),
                readOnly: true, // 사용자 입력 방지
                style: TextStyle(color: Colors.black87, fontSize: 15),
                maxLines: null, // 여러 줄의 텍스트 수용
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  fillColor: Color(0xFFDEF4DF), // 배경 색상 설정
                  filled: true, // fillColor 적용을 위해 true로 설정
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0), // 텍스트 필드 모서리 둥글게 설정
                    borderSide: BorderSide.none, // 테두리선 없앰
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.grey.shade200), // 비활성화 상태에서의 경계선 색상
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.blue.shade200), // 활성화 상태에서의 경계선 색상
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () => getImage(ImageSource.camera),
                  tooltip: 'Take a Photo',
                  backgroundColor: Color(0xFFDEF4DF),
                  child: Icon(Icons.camera_alt, color: Colors.white),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () => getImage(ImageSource.gallery),
                  tooltip: 'Pick from Gallery',
                  backgroundColor: Color(0xFFDEF4DF),
                  child: Icon(Icons.photo_library, color: Colors.white),
                ),
              ],
            ),
          ],
        ));
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }
}

