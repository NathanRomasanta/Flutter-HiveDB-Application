// ignore_for_file: file_names, non_constant_identifier_names, unused_element, unused_local_variable, sized_box_for_whitespace
import 'package:cero/services/new_expense_page.dart';
import 'package:cero/services/new_income_page.dart';
import 'package:cero/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:hive/hive.dart';
import 'package:unicons/unicons.dart';

class Bucket1 extends StatefulWidget {
  const Bucket1({super.key});

  @override
  State<Bucket1> createState() => _Bucket1State();
}

List<Map<String, dynamic>> _Bucket1_Transactions_List = [];

class _Bucket1State extends State<Bucket1> {
  final bucket = "Bucket1";
  final _Bucket1_Main = Hive.box('Bucket1_Main');
  final _Bucket1_Transactions = Hive.box('Bucket1_Transactions');

  String bucketName = "";

  final transactionNameController = TextEditingController();
  final transactionAmountController = TextEditingController();

  final bucketNameController = TextEditingController();
  final bucketSubtitleController = TextEditingController();

  String transactionName = "Name";
  String transactionAmount = "Amount";

  Future<void> _createnewtransaction(Map<String, dynamic> newItem) async {
    await _Bucket1_Transactions.add(newItem);
  }

  void _refreshtransactions() {
    final data = _Bucket1_Transactions.keys.map((key) {
      final item = _Bucket1_Transactions.get(key);
      return {
        "key": key,
        "Name": item["Name"],
        "Amount": item["Amount"].toString(),
        "Type": item["Type"],
        "Description": item["Description"],
        "Icon": item["Icon"]
      };
    }).toList();

    setState(() {
      _Bucket1_Transactions_List = data;
    });
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _refreshtransactions();

    if (_Bucket1_Main.get(0) == null) {
      _Bucket1_Main.put(0, 0.0);
    } else {}
    if (_Bucket1_Main.get(1) == null) {
      _Bucket1_Main.put(1, "Daily Spending");
    }

    if (_Bucket1_Main.get(2) == null) {
      _Bucket1_Main.put(2, "Alt Text");
    } else {
      bucketName == _Bucket1_Main.get(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> newValueNotifier =
        ValueNotifier((_Bucket1_Main.get(0)).toString());

    ValueNotifier<String> bucketNameValueNotifier =
        ValueNotifier((_Bucket1_Main.get(1)).toString());

    ValueNotifier<String> bucketSubtitleValueNotifier =
        ValueNotifier((_Bucket1_Main.get(2)).toString());

    return Scaffold(
      backgroundColor: const Color(0xffe4f23c),
      body: Center(
          child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),

            InkWell(
                onTap: () {
                  showModalBottomSheet<dynamic>(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      context: context,
                      builder: ((context) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 35, right: 35, top: 35),
                          child: Wrap(children: [
                            Column(children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Edit Title and Tag",
                                      style: TextStyle(
                                          fontFamily: 'Altone',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                style: const TextStyle(
                                  fontFamily: 'Altone',
                                ),
                                decoration: InputDecoration(
                                    hintText: (_Bucket1_Main.get(1)).toString(),
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Altone',
                                    )),
                                controller: bucketNameController,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  fontFamily: 'Altone',
                                ),
                                decoration: InputDecoration(
                                    hintText: (_Bucket1_Main.get(2)).toString(),
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Altone',
                                    )),
                                controller: bucketSubtitleController,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        bucketNameValueNotifier.value =
                                            bucketNameController.text.trim();

                                        bucketSubtitleValueNotifier.value =
                                            bucketSubtitleController.text
                                                .trim();

                                        _Bucket1_Main.put(1,
                                            bucketNameController.text.trim());

                                        _Bucket1_Main.put(
                                            2,
                                            bucketSubtitleController.text
                                                .trim());

                                        bucketNameController.clear();
                                        bucketSubtitleController.clear();
                                        Navigator.of(context).pop();
                                      },
                                      style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  const Size(150, 40)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xFF1d1d1d)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(55.0),
                                          ))),
                                      child: const Text(
                                        "Save",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Altone',
                                        ),
                                      )),
                                  const Spacer(),
                                  TextButton(
                                      onPressed: () {
                                        bucketNameController.clear();
                                        bucketSubtitleController.clear();
                                        Navigator.of(context).pop();
                                      },
                                      style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  const Size(150, 40)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.black, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(55.0),
                                          ))),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Altone',
                                        ),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 270,
                              )
                            ]),
                          ]),
                        );
                      }));
                },
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: bucketNameValueNotifier,
                          builder:
                              (BuildContext context, String newValue, widget) {
                            return Text(newValue,
                                style: const TextStyle(
                                  fontFamily: 'Altone',
                                  fontSize: 25,
                                ));
                          }),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: bucketSubtitleValueNotifier,
                          builder:
                              (BuildContext context, String newValue, widget) {
                            return Text(newValue,
                                style: const TextStyle(
                                    fontFamily: 'Altone',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold));
                          }),
                    ],
                  ),
                )),

            const SizedBox(height: 20),
            const Text("Available Balance",
                style: TextStyle(fontFamily: 'Altone', fontSize: 17)),
            ValueListenableBuilder(
                valueListenable: newValueNotifier,
                builder: (BuildContext context, String newValue, widget) {
                  return Text("\$$newValue",
                      style:
                          const TextStyle(fontFamily: 'Altone', fontSize: 80));
                }),

            const SizedBox(
              height: 50,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                optionButton(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewExpense(
                                bucket: "bucket1",
                              ))).then((value) {
                    _refreshtransactions();
                  });
                }, const Icon(UniconsLine.money_withdraw)),
                const SizedBox(width: 60),
                optionButton(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewIncome(
                                bucket: "bucket1",
                              ))).then((value) {
                    _refreshtransactions();
                  });
                }, const Icon(Icons.add_rounded)),
              ],
            ),
            const SizedBox(
              height: 50,
            ),

            //Transaction List View Builder
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white),
              height: 350,
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 40, left: 32),
                    child: Text(
                      "Transactions",
                      style: TextStyle(
                          fontFamily: 'Altone',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  //Transactions Area
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: SingleChildScrollView(
                      child: ListView.builder(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _Bucket1_Transactions_List.length,
                          itemBuilder: (_, index) {
                            final currentTransaction =
                                _Bucket1_Transactions_List[index];

                            int val = int.parse(currentTransaction["Icon"],
                                radix: 16);
                            IconData? icon =
                                IconData(val, fontFamily: "MaterialIcons");
                            return ListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TransactionDetails(
                                                itemKey: currentTransaction[
                                                    "key"]))).then((value) {
                                  _refreshtransactions();
                                });
                                //showForm(context, currentTransaction["key"]);
                              },
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 233, 233, 233),
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Icon(
                                    icon,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                              title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      currentTransaction["Name"],
                                      style: const TextStyle(
                                          fontFamily: 'Altone',
                                          color: Colors.black),
                                    ),
                                    const Spacer(),
                                    Container(
                                        child: currentTransaction["Type"] ==
                                                "Expense"
                                            ? Text(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                "-" +
                                                    currentTransaction[
                                                        "Amount"],
                                                style: const TextStyle(
                                                    fontFamily: 'Altone',
                                                    color: Colors.black),
                                              )
                                            : Text(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                "+" +
                                                    currentTransaction[
                                                        "Amount"],
                                                style: const TextStyle(
                                                    fontFamily: 'Altone',
                                                    color: Colors.black),
                                              )),
                                  ]),
                              subtitle: Text(
                                currentTransaction["Description"],
                                style: const TextStyle(
                                    fontFamily: 'Altone',
                                    color: Color.fromARGB(255, 99, 99, 99)),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

// ignore: must_be_immutable
class TransactionDetails extends StatelessWidget {
  int? itemKey;
  TransactionDetails({super.key, required this.itemKey});

  @override
  Widget build(BuildContext context) {
    String Name = "";
    String Amount = "";
    String Type = "";
    String Description = "";
    String Icons = "";

    if (itemKey != null) {
      final existingItem = _Bucket1_Transactions_List.firstWhere(
          (element) => element['key'] == itemKey);
      Name = existingItem["Name"];
      Amount = existingItem["Amount"];
      Type = existingItem["Type"];
      Description = existingItem["Description"];
      Icons = existingItem["Icon"];
    }

    int val = int.parse(Icons, radix: 16);
    IconData? icon = IconData(val, fontFamily: "MaterialIcons");

    deleteTransaction() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Delete Transaction',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Altone',
                )),
            content:
                const Text("Are you sure you want to delete this transaction?",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Altone',
                    )),
            actions: <Widget>[
              TextButton(
                child: const Text('Yes',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Altone',
                    )),
                onPressed: () {
                  final bucketMain = Hive.box('Bucket1_Main');
                  final bucketTransactions = Hive.box('Bucket1_Transactions');

                  if (Type == "Income") {
                    double newtotal = 0;
                    double oldtotal = bucketMain.get(0);

                    newtotal = oldtotal - double.parse(Amount);

                    bucketMain.put(0, newtotal);
                  } else {
                    double newtotal = 0;
                    double oldtotal = bucketMain.get(0);

                    newtotal = oldtotal + double.parse(Amount);

                    bucketMain.put(0, newtotal);
                  }

                  bucketTransactions.delete(itemKey);
                  Navigator.pop(context);
                  Navigator.pop(context);
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

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Transaction Details",
            style: Styles.bold,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 45,
              width: 300,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Color(0xfff6f6f6)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (Type == "Income") ...[
                      Container(
                          height: 35,
                          width: 140,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              color: Colors.black),
                          child: const Center(
                            child: Text("Income",
                                style: TextStyle(
                                    color: Color(0xffe4f23c),
                                    fontFamily: 'Altone')),
                          )),
                      const SizedBox(width: 8),
                      Container(
                          height: 35,
                          width: 140,
                          child: const Center(
                            child: Text("Expense",
                                style: TextStyle(
                                    color: Color(0xff7d7d7d),
                                    fontFamily: 'Altone')),
                          ))
                    ] else ...[
                      Container(
                          height: 35,
                          width: 140,
                          child: const Center(
                            child: Text("Income",
                                style: TextStyle(
                                    color: Color(0xff7d7d7d),
                                    fontFamily: 'Altone')),
                          )),
                       const SizedBox(width: 8),
                       Container(
                          height: 35,
                          width: 140,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              color: Colors.black),
                          child: const Center(
                            child: Text("Expense",
                                style: TextStyle(
                                    color: Color(0xffe4f23c),
                                    fontFamily: 'Altone')),
                          )),
          
                      
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Text(Amount,
                style: const TextStyle(
                    color: Colors.black, fontSize: 50, fontFamily: "Altone")),
            const Center(child: Text("Amount", style: Styles.boxtitles)),
            const SizedBox(height: 30),
            optionButton(() {}, Icon(icon)),
            const SizedBox(height: 50),
            Container(
              height: 200,
              width: 340,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Transaction Name",
                        style: Styles.transactionDetailTitle),
                    Text(Name),
                    const SizedBox(height: 20),
                    const Divider(),
                    const Text("Transaction Description",
                        style: Styles.transactionDetailTitle),
                    Text(Description),
                  ]),
            ),
            SizedBox(
              width: 250,
              height: 55,
              child: TextButton(
                  onPressed: () {
                    deleteTransaction();
                  },
                  style: Styles.greenbuttonstyle,
                  child: const Text("Delete", style: Styles.boxtitles)),
            ),
          ],
        ));
  }
}
