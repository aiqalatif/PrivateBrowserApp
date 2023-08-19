import 'package:flutter/material.dart';
import 'package:privatebrowser/View/browser.dart';
import 'package:privatebrowser/View/hy.dart';
import 'package:privatebrowser/View/themechanger.dart';
import '../main.dart';
import 'package:provider/provider.dart';

import 'themechanger.dart';
class DarkThemeScreen extends StatefulWidget {
  const DarkThemeScreen({Key? key}) : super(key: key);

  @override
  State<DarkThemeScreen> createState() => _DarkThemeScreenState();
}

class _DarkThemeScreenState extends State<DarkThemeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeChanger =Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Themechanger',),
     leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) =>  SecondScreen(initialurl: '',)),
       );
     },),
      ),
      body: Column(
        children: [
          RadioListTile<ThemeMode>(
            title: Text('Light Mode'),
              value: ThemeMode.light,
              groupValue: themeChanger.thememode,
              onChanged: themeChanger.setTheme),
          RadioListTile(
              title: Text('Dark Mode'),
              value: ThemeMode.dark,
              groupValue: themeChanger.thememode,
              onChanged: themeChanger.setTheme),
          RadioListTile(
              title: Text('system Mode'),
              value: ThemeMode.system,
              groupValue: themeChanger.thememode,
              onChanged: themeChanger.setTheme,
          ),
        ],
      ),
    );
  }
}
