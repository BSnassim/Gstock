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
   void initState() {
     getData();
     super.initState();
   }

   getData(){
     nameController.text = widget.name;
   }
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
        title: Text('Edit Category'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Category Name"),
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
    ));
  }
}
