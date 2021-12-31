import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/database_creation.dart';
import 'package:gstock/BackEnd/Models/membre_model.dart';

class MembreEdit extends StatefulWidget {
  final Membre membre;
  final int id;
  const MembreEdit({Key? key, required this.membre, required this.id}) : super(key: key);

  @override
  _MembreEditState createState() => _MembreEditState();
}

class _MembreEditState extends State<MembreEdit> {

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController tel1Controller = TextEditingController();
  TextEditingController tel2Controller = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData(){
    nomController.text = widget.membre.nom;
    prenomController.text = widget.membre.prenom;
    tel1Controller.text = widget.membre.tel1.toString();
    tel2Controller.text = widget.membre.tel2.toString();
  }
  Future<bool> _onWillPop() async{
    await Navigator.pushNamed(context, 'memberlist');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
      appBar: AppBar(
        title: Text('Edit Member'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(children: [
          TextField(
            controller: nomController,
          ),
          TextField(
            controller: prenomController,
          ),
          TextField(
            controller: tel1Controller,
          ),
          TextField(
            controller: tel2Controller,
          ),
          ElevatedButton(
              onPressed: () {
                var mem = Membre(
                    nom: nomController.text,
                    prenom: prenomController.text,
                    tel1: int.parse(tel1Controller.text),
                    tel2: int.parse(tel1Controller.text));
                Dbcreate().updateMem(widget.id,mem);
                Navigator.pushNamed(context, 'memberlist');
              },
              child: Text('Edit Member'))
        ]),
      ),
    ));
  }
}
