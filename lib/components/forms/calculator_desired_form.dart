import 'package:finance_app/components/forms/sections/info/info_desired_share_section.dart';
import 'package:finance_app/components/forms/sections/info/info_fees_section.dart';
import 'package:finance_app/components/forms/sections/info/info_sum_section.dart';
import 'package:finance_app/components/forms/sections/input/desired_input_section.dart';
import 'package:finance_app/components/forms/sections/input/fees_input_section.dart';
import 'package:finance_app/models/data/commissions-data.dart';
import 'package:finance_app/models/data/shares-data.dart';
import 'package:finance_app/models/data/transaction-sum-data.dart';
import 'package:finance_app/notifiers/calculators/calculator_desired_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorDesiredForm extends StatefulWidget {
  CalculatorDesiredForm({Key key}) : super(key: key);

  @override
  _CalculatorDesiredFormState createState() => _CalculatorDesiredFormState();
}

class _CalculatorDesiredFormState extends State<CalculatorDesiredForm>
    with AutomaticKeepAliveClientMixin {
  CalculatorDesiredNotifier _profitNotifier;

  TransactionSumData _transactionSumData;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _profitNotifier = Provider.of<CalculatorDesiredNotifier>(context);
    _transactionSumData = TransactionSumData(
      SharesData(_profitNotifier.purchasePrice, _getFutureSharePrice(),
          _profitNotifier.sharesQuantity),
      CommissionsData(_profitNotifier.buyCommission,
          _profitNotifier.sellCommission, _profitNotifier.spreadFee),
    );

    return Container(
      child: Column(
        children: [
          DesiredInputSection(
            (value) => _profitNotifier.purchasePrice = double.parse(value),
            (value) => _profitNotifier.desiredProfit = double.parse(value),
            (value) => _profitNotifier.sharesQuantity = int.parse(value),
          ),
          SizedBox(
            height: 5,
          ),
          FeesInputSection(
            onBuyingFeeChanged: (value) => _profitNotifier.buyCommission.value = double.parse(value),
            onSellingFeeChanged: (value) => _profitNotifier.sellCommission.value = double.parse(value),
            onSpreadFeeChanged: (value) => _profitNotifier.spreadFee = double.parse(value) / 100,
            useBuyPercentage: _profitNotifier.buyCommission.usePercentage,
            useSellPercentage: _profitNotifier.sellCommission.usePercentage,
            useBuyPercentageChanged: (value) => _profitNotifier.buyCommission.usePercentage = value,
            useSellPercentageChanged: (value) => _profitNotifier.sellCommission.usePercentage = value,
          ),
          SizedBox(
            height: 5,
          ),
          InfoSumSection(
            transactionSumData: _transactionSumData,
          ),
          SizedBox(
            height: 5,
          ),
          InfoDesiredShareSection(
            transactionSumData: _transactionSumData,
          ),
          SizedBox(
            height: 5,
          ),
          InfoFeesSection(
            transactionSumData: _transactionSumData,
          ),
        ],
      ),
    );
  }

  double _getFutureSharePrice() {
    double purchaseValue =
        _profitNotifier.purchasePrice * _profitNotifier.sharesQuantity;

    var futureSellingPriceWithSellPercentage = (((_profitNotifier.buyCommission.calculate(data: purchaseValue) +
                    _profitNotifier.desiredProfit) /
                _profitNotifier.sharesQuantity) +
            (_profitNotifier.purchasePrice * (1 - _profitNotifier.spreadFee))) /
        (1 -
            _profitNotifier.spreadFee -
            (_profitNotifier.sellCommission.value / 100));


    var futureSharePrice = (_profitNotifier.buyCommission.calculate(data: purchaseValue) +
        _profitNotifier.sellCommission.calculate(data: futureSellingPriceWithSellPercentage * _profitNotifier.sharesQuantity) +
        _profitNotifier.desiredProfit) /
        ((1 - _profitNotifier.spreadFee) * _profitNotifier.sharesQuantity) +
        _profitNotifier.purchasePrice;

    return futureSharePrice;
  }

  @override
  bool get wantKeepAlive => true;
}
