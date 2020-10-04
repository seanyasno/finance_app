import 'package:finance_app/components/forms/sections/info/info_desired_share_section.dart';
import 'package:finance_app/components/forms/sections/info/info_fees_section.dart';
import 'package:finance_app/components/forms/sections/info/info_sum_section.dart';
import 'package:finance_app/components/forms/sections/input/desired_input_section.dart';
import 'package:finance_app/components/forms/sections/input/fees_input_section.dart';
import 'package:finance_app/models/data/commissions-data.dart';
import 'package:finance_app/models/data/shares-data.dart';
import 'package:finance_app/notifiers/future_profit_form_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorDesiredForm extends StatefulWidget {
  @override
  _CalculatorDesiredFormState createState() => _CalculatorDesiredFormState();
}

class _CalculatorDesiredFormState extends State<CalculatorDesiredForm>
    with AutomaticKeepAliveClientMixin {
  FutureProfitFormNotifier _profitNotifier;

  SharesData _sharesData;
  CommissionsData _commissionsData;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _profitNotifier = Provider.of<FutureProfitFormNotifier>(context);
    _sharesData = SharesData(_profitNotifier.purchasePrice,
        _getFutureSharePrice(), _profitNotifier.sharesQuantity);
    _commissionsData = CommissionsData(_profitNotifier.buyCommission,
        _profitNotifier.sellCommission, _profitNotifier.spreadFee);

    return Container(
      child: Column(
        children: [
          DesiredInputSection(
            _purchasePriceChanged,
            _desiredProfitChanged,
            _sharesQuantityChanged,
          ),
          SizedBox(
            height: 5,
          ),
          FeesInputSection(
            onBuyingFeeChanged: _buyCommissionChanged,
            onSellingFeeChanged: _sellCommissionChanged,
            onSpreadFeeChanged: _spreadFeesChanged,
          ),
          SizedBox(
            height: 5,
          ),
          InfoSumSection(
            sharesData: _sharesData,
            commissionsData: _commissionsData,
          ),
          SizedBox(
            height: 5,
          ),
          InfoDesiredShareSection(
            sharesData: _sharesData,
            commissionsData: _commissionsData,
          ),
          SizedBox(
            height: 5,
          ),
          InfoFeesSection(
            sharesData: _sharesData,
            commissionsData: _commissionsData,
          ),
        ],
      ),
    );
  }

  _purchasePriceChanged(value) {
    _profitNotifier.purchasePrice = double.parse(value);
  }

  _desiredProfitChanged(value) {
    _profitNotifier.desiredProfit = double.parse(value);
  }

  _sharesQuantityChanged(value) {
    _profitNotifier.sharesQuantity = int.parse(value);
  }

  _buyCommissionChanged(value) {
    _profitNotifier.buyCommission.value = double.parse(value);
  }

  _sellCommissionChanged(value) {
    _profitNotifier.sellCommission.value = double.parse(value);
  }

  _spreadFeesChanged(value) {
    _profitNotifier.spreadFee = double.parse(value) / 100;
  }

  double _getFutureSharePrice() {
    double purchaseValue =
        _profitNotifier.purchasePrice * _profitNotifier.sharesQuantity;

    return ((_profitNotifier.buyCommission.calculate(data: purchaseValue) +
                _profitNotifier.sellCommission.calculate(data: purchaseValue) +
                _profitNotifier.desiredProfit)) /
            ((1 - _profitNotifier.spreadFee) * _profitNotifier.sharesQuantity) +
        _profitNotifier.purchasePrice;
  }

  @override
  bool get wantKeepAlive => true;
}
