import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';

import 'list_composants.dart';

class EditComp extends StatefulWidget {
  final int id;
  final Composant comp;
  const EditComp({Key? key, required this.comp, required this.id}) : super(key: key);

  @override
  _EditCompState createState() => _EditCompState();
}

class _EditCompState extends State<EditComp> {

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
    nameCont.text = widget.comp.name;
    stockCont.text = widget.comp.stock.toString();
    dateCont.text = widget.comp.obtenue.toString();
    selectedDate = widget.comp.obtenue;
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
  Future<bool> _onWillPop() async{
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ComponentList(id: widget.id)));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
      appBar: AppBar(
        title: Text('Edit a component'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: nameCont,
            ),
            TextField(
                controller: dateCont,
                focusNode: AlwaysDisabledFocusNode(),
                onTap: () {
                  _selectDate(context);
                }),
            TextField(
              controller: stockCont,
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
                  Dbcreate().updateComp(widget.comp.id!, cp);
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
    ));
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}