import 'package:flutter/cupertino.dart';

class InputFormVM with ChangeNotifier {
  bool? _isEmpty;

  bool? get isEmpty => _isEmpty;

  set isEmpty(bool? value) {
    _isEmpty = value;
    notifyListeners();
  }
}
