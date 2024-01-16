import 'package:cero/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:unicons/unicons.dart';

class NewExpense extends StatefulWidget {
  final String bucket;
  const NewExpense({super.key, required this.bucket});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  late IconData selected = Icons.payments_rounded;
  String select = "";

  void updateValue(IconData? newData) {
    setState(() {
      selected = newData!;
      select = selected.codePoint.toRadixString(16);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String main = "${widget.bucket}_Main";
    final String transaction = "${widget.bucket}_Transactions";

    final bucketMain = Hive.box(main);
    final bucketTransactions = Hive.box(transaction);

    Future<void> createnewtransaction(Map<String, dynamic> newItem) async {
      await bucketTransactions.add(newItem);
    }

    void transactionChecker() {
      if (nameController.text.isEmpty || amountController.text.isEmpty) {
        alertBox(context);
      } else {
        String value = amountController.text;

        if (value.isNotEmpty && value[0] == '\$') {
          value = value.substring(1);
        }

        if (selected == Icons.payments_rounded) {
          updateValue(Icons.payments_rounded);
        }

        double newtotal = 0;
        double oldtotal = bucketMain.get(0);

        newtotal = oldtotal - double.parse(value);

        bucketMain.put(0, newtotal);

        createnewtransaction({
          "Name": nameController.text.trim(),
          "Amount": double.parse(value),
          "Type": "Expense",
          "Description": descriptionController.text.trim(),
          "Icon": select
        });

        nameController.clear();
        amountController.clear();
        descriptionController.clear();

        Navigator.pop(context);
      }
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
          "New Expense Transaction",
          style: Styles.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text("Amount", style: Styles.boxtitles),

              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9\$]')),
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      controller: amountController,
                      decoration: Styles.textbox,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontFamily: "Altone")),
                ),
              ),

              //Icon
              // ignore: unnecessary_null_comparison
              selected == null
                  ? const Icon(UniconsLine.money_bill, size: 40)
                  : Icon(selected, color: Colors.black, size: 40),

              const SizedBox(height: 10),
              SizedBox(
                width: 150,
                child: TextButton(
                  onPressed: () async {
                    final IconData? result = await showIconPicker(
                        context: context, defaultIcon: selected);

                    updateValue(result);
                  },
                  style: Styles.iconButton,
                  child: const Text(
                    "Choose Icon",
                    style: TextStyle(
                        color: Color(0xffe4f23c), fontFamily: 'Altone'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Income Name", style: Styles.boxtitles),
                    const SizedBox(height: 10),
                    TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        decoration: Styles.namebox,
                        controller: nameController,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Altone',
                        )),
                    const SizedBox(height: 10),
                    const Text("Description", style: Styles.boxtitles),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 223, 223, 223),
                      ),
                      height: 125,
                      child: TextField(
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          decoration: Styles.description,
                          controller: descriptionController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Altone',
                          )),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              SizedBox(
                width: 250,
                height: 55,
                child: TextButton(
                    onPressed: () {
                      transactionChecker();
                    },
                    style: Styles.greenbuttonstyle,
                    child: const Text("Deduct Funds", style: Styles.boxtitles)),
              )
            ]),
      ),
    );
  }
}
