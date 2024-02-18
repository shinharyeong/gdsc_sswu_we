import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _emailInputText = TextEditingController();
  var _passInputText = TextEditingController();

  void dispose() {
    _emailInputText.dispose();
    _passInputText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/we_logo.png', width: 50, height: 50),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _emailInputText,
                decoration: InputDecoration(hintText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _passInputText,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // 이메일, 비번 중 하나라도 비워있으면 패스
                  if (_emailInputText.text.isEmpty ||
                      _passInputText.text.isEmpty) return;

                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email:
                          _emailInputText.text.toLowerCase().trim(), // 가입 이메일
                      password: _passInputText.text.trim(), // 비밀번호
                    );
                    print('success registered');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  } on FirebaseAuthException catch (e) {
                    print('an error occured $e');
                  }
                },
                child: Text('Email Registration', style: TextStyle( color: Colors.black),),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 패딩 조정
                  backgroundColor: Color(0xFFDEF4DF),
                  minimumSize: Size(88, 36), // 최소 크기 조정
                  side: BorderSide(color: Color(0xFFDEF4DF)),
                ),
              ),
            ),
            SizedBox(height: 130),
          ],
        ),
      ),
    );
  }
}