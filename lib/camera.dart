import 'package:flutter/material.dart';
import 'camera_ex.dart';
import 'mypage.dart';
import 'calendar.dart';
import 'home.dart';

class CameraScreen extends StatelessWidget {
  CameraScreen({Key? key}) : super(key: key);

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraExample(),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.camera_alt),
                label: 'camera'),
            BottomNavigationBarItem(icon: Icon(Icons.date_range),
                label: 'calendar'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline),
                label: 'mypage'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.grey.shade400,
          onTap: (index) async {
            if (index == 0) {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => MyMainPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return child;
                },
              ));
            }
            if (index == 2) {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => CalendarScreen(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return child;
                },
              ));
            }
            if (index == 3) {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => MyHomePage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return child;
                },
              ));
            }
          }
      ),
    );
  }

}
