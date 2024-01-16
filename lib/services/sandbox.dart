import 'package:flutter/material.dart';

//sandbox.dart file not for release

class ChangeText extends StatefulWidget {
  const ChangeText({super.key});

 @override
 _ChangeTextState createState() => _ChangeTextState();
}

class _ChangeTextState extends State<ChangeText> {
 String text = 'Hello, World!';

 void changeText() {
    setState(() {
      text = 'Text Changed!';
    });
 }

 @override
 Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        ElevatedButton(
          onPressed: changeText,
          child: Text('Change Text'),
        ),
      ],
    );
 }
}