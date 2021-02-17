import 'package:flutter/material.dart';

class FridgeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Fridge'),
      ),
      body: Center(
        child: Column(
          children: [
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
              onPressed: () async {  },
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).accentColor,
              
            ),
    );
  }
}