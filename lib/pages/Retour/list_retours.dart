import 'package:flutter/material.dart';

class ListRet extends StatefulWidget {
  const ListRet({Key? key}) : super(key: key);

  @override
  _ListRetState createState() => _ListRetState();
}

class _ListRetState extends State<ListRet> {

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
            title: const Text('Returned Components'),
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
