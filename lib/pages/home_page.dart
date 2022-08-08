import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/utils_service.dart';
import 'my_feed_page.dart';
import 'my_likes_page.dart';
import 'my_profile_page.dart';
import 'my_search_page.dart';
import 'my_upload_page.dart';


class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentTap = 0;

  _initNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Utils.showLocalNotification(message, context);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Utils.showLocalNotification(message, context);
    });
  }

  @override
  void initState() {
    super.initState();
    _initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentTap = index;
          });
        },
        children: [
          MyFeedPage(pageController: _pageController),
          const MySearchPage(),
          MyUploadPage(pageController: _pageController),
          const MyLikesPage(),
          const MyProfilePage()
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            _currentTap = index;
            _pageController.jumpToPage(index);
          });
        },
        currentIndex: _currentTap,
        activeColor: const Color.fromRGBO(193, 53, 132, 1),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.add_box)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }
}
