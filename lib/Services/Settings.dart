import 'package:chat_sphere/State_Management/Theme_Provider.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String hinttext = 'Change Theme';
  final Map<String, Color> colorOptions = {
    'Red': Colors.red,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Yellow': Colors.yellow,
    'Orange': Colors.orange,
    'Purple': Colors.purple,
    'Black': Colors.black,
  };

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<Theme_Provider>(context);
    String? dropDownValue = colorOptions.keys.firstWhere(
          (key) => colorOptions[key] == themeProvider.getThemeColor(),
      orElse: () => 'Purple',
    );

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: themeProvider.getThemeColor(),
        title: Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15),

        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        Text("Change Theme",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: dropDownValue,
            isDense: true,
            hint: Text(
              hinttext,
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            onChanged: (String? value) {
              if (value != null) {
                themeProvider.updateTheme(value);
              }
            },
            items: colorOptions.keys.map((colorName) {
              return DropdownMenuItem<String>(
                value: colorName,
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: colorOptions[colorName],
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Text(colorName),
                  ],
                ),
              );
            }).toList(),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      ],),),

    );
  }
}
