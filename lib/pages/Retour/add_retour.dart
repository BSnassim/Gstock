import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'package:gstock/BackEnd/Models/retour_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';

class AddRetour extends StatefulWidget {
  final Composant CP;
  final int id;

  const AddRetour({Key? key, required this.CP, required this.id}) : super(key: key);

  @override
  _AddRetourState createState() => _AddRetourState();
}

class _AddRetourState extends State<AddRetour> {
  TextEditingController stateCont = TextEditingController();

  Future<bool> _onWillPop() async {
    await Navigator.pushNamed(context, 'menu');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Return a component'),
            ),
            body: Container(
                padding: EdgeInsets.all(30),
                child: Column(children: [
                  Text(widget.CP.name),
                  TextField(
                    decoration: InputDecoration(labelText: 'Stock'),
                    controller: stateCont,
                  ),
                  ElevatedButton(onPressed: () async{
                    Composant cmp = Composant(name: widget.CP.name,
                        obtenue: widget.CP.obtenue,
                        stock: widget.CP.stock + 1,
                        category: widget.CP.category);
                    Retour ret = Retour(composant: widget.CP.id!, date: DateTime.now(), etat: stateCont.text);
                    await Dbcreate().insertRet(ret);
                    await Dbcreate().updateComp(widget.CP.id!, cmp);
                    await Dbcreate().deleteEmp(widget.id);
                    Navigator.pushNamed(context, 'emplist');
                  }, child: Text('Confirm'))
                ]))));
  }
}
