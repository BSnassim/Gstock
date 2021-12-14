import 'package:flutter/material.dart';

class ComponentList extends StatefulWidget {
  const ComponentList({Key? key}) : super(key: key);

  @override
  _ComponentListState createState() => _ComponentListState();
}

class _ComponentListState extends State<ComponentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Components'),
      ),
    );
  }
}
