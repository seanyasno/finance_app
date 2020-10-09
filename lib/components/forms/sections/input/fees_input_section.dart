import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/sections/section_inner_input.dart';
import 'package:finance_app/models/sections/section_inner_input_commission.dart';
import 'package:flutter/material.dart';

class FeesInputSection extends StatelessWidget {
  final ValueChanged onBuyingFeeChanged;
  final ValueChanged onSellingFeeChanged;
  final ValueChanged onSpreadFeeChanged;

  final ValueChanged useBuyPercentageChanged;
  final ValueChanged useSellPercentageChanged;

  final bool useBuyPercentage;
  final bool useSellPercentage;

  FeesInputSection({
    Key key,
    @required this.onBuyingFeeChanged,
    @required this.onSellingFeeChanged,
    @required this.onSpreadFeeChanged,
    this.useBuyPercentageChanged,
    this.useSellPercentageChanged,
    this.useBuyPercentage,
    this.useSellPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      inners: [
        SectionInnerInputCommission('Buy Commission${useBuyPercentage == true ? ' (%)' : ''}', {
          'toggleValue': useBuyPercentage,
          'toggleChanged': useBuyPercentageChanged,
          'inputChanged': onBuyingFeeChanged,
        }),
        SectionInnerInputCommission('Sell Commission${useSellPercentage == true ? ' (%)' : ''}', {
          'toggleValue': useSellPercentage,
          'toggleChanged': useSellPercentageChanged,
          'inputChanged': onSellingFeeChanged,
        }),
        SectionInnerInput('Spread Fee (%)', onSpreadFeeChanged),
      ],
      gradientColors: [
        Color(0xFFeea849),
        Color(0xFFf46b45),
      ],
    );
  }
}
