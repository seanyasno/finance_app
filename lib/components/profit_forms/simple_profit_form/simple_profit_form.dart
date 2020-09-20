import 'package:finance_app/components/profit_sections/info_sections/info_fees_section.dart';
import 'package:finance_app/components/profit_sections/info_sections/info_share_section.dart';
import 'package:finance_app/components/profit_sections/info_sections/info_sum_section.dart';
import 'package:finance_app/components/profit_sections/simple_sections/simple_share_section.dart';
import 'package:finance_app/components/profit_sections/fees_section.dart';
import 'package:finance_app/components/profit_info/profit_info.dart';
import 'package:finance_app/notifiers/ThemeTypeNotifier.dart';
import 'package:finance_app/models/types/theme_type.dart';
import 'package:finance_app/models/commission_fee.dart';
import 'package:provider/provider.dart';
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
    ThemeTypeNotifier themeTypeNotifier = Provider.of<ThemeTypeNotifier>(context);

    return Container(
      child: Column(
        children: [
          Text(themeTypeNotifier.themeType.toString()),
          RaisedButton(
            child: Text('change theme'),
            onPressed: () {
              if (themeTypeNotifier.themeType == ThemeType.LIGHT)
                themeTypeNotifier.themeType = ThemeType.DARK;
              else
                themeTypeNotifier.themeType = ThemeType.LIGHT;
            },
          ),
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
