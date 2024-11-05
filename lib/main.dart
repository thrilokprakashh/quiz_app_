import 'package:flutter/material.dart';
import 'package:quiz_app_june/utils/color_constants.dart';
import 'package:quiz_app_june/view/dashbord_screen/dashbord_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: ColorConstants.scaffoldBackgroundColor),
      home: DashbordPage(),
    );
  }
}
