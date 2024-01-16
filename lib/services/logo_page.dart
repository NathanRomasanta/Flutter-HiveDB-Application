// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:async';
import 'package:cero/screens/navigator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {

  @override
  void initState() {
    super.initState();
    displayNextScreen();
  }

  displayNextScreen() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const MainNavigator(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 500)));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
          child: SizedBox(
        width: 220,
        height: 220,
        child: Image.asset('lib/images/CeroLogo.png'),
      )),
    );
  }
}