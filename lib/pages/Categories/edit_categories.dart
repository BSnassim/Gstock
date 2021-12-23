import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/category_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';

class CategoryEdit extends StatefulWidget {
  final int id;
  final String name;

  const CategoryEdit({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _CategoryEditState createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {

   TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Category'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: widget.name),
          ),
          ElevatedButton(
              onPressed: () {
                var categ = Category(name: nameController.text);
                Dbcreate().updateCateg(widget.id, categ);
                Navigator.pushNamed(context, 'categorylist');
              },
              child: Text('Edit Category'))
        ]),
      ),
    );
  }
}
