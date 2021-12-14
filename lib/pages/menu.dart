import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home Menu'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(300),
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.all(16)
                ),
                child: const Text('Members'),
                onPressed: (){},
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(300),
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.all(16)
                ),
                child: const Text('Categories'),
                onPressed: (){},
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(300),
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.all(16)
                ),
                child: const Text('Components'),
                onPressed: (){},
              ),

            ],
          ),
        )
      )
    );
  }
}
