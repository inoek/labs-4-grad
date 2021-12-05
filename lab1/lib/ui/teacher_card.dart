import 'package:flutter/material.dart';
import 'package:lab1/domain/models.dart';
import 'package:lab1/ui/app_card.dart';

class TeacherCard extends AppCard {
  TeacherCard(this.teacher, {Key? key}) : super(key: key);

  final Teacher teacher;

  @override
  String get cardTitle => 'Teacher';

  @override
  Widget get card => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            teacher.firstName ?? '',
          ),
          Text(
            teacher.secondName ?? '',
          ),
          Text(
            teacher.subject ?? '',
          ),
          Text(
            teacher.age ?? '',
          ),
        ],
      );
}
