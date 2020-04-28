import 'package:flutter/material.dart';

import 'package:persist_data_sqlite/dog_crud.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD',
      home: DogCrud(),
    );
  }
}