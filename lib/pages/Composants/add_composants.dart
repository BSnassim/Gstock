import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gstock/BackEnd/database_creation.dart';
import 'package:gstock/BackEnd/Models/category_model.dart';
import 'dart:async';

class AddComp extends StatefulWidget {
  const AddComp({Key? key}) : super(key: key);

  @override
  _AddCompState createState() => _AddCompState();
}

class _AddCompState extends State<AddComp> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController stockCont = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Category? selected;
  List<Category> categlist = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    categlist = await Dbcreate().fetchCateg();
    selected = categlist[1];
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
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
            IconButton(
                icon: Icon(Icons.calendar_today),
                tooltip: 'Date of acquirement',
                onPressed: () {
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
            DropdownButton<Category>(
              value: selected,
              icon: const Icon(Icons.arrow_downward),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (Category? newValue) {
                setState(() {
                  selected = newValue!;
                });
              },
              items:
                  categlist.map<DropdownMenuItem<Category>>((Category value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text('Save Component'))
          ],
        ),
      ),
    );
  }
}
