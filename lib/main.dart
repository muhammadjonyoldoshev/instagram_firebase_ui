import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:instagram_firebase_ui/firebase_options.dart';
import 'package:instagram_firebase_ui/pages/home_page.dart';
import 'package:instagram_firebase_ui/pages/sign_in_page.dart';
import 'package:instagram_firebase_ui/pages/sign_up_page.dart';
import 'package:instagram_firebase_ui/pages/splash_page.dart';
import 'package:instagram_firebase_ui/services/pref_service.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveDB.DBNAME);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  // notification
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  var initAndroidSetting =
  const AndroidInitializationSettings("@mipmap/ic_launcher");
  var initIosSetting = const IOSInitializationSettings();
  var initSetting =
  InitializationSettings(android: initAndroidSetting, iOS: initIosSetting);
  await FlutterLocalNotificationsPlugin().initialize(initSetting);
  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget _startPage() {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            HiveDB.storeUid(snapshot.data!.uid);
            return const SplashPage();
          } else {
            HiveDB.removeUid();
            return const SignInPage();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram ',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home:  _startPage(),
      routes: {
        SplashPage.id: (context) => const SplashPage(),
        SignInPage.id: (context) => const SignInPage(),
        SignUpPage.id: (context) => const SignUpPage(),
        HomePage.id: (context) => const HomePage()
      },
    );
  }
}
