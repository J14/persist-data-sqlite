import 'package:flutter/material.dart';
import 'package:persist_data_sqlite/create_dog.dart';
import 'package:persist_data_sqlite/read_dog.dart';

class DogCrud extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DogCrudState();
  }
}

class DogCrudState extends State<DogCrud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CRUD")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("CREATE"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateDog()
                  )
                );
              }
            ),
            RaisedButton(
              child: Text("READ"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadDog()
                  )
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
