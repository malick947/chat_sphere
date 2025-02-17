import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Theme_Provider extends ChangeNotifier {
  final Map<String, Color> colorOptions = {
    'Red': Colors.red,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Yellow': Colors.yellow.shade900,
    'Orange': Colors.orange,
    'Purple': Colors.purple,
    'Black': Colors.black,
  };

  Color color = Colors.purple;

  Color getThemeColor() {
    return color;
  }

  void updateTheme(String col) {
    if (colorOptions.containsKey(col)) {
      color = colorOptions[col]!;
      notifyListeners();
    }
  }
}


Future<void> StoreMyThemeValue(String Color) async {
  final pref=await SharedPreferences.getInstance();
  await pref.setString('MyThemeColor', Color );

}
Future<String> GetMyThemeValue() async {
  String? color;
  final pref=await SharedPreferences.getInstance();
  color=await pref.getString('MyThemeColor');
  return color!;
}

