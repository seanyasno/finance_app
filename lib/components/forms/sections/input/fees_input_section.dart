import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/sections/section_inner_input.dart';
import 'package:flutter/material.dart';

class FeesInputSection extends StatelessWidget {
  final ValueChanged onBuyingFeeChanged;
  final ValueChanged onSellingFeeChanged;
  final ValueChanged onSpreadFeeChanged;

  final Widget buyExtraWidget;
  final Widget sellExtraWidget;

  final bool useBuyPercentage;
  final bool useSellPercentage;

  FeesInputSection({
    @required this.onBuyingFeeChanged,
    @required this.onSellingFeeChanged,
    @required this.onSpreadFeeChanged,
    this.buyExtraWidget,
    this.sellExtraWidget,
    this.useBuyPercentage,
    this.useSellPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      inners: [
        SectionInnerInput('Buy Commission${useBuyPercentage == true ? ' (%)' : ''}', onBuyingFeeChanged),
        SectionInnerInput('Sell Commission${useSellPercentage == true ? ' (%)' : ''}', onSellingFeeChanged),
        SectionInnerInput('Spread Fee (%)', onSpreadFeeChanged),
      ],
      gradientColors: [
        Color(0xFFeea849),
        Color(0xFFf46b45),
      ],
    );
  }
}
