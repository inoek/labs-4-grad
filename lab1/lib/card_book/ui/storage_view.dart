import 'package:flutter/material.dart';
import 'package:lab1/card_book/domain/models.dart';
import 'package:lab1/card_book/ui/student_card.dart';
import 'package:lab1/card_book/ui/teacher_card.dart';
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
        children: [
          ...context.read<Student>().students.map((e) => StudentCard(e)),
          const SizedBox(height: 30),
          ...context.read<Teacher>().teachers.map((e) => TeacherCard(e)),
        ],
      ),
    );
  }
}
