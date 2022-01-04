import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/category_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';

class AddCateg extends StatefulWidget {
  const AddCateg({Key? key}) : super(key: key);

  @override
  _AddCategState createState() => _AddCategState();
}

class _AddCategState extends State<AddCateg> {
  TextEditingController nameController = TextEditingController();

  Future<bool> _onWillPop() async{
    await Navigator.pushNamed(context, 'categorylist');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Add Category'),
          ),
          body: Container(
            padding: EdgeInsets.all(30),
            child: Column(children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Category Name'),
              ),
              ElevatedButton(
                  onPressed: () {
                    var categ = Category(name: nameController.text);
                    Dbcreate().insertCateg(categ);
                    Navigator.pushNamed(context, 'categorylist');
                  },
                  child: Text('Save Category'))
            ]),
          ),
        ));
  }
}
