import 'package:finance_app/components/profit_sections/info_sections/info_fees_section.dart';
import 'package:finance_app/components/profit_sections/info_sections/info_share_section.dart';
import 'package:finance_app/components/profit_sections/info_sections/info_sum_section.dart';
import 'package:finance_app/components/profit_sections/simple_sections/simple_share_section.dart';
import 'package:finance_app/components/profit_sections/fees_section.dart';
import 'package:finance_app/components/profit_info/profit_info.dart';
import 'package:finance_app/models/commission_fee.dart';
import 'package:finance_app/notifiers/simple_profit_form_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SimpleProfitForm extends StatefulWidget {
  @override
  _SimpleProfitFormState createState() => _SimpleProfitFormState();
}

class _SimpleProfitFormState extends State<SimpleProfitForm>
    with AutomaticKeepAliveClientMixin<SimpleProfitForm> {
  SimpleProfitFormNotifier _profitNotifier;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _profitNotifier = Provider.of<SimpleProfitFormNotifier>(context);

    return Container(
      child: Column(
        children: [
          SimpleShareSection(_purchasePriceChanged, _sellingPriceChanged,
              _sharesQuantityChanged),
          SizedBox(
            height: 5,
          ),
          FeesSection(
            _buyCommissionChanged,
            _sellCommissionChanged,
            _spreadFeesChanged,
            buyExtraWidget: Switch(
              activeColor: Colors.deepOrange[800],
              value: _profitNotifier.buyCommission.usePercentage,
              onChanged: (value) {
                _profitNotifier.buyCommission.usePercentage = value;
              },
            ),
            sellExtraWidget: Switch(
              activeColor: Colors.deepOrange[800],
              value: _profitNotifier.sellCommission.usePercentage,
              onChanged: (value) {
                _profitNotifier.sellCommission.usePercentage = value;
              },
            ),
            useBuyPercentage: _profitNotifier.buyCommission.usePercentage,
            useSellPercentage: _profitNotifier.sellCommission.usePercentage,
          ),
          SizedBox(
            height: 5,
          ),
          InfoSumSection(
            purchasePrice: _profitNotifier.purchasePrice,
            sellingPrice: _profitNotifier.sellingPrice,
            sharesQuantity: _profitNotifier.sharesQuantity,
            buyCommission: _profitNotifier.buyCommission,
            sellCommission: _profitNotifier.sellCommission,
          ),
          SizedBox(
            height: 5,
          ),
          InfoShareSection(
            purchasePrice: _profitNotifier.purchasePrice,
            sellingPrice: _profitNotifier.sellingPrice,
            sharesQuantity: _profitNotifier.sharesQuantity,
            buyCommission: _profitNotifier.buyCommission,
            sellCommission: _profitNotifier.sellCommission,
            spreadFee: _profitNotifier.spreadFee,
            children: [
              ProfitInfo(
                  'Profit / Loss', NumberFormat().format(_calculateProfit())),
              SizedBox(height: 10),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          InfoFeesSection(
            buyCommission: _profitNotifier.buyCommission,
            sellCommission: _profitNotifier.sellCommission,
            sharesQuantity: _profitNotifier.sharesQuantity,
            purchasePrice: _profitNotifier.purchasePrice,
            sellingPrice: _profitNotifier.sellingPrice,
            spreadFee: _profitNotifier.spreadFee,
          ),
        ],
      ),
    );
  }

  _purchasePriceChanged(value) {
    _profitNotifier.purchasePrice = double.parse(value);
  }

  _sellingPriceChanged(value) {
    _profitNotifier.sellingPrice = double.parse(value);
  }

  _sharesQuantityChanged(value) {
    _profitNotifier.sharesQuantity = int.parse(value);
  }

  _buyCommissionChanged(value) {
    _profitNotifier.buyCommission.value = double.parse(value);
  }

  _sellCommissionChanged(value) {
    _profitNotifier.sellCommission = CommissionFee(double.parse(value), false);
  }

  _spreadFeesChanged(value) {
    _profitNotifier.spreadFee = double.parse(value) / 100;
  }

  double _calculateProfit() {
    double purchaseValue = _profitNotifier.purchasePrice * _profitNotifier.sharesQuantity;

    return (_profitNotifier.sellingPrice * _profitNotifier.sharesQuantity) -
        (_profitNotifier.purchasePrice * _profitNotifier.sharesQuantity) -
        (_profitNotifier.sellingPrice > _profitNotifier.purchasePrice
            ? _calculateTotalFees()
            : _profitNotifier.buyCommission.calculate(data: purchaseValue) +
                _profitNotifier.sellCommission.calculate(data: purchaseValue));
  }

  double _calculateTotalFees() {
    double purchaseValue = _profitNotifier.purchasePrice * _profitNotifier.sharesQuantity;
    double spread =
        (_profitNotifier.sellingPrice * _profitNotifier.sharesQuantity) -
            (_profitNotifier.purchasePrice * _profitNotifier.sharesQuantity);
    return _profitNotifier.buyCommission.calculate(data: purchaseValue) +
        _profitNotifier.sellCommission.calculate(data: purchaseValue) +
        (_profitNotifier.sellingPrice > _profitNotifier.purchasePrice
            ? spread * _profitNotifier.spreadFee
            : 0);
  }

  @override
  bool get wantKeepAlive => true;
}
