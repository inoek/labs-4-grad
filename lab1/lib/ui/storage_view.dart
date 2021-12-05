import 'package:flutter/material.dart';
import 'package:lab1/domain/models.dart';
import 'package:lab1/ui/student_card.dart';
import 'package:provider/provider.dart';

class StorageView extends StatelessWidget {
  const StorageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Storage View'),
      ),
      body: ListView(
        children: [StudentCard(context.read<Student>().students)],
      ),
    );
  }
}
