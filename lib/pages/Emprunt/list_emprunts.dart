import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';
import 'package:gstock/pages/Retour/add_retour.dart';

class ListEmp extends StatefulWidget {
  const ListEmp({Key? key}) : super(key: key);

  @override
  _ListEmpState createState() => _ListEmpState();
}

class _ListEmpState extends State<ListEmp> {
  List<Map> emplist = [];
  List<Map> complist = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var list = await Dbcreate().fetchEmp();
    for (var element in list) {
      emplist.add({
        'id': element.id,
        'FK_composant': element.composant,
        'date': element.date.toIso8601String(),
      });
    }
    var liste = await Dbcreate().fetchComp();
    for (var element in liste) {
      complist.add({
        'id': element.id,
        'name': element.name,
        'obtenue': element.obtenue.toIso8601String(),
        'stock': element.stock,
        'category': element.category,
      });
    }
    setState(() {});
  }

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
            title: const Text('Components in use'),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.search,
                      size: 26.0,
                    ),
                  )),
            ],
          ),
          body: SingleChildScrollView(
              child: Container(
            child: emplist.isEmpty
                ? Text("No components in use.")
                : Column(
                    children: emplist.map((emp) {
                      return Card(
                        child: ExpansionTile(
                          title: Text(complist.singleWhere(
                              (e) => e['id'] == emp['FK_composant'])['name']),
                          trailing: Wrap(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddRetour(
                                                id: emp['id'],
                                                CP: Composant(
                                                    id: complist.singleWhere((e) =>
                                                            e['id'] == emp['FK_composant'])[
                                                        'id'],
                                                    name: complist.singleWhere((e) =>
                                                            e['id'] == emp['FK_composant'])[
                                                        'name'],
                                                    obtenue: DateTime.parse(
                                                        complist.singleWhere((e) => e['id'] == emp['FK_composant'])['obtenue']),
                                                    stock: complist.singleWhere((e) => e['id'] == emp['FK_composant'])['stock'],
                                                    category: complist.singleWhere((e) => e['id'] == emp['FK_composant'])['category']))));
                                  },
                                  child: Text('Return'))
                            ],
                          ),
                          children: <Widget>[
                            Text('In use since : ' +
                                emp['date']
                                    .toString()
                                    .replaceRange(10, emp['date'].length, '')),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          )),
        ));
  }
}
