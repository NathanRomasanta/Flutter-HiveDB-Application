// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:async';
import 'package:cero/services/logo_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Startup extends StatefulWidget {
  const Startup({super.key});

  @override
  State<Startup> createState() => __StartupStateState();
}

class __StartupStateState extends State<Startup> {

  @override
  void initState() {
    super.initState();
    displayNextScreen();
  }

  displayNextScreen() {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const LogoScreen(),
              type: PageTransitionType.fade,
              duration: const Duration(seconds: 1)));
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(""),
      ),
    );
  }
}