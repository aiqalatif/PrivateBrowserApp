import 'package:flutter/material.dart';

import 'package:privatebrowser/View/DarkThemScreen.dart';
import 'package:privatebrowser/View/browser.dart';

import 'package:privatebrowser/View/splash.dart';
import 'package:privatebrowser/View/test.dart';
import 'package:privatebrowser/View/themechanger.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();

  //for setting orientation to portrait only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>ThemeChanger()),
        ],

     child: Builder(builder: (BuildContext context) {
       return MaterialApp(
         title: 'Flutter Demo',
         themeMode: Provider
             .of<ThemeChanger>(context)
             .thememode,
         theme: ThemeData(
           brightness: Brightness.light,
           primarySwatch: Colors.blue,
           colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
           useMaterial3: true,
         ),
         darkTheme: ThemeData(
           brightness: Brightness.dark,
           primarySwatch: Colors.green,
           useMaterial3: true,

         ),
         debugShowCheckedModeBanner: false,
         home: Splash(),
       );
     }
    ),
    );
  }
}


