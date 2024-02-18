import 'package:flutter/material.dart';

class appinformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 130),
                  Text("ⓒ2024. We: All rights reserved.", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  Text("FE | 이현진 임다인 ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  Text("BE | 신하령 김지현 ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
