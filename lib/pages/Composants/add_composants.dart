import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gstock/BackEnd/database_creation.dart';
import 'package:gstock/BackEnd/Models/category_model.dart';
import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'dart:async';

import 'package:gstock/pages/Composants/list_composants.dart';

class AddComp extends StatefulWidget {
  final int id;
  const AddComp({Key? key, required this.id}) : super(key: key);

  @override
  _AddCompState createState() => _AddCompState();
}

class _AddCompState extends State<AddComp> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController stockCont = TextEditingController();
  TextEditingController dateCont = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {});
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateCont.text = picked.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a component'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: nameCont,
              decoration: InputDecoration(hintText: 'Component Name'),
            ),
            TextField(
                controller: dateCont,
                decoration: InputDecoration(hintText: 'Select the acquirement date'),
                focusNode: AlwaysDisabledFocusNode(),
                onTap: () {
                  _selectDate(context);
                }),
            TextField(
              controller: stockCont,
              decoration: InputDecoration(hintText: 'Stock'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Composant cp = Composant(
                      name: nameCont.text,
                      obtenue: selectedDate,
                      stock: int.parse(stockCont.text),
                      category: widget.id,
                  );
                  Dbcreate().insertComp(cp);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ComponentList(id: widget.id)));
                },
                child: Text('Save Component'))
          ],
        ),
      ),
    );
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}