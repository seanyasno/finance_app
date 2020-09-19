import 'package:finance_app/components/profit_sections/info_sections/info_fees_section.dart';
import 'package:finance_app/components/profit_sections/simple_sections/simple_share_section.dart';
import 'package:finance_app/components/profit_sections/total_info_section.dart';
import 'package:finance_app/components/profit_sections/fees_section.dart';
import 'package:finance_app/models/commission_fee.dart';
import 'package:flutter/material.dart';

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
            height: 15,
          ),
          FeesSection(_buyCommissionChanged, _sellCommissionChanged,
              _spreadFeesChanged),
          SizedBox(
            height: 15,
          ),
          InfoFeesSection(
            buyCommission: CommissionFee(_buyCommission, false),
            sellCommission: CommissionFee(_sellCommission, false),
            sharesQuantity: _sharesQuantity,
            purchasePrice: _purchasePrice,
            sellingPrice: _sellingPrice,
            spreadFee: _spreadFees,
          ),
//          TotalInfoSection(
//            purchasePrice: _purchasePrice,
//            sellingPrice: _sellingPrice,
//            sharesQuantity: _sharesQuantity,
//            spread: (_sellingPrice * _sharesQuantity) -
//                (_purchasePrice * _sharesQuantity),
//            buyCommission: _buyCommission,
//            sellCommission: _sellCommission,
//            spreadFees: _spreadFees,
//          ),
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
}
