import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carfuel'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index)=>setState((){
          _index = index;
        }),
        backgroundColor: Colors.red,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.delete),
              title: Text('Consumo')),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Custos')),
          BottomNavigationBarItem(
              icon:Icon(Icons.train),
              title: Text('Veículos'))
        ],
      ),
    );
  }
}
