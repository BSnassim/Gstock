import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'package:gstock/BackEnd/Models/emprunt_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';
import 'package:gstock/pages/Composants/add_composants.dart';
import 'package:gstock/pages/Composants/edit_composants.dart';
import 'package:gstock/pages/Emprunt/add_emprunt.dart';

class ComponentList extends StatefulWidget {
  final int id;

  const ComponentList({Key? key, required this.id}) : super(key: key);

  @override
  _ComponentListState createState() => _ComponentListState();
}

class _ComponentListState extends State<ComponentList> {
  List<Map> complist = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var list = await Dbcreate().fetchComp();
    complist.clear();
    for (var element in list) {
      if (element.category == widget.id) {
        complist.add({
          'id': element.id,
          'name': element.name,
          'obtenue': element.obtenue.toIso8601String(),
          'stock': element.stock,
          'category': element.category,
        });
      }
    }
    setState(() {});
  }

  Future<bool> _onWillPop() async {
    await Navigator.pushNamed(context, 'categorylist');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Components'),
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
            child: complist.isEmpty
                ? Text("No components to show.")
                : Column(
                    children: complist.map((comp) {
                      return Card(
                        child: ExpansionTile(
                          title: Text(comp['name']),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditComp(
                                                  comp: Composant(
                                                      id: comp['id'],
                                                      name: comp['name'],
                                                      obtenue: DateTime.parse(
                                                          comp['obtenue']),
                                                      stock: comp['stock'],
                                                      category:
                                                          comp['category']),
                                                  id: widget.id,
                                                )));
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    Dbcreate().deleteComp(comp['id']);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ComponentList(id: widget.id)));
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                          children: <Widget>[
                            Text('Stock : ' + comp['stock'].toString()),
                            Text('Date : ' +
                                comp['obtenue'].toString().replaceRange(
                                    10, comp['obtenue'].length, '')),
                            ElevatedButton(
                                onPressed: () {
                                  if (comp['stock'] > 0) {
                                    var cmp = Composant(
                                        id: comp['id'],
                                        name: comp['name'],
                                        obtenue: DateTime.parse(comp['obtenue']),
                                        stock: comp['stock'] - 1,
                                        category: comp['category']);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddEmp(cmp: cmp)));
                                  } else{ScaffoldMessenger.of(context)
                                      .showSnackBar( const SnackBar(
                                      content: Text("Out of stock")));}
                                },
                                child: const Text('Use'))
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          )),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddComp(
                            id: widget.id,
                          )));
            },
          ),
        ));
  }
}
