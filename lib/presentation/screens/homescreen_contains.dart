import 'package:flutter/material.dart';
import 'package:mindaura/presentation/screens/homepage/community.dart';
import 'package:mindaura/presentation/screens/homepage/gamescreen.dart';
import 'package:mindaura/presentation/screens/homepage/tools.dart';
import 'package:mindaura/presentation/screens/homepage/homescreen.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  int _currentPageIndex = 0;

  // List of pages to navigate to
  final List<Widget> _pages = [
    const HomeScreen(),
    const ToolsScreen(),
    const Gamescreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex], // Directly use the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentPageIndex,
        selectedItemColor: Colors.green.shade200,
        unselectedItemColor: Colors.grey.shade600,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
           ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.people),
          //   label: 'Community',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Tools',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: 'Games',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
