import 'dart:async';

import 'package:flutter/material.dart';
import 'package:persist_data_sqlite/dog.dart';

class ReadDog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReadDogState();
  }
}

class ReadDogState extends State<ReadDog> {
  final DogDB db = DogDB();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    db.open();
  }

  @override
  void dispose() {
    db.close();

    super.dispose();
  }

  Future<List<Dog>> _listDog() async {
    return await Future.delayed(Duration(seconds: 1), () => db.listDog());
  }

  Future<void> _confirm(Dog dog) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Tem certeza que deseja excluir?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar")),
              FlatButton(
                  onPressed: () async {
                    await db.deleteDog(dog.id);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List"),
        ),
        body: FutureBuilder<List<Dog>>(
            future: _listDog(),
            builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Dog dog = snapshot.data[index];
                        return ListTile(
                          title: Text(dog.name),
                          trailing: IconButton(
                              icon: Icon(Icons.delete_forever),
                              onPressed: () async {
                                _confirm(dog);
                              }),
                        );
                      }),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
