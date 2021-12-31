import 'package:flutter/material.dart';
import 'package:lab1/card_book/domain/input_form_vm.dart';
import 'package:lab1/card_book/domain/models.dart';
import 'package:lab1/card_book/domain/person_bundle.dart';
import 'package:lab1/card_book/domain/storage_bundle_cubit.dart';
import 'package:lab1/local_storage.dart';
import 'package:lab1/service_locator.dart';
import 'package:provider/provider.dart';

class InputForm extends StatelessWidget {
  InputForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input your data'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildForm(context),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _onSave(context),
            child: Text('Save form'),
          )
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Student',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(label: Text('first name')),
            onSaved: (value) => context.read<Student>().inputFirstName = value,
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('second name')),
            onSaved: (value) => context.read<Student>().inputSecondName = value,
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('direction')),
            onSaved: (value) => context.read<Student>().inputDirection = value,
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('year')),
            keyboardType: TextInputType.number,
            onSaved: (value) => context.read<Student>().inputYear = value,
          ),
          const SizedBox(height: 20),
          Text(
            'Teacher',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(label: Text('first name')),
            onSaved: (value) => context.read<Teacher>().inputFirstName = value,
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('second name')),
            onSaved: (value) => context.read<Teacher>().inputSecondName = value,
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('subject')),
            onSaved: (value) => context.read<Teacher>().inputSubject = value,
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('age')),
            onSaved: (value) => context.read<Teacher>().inputAge = value,
          ),
        ],
      ),
    );
  }

  void _onSave(BuildContext context) {
    _formKey.currentState?.save();
    final studentVM = context.read<Student>();
    final teacherVM = context.read<Teacher>();
    final student = Student(
      direction: studentVM.inputDirection,
      year: studentVM.inputYear,
      firstName: studentVM.inputFirstName,
      secondName: studentVM.inputSecondName,
    );
    final teacher = Teacher(
      subject: teacherVM.inputSubject,
      age: teacherVM.inputAge,
      firstName: teacherVM.inputFirstName,
      secondName: teacherVM.inputSecondName,
    );
    locator
        .get<LocalStorage>()
        .write(StorageBundleCubit.bundleKey, PersonBundle());
    studentVM.addStudent(student);
    teacherVM.addTeacher(teacher);
    context.read<InputFormVM>().isEmpty = false;
  }
}
