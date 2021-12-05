import 'package:flutter/cupertino.dart';

abstract class Person {
  const Person({
    this.firstName,
    this.secondName,
  });

  final String? firstName;
  final String? secondName;
}

class Student extends Person with ChangeNotifier {
  Student({
    this.direction,
    this.year,
    this.firstName,
    this.secondName,
  });

  @override
  final String? firstName;
  @override
  final String? secondName;
  final String? direction;
  final String? year;

  String? _inputFirstName;

  String? get inputFirstName => _inputFirstName;

  set inputFirstName(String? value) {
    _inputFirstName = value;
    notifyListeners();
  }

  String? _inputSecondName;

  String? get inputSecondName => _inputSecondName;

  set inputSecondName(String? value) {
    _inputSecondName = value;
    notifyListeners();
  }

  String? _inputDirection;

  String? get inputDirection => _inputDirection;

  set inputDirection(String? value) {
    _inputDirection = value;
    notifyListeners();
  }

  String? _inputYear;

  String? get inputYear => _inputYear;

  set inputYear(String? value) {
    _inputYear = value;
    notifyListeners();
  }

  List<Student> _students = [];

  List<Student> get students => _students;

  set students(List<Student> value) {
    _students = value;
    notifyListeners();
  }

  void addStudent(Student student) {
    students.add(student);
  }
}

class Teacher extends Person with ChangeNotifier {
  Teacher({
    this.subject,
    this.age,
    this.firstName,
    this.secondName,
  });

  @override
  final String? firstName;
  @override
  final String? secondName;

  final String? subject;
  final String? age;

  String? _inputFirstName;

  String? get inputFirstName => _inputFirstName;

  set inputFirstName(String? value) {
    _inputFirstName = value;
    notifyListeners();
  }

  String? _inputSecondName;

  String? get inputSecondName => _inputSecondName;

  set inputSecondName(String? value) {
    _inputSecondName = value;
    notifyListeners();
  }

  String? _inputSubject;

  String? get inputSubject => _inputSubject;

  set inputSubject(String? value) {
    _inputSubject = value;
    notifyListeners();
  }

  String? _inputAge;

  String? get inputAge => _inputAge;

  set inputAge(String? value) {
    _inputAge = value;
    notifyListeners();
  }

  List<Teacher> _teachers = [];

  List<Teacher> get teachers => _teachers;

  set teachers(List<Teacher> value) {
    _teachers = value;
    notifyListeners();
  }

  void addTeacher(Teacher teacher) {
    teachers.add(teacher);
  }
}
