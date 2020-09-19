import 'package:finance_app/abstraction/fee.dart';

class CommissionFee implements IFee {
  double _value;

  CommissionFee(this._value, this.usePercentage);

  @override
  double get value => _value;

  @override
  bool usePercentage;

  @override
  double calculate({double data}) {
    if (usePercentage)
      return data * (_value / 100);
    return _value;
  }
}