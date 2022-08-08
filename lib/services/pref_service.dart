import 'package:hive/hive.dart';

class HiveDB {
  static const DBNAME = "firebase";
  static var box = Hive.box(DBNAME);

  static void storeUid(String uid) async {
    box.put("uid", uid);
  }

  static String loadUid() {
    return box.get("uid", defaultValue: "");
  }

  static Future<void> removeUid() {
    return box.delete("uid");
  }

  // Firebase Token
  static void saveFCM(String fcmToken) async {
    box.put('fcm_token', fcmToken);
  }

  static String loadFCM() {
    return box.get("fcm_token", defaultValue: "");
  }
}