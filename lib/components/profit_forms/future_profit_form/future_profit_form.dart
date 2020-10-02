import 'package:finance_app/components/profit_sections/future_sections/future_share_section.dart';
import 'package:finance_app/components/profit_sections/info_sections/info_fees_section.dart';
import 'package:finance_app/components/profit_sections/info_sections/info_share_section.dart';
import 'package:finance_app/components/profit_sections/info_sections/info_sum_section.dart';
import 'package:finance_app/components/profit_sections/fees_section.dart';
import 'package:finance_app/components/profit_info/profit_info.dart';
import 'package:finance_app/models/commission_fee.dart';
import 'package:finance_app/notifiers/future_profit_form_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FutureProfitForm extends StatefulWidget {
  @override
  _FutureProfitFormState createState() => _FutureProfitFormState();
}

class _FutureProfitFormState extends State<FutureProfitForm>
    with AutomaticKeepAliveClientMixin<FutureProfitForm> {
  FutureProfitFormNotifier _profitNotifier;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    _profitNotifier = Provider.of<FutureProfitFormNotifier>(context);

    return Container(
      child: Column(
        children: [
          FutureShareSection(_currentSharePriceChanged, _desiredProfitChanged,
              _sharesAmountChanged),
          SizedBox(
            height: 5,
          ),
          FeesSection(
              _buyingFeeChanged, _sellingFeeChanged, _spreadFeesChanged),
          SizedBox(
            height: 5,
          ),
          InfoSumSection(
            purchasePrice: _profitNotifier.purchasePrice,
            sellingPrice: _getFutureSharePrice(),
            sharesQuantity: _profitNotifier.sharesQuantity,
            buyCommission: _profitNotifier.buyCommission,
            sellCommission: _profitNotifier.sellCommission,
          ),
          SizedBox(
            height: 5,
          ),
          InfoShareSection(
            purchasePrice: _profitNotifier.purchasePrice,
            sellingPrice: _getFutureSharePrice(),
            sharesQuantity: _profitNotifier.sharesQuantity,
            buyCommission: _profitNotifier.buyCommission,
            sellCommission: _profitNotifier.sellCommission,
            spreadFee: _profitNotifier.spreadFee,
            children: [
              ProfitInfo('Future Share Price',
                  NumberFormat().format(_getFutureSharePrice())),
              SizedBox(height: 10),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          InfoFeesSection(
            purchasePrice: _profitNotifier.purchasePrice,
            sellingPrice: _getFutureSharePrice(),
            sharesQuantity: _profitNotifier.sharesQuantity,
            buyCommission: _profitNotifier.buyCommission,
            sellCommission: _profitNotifier.sellCommission,
            spreadFee: _profitNotifier.spreadFee,
          ),
        ],
      ),
    );
  }

  _currentSharePriceChanged(value) {
    _profitNotifier.purchasePrice = double.parse(value);
  }

  _desiredProfitChanged(value) {
    _profitNotifier.desiredProfit = double.parse(value);
  }

  _buyingFeeChanged(value) {
    _profitNotifier.buyCommission = CommissionFee(double.parse(value), false);
  }

  _sellingFeeChanged(value) {
    _profitNotifier.sellCommission = CommissionFee(double.parse(value), false);
  }

  _spreadFeesChanged(value) {
    _profitNotifier.spreadFee = double.parse(value) / 100;
  }

  _sharesAmountChanged(value) {
    _profitNotifier.sharesQuantity = int.parse(value);
  }

  double _getFutureSharePrice() {
    return ((_profitNotifier.buyCommission.calculate() + _profitNotifier.sellCommission.calculate() + _profitNotifier.desiredProfit)) /
            ((1 - _profitNotifier.spreadFee) * _profitNotifier.sharesQuantity) +
        _profitNotifier.purchasePrice;
  }
}
