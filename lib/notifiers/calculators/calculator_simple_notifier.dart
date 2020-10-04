import 'package:finance_app/models/commission_fee.dart';
import 'package:flutter/material.dart';

class CalculatorSimpleNotifier with ChangeNotifier {
  double _purchasePrice = 0;
  double _sellingPrice = 0;
  int _sharesQuantity = 0;

  CommissionFee _buyCommission = CommissionFee(0, false);
  CommissionFee _sellCommission = CommissionFee(0, false);
  double _spreadFee = 0;

  double get purchasePrice => _purchasePrice;

  set purchasePrice(double value) {
    _purchasePrice = value;
    notifyListeners();
  }

  double get sellingPrice => _sellingPrice;

  set sellingPrice(double value) {
    _sellingPrice = value;
    notifyListeners();
  }

  int get sharesQuantity => _sharesQuantity;

  set sharesQuantity(int value) {
    _sharesQuantity = value;
    notifyListeners();
  }

  double get spreadFee => _spreadFee;

  set spreadFee(double value) {
    _spreadFee = value;
    notifyListeners();
  }

  CommissionFee get sellCommission => _sellCommission;

  set sellCommission(CommissionFee value) {
    _sellCommission = value;
    notifyListeners();
  }

  CommissionFee get buyCommission => _buyCommission;

  set buyCommission(CommissionFee value) {
    _buyCommission = value;
    notifyListeners();
  }
}