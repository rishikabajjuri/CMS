import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const departmentName = 'departmentName';
  static const userName = 'userName';
  static const mobileNumber = 'mobileNumber';
//  static const emailId = 'email';
  static const userId = 'userId';

  static Future setDepartmentName(String deptName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(departmentName, deptName);
  }

  static Future getDepartmentName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(departmentName);
  }

  static Future setUID(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userId, uid);
  }

  static Future<String> getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userId);
  }

//  static Future setEmailId(String email) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    return prefs.setString(emailId, email);
//  }
//
//  static Future getEmailId() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    return prefs.get(emailId);
//
//  }

  static Future setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userName, name);
  }

  static Future getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userName);
  }

  static Future setMob(String mob) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(mobileNumber, mob);
  }

  static Future<String> getMob() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(mobileNumber);
  }

  static Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
