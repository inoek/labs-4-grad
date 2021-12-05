import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  InputForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input your data'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildForm(),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: () => _formKey.currentState?.save(),
              child: Text('Save form'))
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Student',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(label: Text('first name')),
        ),
        TextFormField(
          decoration: InputDecoration(label: Text('second name')),
        ),
        TextFormField(
          decoration: InputDecoration(label: Text('direction')),
        ),
        TextFormField(
          decoration: InputDecoration(label: Text('year')),
        ),
        Text(
          'Teacher',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(label: Text('first name')),
        ),
        TextFormField(
          decoration: InputDecoration(label: Text('second name')),
        ),
        TextFormField(
          decoration: InputDecoration(label: Text('subject')),
        ),
        TextFormField(
          decoration: InputDecoration(label: Text('age')),
        ),
      ],
    );
  }
}
