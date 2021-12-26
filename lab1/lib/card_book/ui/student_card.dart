import 'package:flutter/material.dart';
import 'package:lab1/card_book/domain/models.dart';

import 'app_card.dart';

class StudentCard extends AppCard {
  const StudentCard(this.student, {Key? key}) : super(key: key);
  final Student student;

  @override
  String get cardTitle => 'Student';

  @override
  Widget get card => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            student.firstName ?? '',
          ),
          Text(
            student.secondName ?? '',
          ),
          Text(
            student.direction ?? '',
          ),
          Text(
            student.year ?? '',
          ),
        ],
      );
}
