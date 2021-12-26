import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/database_creation.dart';


class MemberList extends StatefulWidget {
  const MemberList({Key? key}) : super(key: key);

  @override
  _MemberListState createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {

  List<Map> memlist = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var list = await Dbcreate().fetchMem();
    for (var element in list) {memlist.add({
      'id' : element.id,
      'nom' : element.nom,
      'prenom' : element.prenom,
      'tel1' : element.tel1,
      'tel2' : element.tel2
    });}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child : const Icon(Icons.add),
        onPressed: (){Navigator.pushNamed(context, 'addcateg');},
      ),
    );
  }

}
