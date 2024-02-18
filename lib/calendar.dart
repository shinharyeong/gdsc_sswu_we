import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'home.dart';
import 'camera.dart';
import 'mypage.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<Event>> _selectedEvents = {};

  void _addOrRemoveRecycleDay(DateTime selectedDay) {
    if (_selectedEvents.containsKey(selectedDay) && _selectedEvents[selectedDay]!.isNotEmpty) {
      _selectedEvents.remove(selectedDay);
    } else {
      _selectedEvents[selectedDay] = [Event('Recycle')];
    }
    setState(() {});
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _selectedEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final events = _getEventsForDay(selectedDay);
    final isEventPresent = events.isNotEmpty;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEventPresent ? 'Delete Recycling Day' : 'Add Recycling Day', style: TextStyle(color: Color(0xFF417541))),
        content: Text(isEventPresent ? 'Would you like to delete the recycling day for this date?' : 'Would you like to add this date as a recycling day?'),
        backgroundColor: Color(0xFFDEF4DF),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _addOrRemoveRecycleDay(selectedDay);
              Navigator.of(context).pop(); // 확인 및 대화상자 닫기
            },
            child: Text(isEventPresent ? 'Delete' : 'Add', style: TextStyle(color: Colors.green)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // 취소
            child: Text('Cancel', style: TextStyle(color: Color(0xFFE61919))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recycling Calendar'),
      ),
      body: Column(
        children: [
          SizedBox(height: 100),
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              _focusedDay = focusedDay;
              _onDaySelected(selectedDay, focusedDay);
            },
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              markerDecoration: BoxDecoration(
                color: Color(0xFF417541),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Color(0xFFDEF4DF),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color(0xFFDEF4DF),
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              formatButtonShowsNext: false,
              titleTextStyle: TextStyle(color: Color(0xFF417541), fontSize: 20),
            ),
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
        ],
      ),
    bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Camera'),
            BottomNavigationBarItem(icon: Icon(Icons.date_range), label: 'Calendar'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'MyPage'),
          ],
          currentIndex: 2, // CalendarScreen은 인덱스 2
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
            if (index == 1) {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => CameraScreen(),
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

class Event {
  final String title;
  Event(this.title);
}


