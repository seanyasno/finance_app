import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/sections/section_inner_input.dart';
import 'package:flutter/material.dart';

class DesiredInputSection extends StatelessWidget {
  final ValueChanged<String> onSharePriceChanged;
  final ValueChanged<String> onDesiredProfitChanged;
  final ValueChanged<String> onSharesAmountChanged;

  DesiredInputSection(
    this.onSharePriceChanged,
    this.onDesiredProfitChanged,
    this.onSharesAmountChanged,
  );

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      inners: [
        SectionInnerInput('Purchase Price', onSharePriceChanged),
        SectionInnerInput('Desired Profit', onDesiredProfitChanged),
        SectionInnerInput('Shares Quantity', onSharesAmountChanged),
      ],
      gradientColors: [
        Color(0xFF38ef7d),
        Color(0xFF11998e),
      ],
    );
  }
}
