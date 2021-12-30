import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/database_creation.dart';
import 'package:gstock/pages/Composants/add_composants.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: ListTile(
                      title: Text(comp['name']),
                      trailing: Wrap(
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
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
    );
  }
}
