import 'package:flutter/material.dart';
import 'package:lab1/domain/models.dart';
import 'package:lab1/ui/app_card.dart';

class StudentCard extends AppCard {
  const StudentCard(this.students, {Key? key}) : super(key: key);
  final List<Student> students;

  @override
  String get cardTitle => 'Student';

  @override
  List<Widget> get children => students
      .map(
        (e) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              e.firstName ?? '',
            ),
            Text(
              e.secondName ?? '',
            ),
            Text(
              e.direction ?? '',
            ),
            Text(
              e.year ?? '',
            ),
          ],
        ),
      )
      .toList();
}
