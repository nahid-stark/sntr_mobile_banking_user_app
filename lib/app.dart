import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/controller_binder.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/splash_screen.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinder(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      title: "SNTR Mobile Banking",
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: _outlineInputBorder,
          focusedBorder: _outlineInputBorder,
          enabledBorder: _outlineInputBorder,
          errorBorder: _outlineInputBorder.copyWith(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        )
      ),
    );
  }

  final OutlineInputBorder _outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2),
  );
}
