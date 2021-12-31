import 'package:flutter/material.dart';

class ListEmp extends StatefulWidget {
  const ListEmp({Key? key}) : super(key: key);

  @override
  _ListEmpState createState() => _ListEmpState();
}

class _ListEmpState extends State<ListEmp> {

  Future<bool> _onWillPop() async{
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
        ));
  }
}
