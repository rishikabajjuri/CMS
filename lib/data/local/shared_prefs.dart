import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const departmentName = 'departmentName';
  static const userName = 'userName';
  static const mobileNumber = 'mobileNumber';
  static const userId = 'userId';
  static const userRole='role';

  static Future setRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userRole, role);
  }

  static Future getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userRole);
  }

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
