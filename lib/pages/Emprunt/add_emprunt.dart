import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'package:gstock/BackEnd/Models/emprunt_model.dart';
import 'package:gstock/BackEnd/Models/membre_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';
import 'package:gstock/pages/Composants/list_composants.dart';

class AddEmp extends StatefulWidget {
  final Composant cmp;
  const AddEmp({Key? key, required this.cmp}) : super(key: key);

  @override
  _AddEmpState createState() => _AddEmpState();
}

class _AddEmpState extends State<AddEmp> {

  List<Membre> memlist = [];
  Membre selected = Membre(nom: '', prenom: '', tel1: 0, tel2: 0);

  @override
  void initState(){
    getData();
    super.initState();
  }

  void getData() async{
    memlist = await Dbcreate().fetchMem();
    selected = memlist[0];
    setState(() {

    });
  }

  Future<bool> _onWillPop() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => ComponentList(id: widget.cmp.category)));
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Rent a component'),
            ),
            body: Center(child: Container(
                padding: EdgeInsets.all(30),
                child: Column(children: [
                  Text(widget.cmp.name),
                  DropdownButton<Membre>(
                      value: selected,
                      elevation: 16,
                      icon: const Icon(Icons.arrow_downward),
                      onChanged: (Membre? newValue) {
                        setState(() {
                          selected = newValue!;
                        });
                      },
                      items:
                      memlist.map<DropdownMenuItem<Membre>>((Membre value){
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value.nom+' '+value.prenom));
                      }).toList()
                  ),
                  ElevatedButton(onPressed: (){
                    Emprunt emp = Emprunt(date: DateTime.now(), member: selected.id!, composant: widget.cmp.id!);
                    Dbcreate().updateComp(widget.cmp.id!, widget.cmp);
                    Dbcreate().insertEmp(emp);
                    ScaffoldMessenger.of(context)
                        .showSnackBar( const SnackBar(
                        content: Text("Component now in use")));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ComponentList(id: widget.cmp.category)));
                  }, child: Text('Confirm'))
                ])))));
  }
}
