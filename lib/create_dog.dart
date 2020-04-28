import 'package:flutter/material.dart';
import 'package:persist_data_sqlite/dog.dart';


class CreateDog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateDogState();
  }
}

class CreateDogState extends State<CreateDog> {
  final DogDB db = DogDB();
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create"),),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name"
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: "Age"
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }
              ),
              RaisedButton(
                child: Text("Save"),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    String name = _nameController.text;
                    int age = int.parse(_ageController.text);

                    Dog dog = Dog(name: name, age: age);

                    await db.insertDog(dog);

                    Navigator.pop(context);
                  }
                }
              )
            ],
          )
        ),
      ),
    );
  }
}