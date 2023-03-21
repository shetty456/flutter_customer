import 'package:flutter/material.dart';
import 'package:partner/providers/auth.dart';
import 'package:partner/providers/location.dart';
import 'package:partner/screens/analyticsscreen.dart';

import 'package:partner/screens/homescreen.dart';
import 'package:partner/screens/notificationsscreen.dart';
import 'package:partner/screens/profilescreen.dart';
import 'package:partner/screens/reviewsscreen.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': const HomeScreen(),
        'title': 'Home',
      },
      {
        'page': const ReviewsScreen(),
        'title': 'Reviews',
      },
      {
        'page': const NotificationsScreen(),
        'title': 'Notifications',
      },
      {
        'page': const AnalyticsScreen(),
        'title': 'Analytics',
      },
    ];
    super.initState();
  }

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationState>(context, listen: false).getCurrentLocation();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(_pages[_selectedPageIndex]['title'] as String),
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ProfileScreen.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 0.0,
              ),
              child: CircleAvatar(
                child: Text(
                  Provider.of<Auth>(context).username[0],
                ),
              ),
            ),
          )
        ],
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: selectPage,
        selectedIconTheme: const IconThemeData(size: 28.0),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Reviews',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
        ],
      ),
    );
  }
}
