import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/database_creation.dart';

class ListRet extends StatefulWidget {
  const ListRet({Key? key}) : super(key: key);

  @override
  _ListRetState createState() => _ListRetState();
}

class _ListRetState extends State<ListRet> {
  List<Map> retlist = [];
  List<Map> complist = [];
  List<Map> memlist = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var list = await Dbcreate().fetchRet();
    for (var e in list) {
      retlist.add({
        'id': e.id,
        'FK_composant': e.composant,
        'FK_member': e.member,
        'etat': e.etat,
        'date': e.date.toIso8601String(),
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
    var listee = await Dbcreate().fetchMem();
    for (var element in listee) {
      memlist.add({
        'id': element.id,
        'nom': element.nom,
        'prenom': element.prenom,
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
            title:  const Text('Returned Components'),
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
            child: retlist.isEmpty
                ? Text("No components returned.")
                : Column(
                    children: retlist.map((ret) {
                      return Card(
                        child: ExpansionTile(
                          title: Text(complist.singleWhere(
                              (e) => e['id'] == ret['FK_composant'])['name']),
                          children: <Widget>[
                            Text('Returned on : ' +
                                ret['date']
                                    .toString()
                                    .replaceRange(10, ret['date'].length, '')),
                            Text('By : ' + memlist.singleWhere(
                                    (e) => e['id'] == ret['FK_member'])['nom'] + ' ' + memlist.singleWhere(
                                    (e) => e['id'] == ret['FK_member'])['prenom']),
                            Text('State :' + ret['etat'])
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          )),
        ));
  }
}
