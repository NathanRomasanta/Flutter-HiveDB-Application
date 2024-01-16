import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Styles {
  static const TextStyle title = TextStyle(
    fontFamily: 'Altone',
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle common = TextStyle(
    fontFamily: 'Altone',
    fontSize: 17,
    color: Colors.black,
  );
  static const TextStyle boxtitles = TextStyle(
    fontFamily: 'Altone',
    fontSize: 15,
    color: Colors.black,
  );
  static const TextStyle boxtitleswhite = TextStyle(
    fontFamily: 'Altone',
    fontSize: 15,
    color: Colors.white,
  );

  static const TextStyle bold = TextStyle(
    fontFamily: 'Altone',
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle transactionDetailTitle = TextStyle(
    fontFamily: 'Altone',
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  static ButtonStyle greenbuttonstyle = ButtonStyle(
      minimumSize: MaterialStateProperty.all(const Size(200, 40)),
      backgroundColor: MaterialStateProperty.all(const Color(0xffe4f23c)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      )));

  static ButtonStyle blackbuttonstyle = ButtonStyle(
      minimumSize: MaterialStateProperty.all(const Size(200, 40)),
      backgroundColor: MaterialStateProperty.all(Colors.black),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      )));

  static ButtonStyle iconButton = ButtonStyle(
      minimumSize: MaterialStateProperty.all(const Size(200, 40)),
      backgroundColor: MaterialStateProperty.all(Colors.black),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      )));

  static const InputDecoration textbox = InputDecoration(
      focusedBorder: InputBorder.none,
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      prefix: Text("\$"),
      hintText: "0.00",
      hintStyle: TextStyle(fontFamily: 'Altone', color: Color(0xffd8d8d8)));

  static const InputDecoration namebox = InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
      filled: true,
      fillColor: Color.fromARGB(255, 223, 223, 223),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      hintText: "Enter Transaction Name",
      hintStyle: TextStyle(
          fontFamily: 'Altone', color: Color.fromARGB(255, 168, 168, 168)));

  static const InputDecoration description = InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(255, 223, 223, 223),
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
      filled: true,
      fillColor: Color.fromARGB(255, 223, 223, 223),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 223, 223, 223),
          width: 1,
        ),
      ),
      hintText: "Enter Transaction Name",
      hintStyle: TextStyle(
          fontFamily: 'Altone', color: Color.fromARGB(255, 168, 168, 168)));
}

Widget optionButton(Function()? onPressed, child) {
  return SizedBox(
    height: 60,
    width: 60,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(), backgroundColor: Colors.black),
      onPressed: onPressed,
      child: child,
    ),
  );
}

Widget transactionAppBar(title) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.black),
    elevation: 0,
    toolbarHeight: 100, // Set this height
    flexibleSpace: Container(
      color: Colors.white,
      child: Text(title),
    ),
  );
}

//Alertbox to tell the user that one or more fields has no value
void alertBox(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text('Missing Fields',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Altone',
            )),
        content:
            const Text("One or more textfields has no value, Please try again",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Altone',
                )),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay',
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

//Icon picker function
Future<IconData?> showIconPicker(
    {required BuildContext context, IconData? defaultIcon}) async {
  final List<IconData> allIcons = [
    Icons.payments_rounded,
    Icons.shopping_cart_rounded,
    Icons.store_rounded,
    Icons.credit_card,
    Icons.redeem_rounded,
    Icons.account_balance_rounded,
    Icons.toll_rounded,
  ];
  IconData? selectedIcons = defaultIcon;

  await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text("Pick an Icon", style: Styles.title),
            content: Container(
              height: 200,
              width: 200,
              alignment: Alignment.center,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 60,
                      childAspectRatio: 1 / 1,
                      mainAxisSpacing: 10),
                  itemCount: allIcons.length,
                  itemBuilder: (_, index) => Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: IconButton(
                          color: selectedIcons == allIcons[index]
                              ? const Color.fromARGB(255, 161, 206, 0)
                              : Colors.black,
                          onPressed: () {
                            selectedIcons = allIcons[index];
                            Navigator.of(context).pop();
                          },
                          icon: Icon(allIcons[index]),
                        )),
                      )),
            ),
            actions: [
              SizedBox(
                width: 100,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: Styles.iconButton,
                  child: const Text(
                    "Close",
                    style: TextStyle(
                        color: Color(0xffe4f23c), fontFamily: 'Altone'),
                  ),
                ),
              )
            ],
          ));

  return selectedIcons;
}
