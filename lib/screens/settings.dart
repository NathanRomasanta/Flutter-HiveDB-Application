// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cero/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive/hive.dart';
import 'package:unicons/unicons.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _Bucket1_Main = Hive.box('Bucket1_Main');
  final _Bucket1_Transactions = Hive.box('Bucket1_Transactions');

  //final _Bucket2_Main = Hive.box('Bucket2_Main');
  //final _Bucket2_Transactions = Hive.box('Bucket2_Transactions');



  void bucket1ClearData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Reset Bucket 1?',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Altone',
              )),
          content: const Text(
              "Are you sure you want to reset transactions for Bucket 1?",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Altone',
              )),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Altone',
                  )),
              onPressed: () {
                _Bucket1_Main.clear();
                _Bucket1_Transactions.clear();

                _Bucket1_Main.put(0, 0.0);
                _Bucket1_Main.put(1, "No Name");
                _Bucket1_Main.put(2, "Bucket 1");

                Navigator.pop(context);

                Phoenix.rebirth(context);
              },
            ),
            TextButton(
              child: const Text('No',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Altone',
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Settings",
              style: TextStyle(
                  fontFamily: 'Altone',
                  fontSize: 30,
                  fontWeight: FontWeight.w700)),
          const Divider(height: 20),
          
          ListTile(
            dense: true,
            visualDensity: const VisualDensity(vertical: 3),
            leading: const Icon(
              UniconsLine.trash_alt,
              color: Colors.black,
            ),
            title: const Text("Reset Bucket 1",
                style: TextStyle(
                  fontFamily: 'Altone',
                  fontSize: 17,
                )),
            onTap: () {
              bucket1ClearData();
            },
          ),
          const Divider(height: 10),
          const SizedBox(
            height: 20,
          ),
          const Text("Version 1.0", style: Styles.common),
          const SizedBox(
            height: 200,
          )
        ]),
      ),
    );
  }
}
