import 'package:finance_app/components/profit_sections/info_sections/info_fees_section.dart';
import 'package:finance_app/components/profit_sections/info_sections/info_share_section.dart';
import 'package:finance_app/components/profit_sections/info_sections/info_sum_section.dart';
import 'package:finance_app/components/profit_sections/simple_sections/simple_share_section.dart';
import 'package:finance_app/components/profit_sections/fees_section.dart';
import 'package:finance_app/components/profit_info/profit_info.dart';
import 'package:finance_app/models/commission_fee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SimpleProfitForm extends StatefulWidget {
  @override
  _SimpleProfitFormState createState() => _SimpleProfitFormState();
}

class _SimpleProfitFormState extends State<SimpleProfitForm> {
  double _purchasePrice = 0;
  double _sellingPrice = 0;
  int _sharesQuantity = 0;

  double _buyCommission = 0;
  double _sellCommission = 0;
  double _spreadFees = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SimpleShareSection(_purchasePriceChanged, _sellingPriceChanged, _sharesQuantityChanged),
          SizedBox(
            height: 5,
          ),
          FeesSection(_buyCommissionChanged, _sellCommissionChanged,
              _spreadFeesChanged),
          SizedBox(
            height: 5,
          ),
          InfoSumSection(
            purchasePrice: _purchasePrice,
            sellingPrice: _sellingPrice,
            sharesQuantity: _sharesQuantity,
            buyCommission: CommissionFee(_buyCommission, false),
            sellCommission: CommissionFee(_sellCommission, false),
          ),
          SizedBox(
            height: 5,
          ),
          InfoShareSection(
            purchasePrice: _purchasePrice,
            sellingPrice: _sellingPrice,
            sharesQuantity: _sharesQuantity,
            buyCommission: CommissionFee(_buyCommission, false),
            sellCommission: CommissionFee(_sellCommission, false),
            spreadFee: _spreadFees,
            children: [
              ProfitInfo('Profit / Loss', NumberFormat().format(_calculateProfit())),
              SizedBox(height: 10),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          InfoFeesSection(
            buyCommission: CommissionFee(_buyCommission, false),
            sellCommission: CommissionFee(_sellCommission, false),
            sharesQuantity: _sharesQuantity,
            purchasePrice: _purchasePrice,
            sellingPrice: _sellingPrice,
            spreadFee: _spreadFees,
          ),
        ],
      ),
    );
  }

  _purchasePriceChanged(value) {
    setState(() {
      _purchasePrice = double.parse(value);
    });
  }

  _sellingPriceChanged(value) {
    setState(() {
      _sellingPrice = double.parse(value);
    });
  }

  _sharesQuantityChanged(value) {
    setState(() {
      _sharesQuantity = int.parse(value);
    });
  }

  _buyCommissionChanged(value) {
    setState(() {
      _buyCommission = double.parse(value);
    });
  }

  _sellCommissionChanged(value) {
    setState(() {
      _sellCommission = double.parse(value);
    });
  }

  _spreadFeesChanged(value) {
    setState(() {
      _spreadFees = double.parse(value) / 100;
    });
  }

  double _calculateProfit() {
    return (_sellingPrice * _sharesQuantity) -
        (_purchasePrice * _sharesQuantity) -
        (_sellingPrice > _purchasePrice
            ? _calculateTotalFees()
            : _buyCommission + _sellCommission);
  }

  double _calculateTotalFees() {
    double spread = (_sellingPrice * _sharesQuantity) - (_purchasePrice * _sharesQuantity);
    return _buyCommission + _sellCommission + (_sellingPrice > _purchasePrice ? spread * _spreadFees : 0);
  }
}

//class _SimpleProfitFormState extends State<SimpleProfitForm> {
//  SimpleProfitFormNotifier _profitNotifier;
//
//  @override
//  Widget build(BuildContext context) {
//    _profitNotifier = Provider.of<SimpleProfitFormNotifier>(context);
//
//    return Container(
//      child: Column(
//        children: [
//          SimpleShareSection(_purchasePriceChanged, _sellingPriceChanged,
//              _sharesQuantityChanged),
//          SizedBox(
//            height: 5,
//          ),
//          FeesSection(_buyCommissionChanged, _sellCommissionChanged,
//              _spreadFeesChanged),
//          SizedBox(
//            height: 5,
//          ),
//          InfoSumSection(
//            purchasePrice: _profitNotifier.purchasePrice,
//            sellingPrice: _profitNotifier.sellingPrice,
//            sharesQuantity: _profitNotifier.sharesQuantity,
//            buyCommission: _profitNotifier.buyCommission,
//            sellCommission: _profitNotifier.sellCommission,
//          ),
//          SizedBox(
//            height: 5,
//          ),
//          InfoShareSection(
//            purchasePrice: _profitNotifier.purchasePrice,
//            sellingPrice: _profitNotifier.sellingPrice,
//            sharesQuantity: _profitNotifier.sharesQuantity,
//            buyCommission: _profitNotifier.buyCommission,
//            sellCommission: _profitNotifier.sellCommission,
//            spreadFee: _profitNotifier.spreadFee,
//            children: [
//              ProfitInfo(
//                  'Profit / Loss', NumberFormat().format(_calculateProfit())),
//              SizedBox(height: 10),
//            ],
//          ),
//          SizedBox(
//            height: 5,
//          ),
//          InfoFeesSection(
//            buyCommission: _profitNotifier.buyCommission,
//            sellCommission: _profitNotifier.sellCommission,
//            sharesQuantity: _profitNotifier.sharesQuantity,
//            purchasePrice: _profitNotifier.purchasePrice,
//            sellingPrice: _profitNotifier.sellingPrice,
//            spreadFee: _profitNotifier.spreadFee,
//          ),
//        ],
//      ),
//    );
//  }
//
//  _purchasePriceChanged(value) {
//    _profitNotifier.purchasePrice = double.parse(value);
//  }
//
//  _sellingPriceChanged(value) {
//    _profitNotifier.sellingPrice = double.parse(value);
//  }
//
//  _sharesQuantityChanged(value) {
//    _profitNotifier.sharesQuantity = int.parse(value);
//  }
//
//  _buyCommissionChanged(value) {
//    _profitNotifier.buyCommission = CommissionFee(double.parse(value), false);
//  }
//
//  _sellCommissionChanged(value) {
//    _profitNotifier.sellCommission = CommissionFee(double.parse(value), false);
//  }
//
//  _spreadFeesChanged(value) {
//    _profitNotifier.spreadFee = double.parse(value) / 100;
//  }
//
//  double _calculateProfit() {
//    return (_profitNotifier.sellingPrice * _profitNotifier.sharesQuantity) -
//        (_profitNotifier.purchasePrice * _profitNotifier.sharesQuantity) -
//        (_profitNotifier.sellingPrice > _profitNotifier.purchasePrice
//            ? _calculateTotalFees()
//            : _profitNotifier.buyCommission.value +
//                _profitNotifier.sellCommission.value);
//  }
//
//  double _calculateTotalFees() {
//    double spread =
//        (_profitNotifier.sellingPrice * _profitNotifier.sharesQuantity) -
//            (_profitNotifier.purchasePrice * _profitNotifier.sharesQuantity);
//    return _profitNotifier.buyCommission.value +
//        _profitNotifier.sellCommission.value +
//        (_profitNotifier.sellingPrice > _profitNotifier.purchasePrice
//            ? spread * _profitNotifier.spreadFee
//            : 0);
//  }
//}
