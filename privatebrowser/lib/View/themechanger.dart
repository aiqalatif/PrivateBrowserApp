import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ThemeChanger with ChangeNotifier{
var _thememode=ThemeMode.light;
 ThemeMode get thememode=>_thememode;
 void setTheme(themeMode){
   _thememode=themeMode;
   notifyListeners();
 }
}


void main() {
  runApp(myfirstapp());
}

class myfirstapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('URL Launcher Example'),
        ),
        body: Center(
          child: IconButton(
            onPressed: () async {
              // Launch the URL in a new tab
              await launch('https://example.com', forceSafariVC: false, forceWebView: true, webOnlyWindowName: '_blank');
            },
            icon:Icon(Icons.add),

          ),
        ),
      ),
    );
  }
}

