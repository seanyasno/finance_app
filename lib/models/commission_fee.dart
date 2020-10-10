import 'package:finance_app/abstraction/fee.dart';
import 'package:flutter/material.dart';

class CommissionFee with ChangeNotifier implements IFee  {
  double _value;
  bool _usePercentage;

  CommissionFee(this._value, this._usePercentage);

  @override
  double get value => _value;

  @override
  bool get usePercentage => _usePercentage;

  set value(double value) {
    this._value = value;
    notifyListeners();
  }

  set usePercentage(bool value) {
    _usePercentage = value;
    print('changing use');
    notifyListeners();
  }

  @override
  double calculate({double data}) {
    if (usePercentage)
      return data * (_value / 100);
    return _value;
  }
}