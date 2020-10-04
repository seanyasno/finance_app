import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/sections/section_inner_input.dart';
import 'package:flutter/material.dart';

class SimpleInputSection extends StatelessWidget {
  final ValueChanged<String> onPurchasePriceChanged;
  final ValueChanged<String> onSellingPriceChanged;
  final ValueChanged<String> onShareQuantityChanged;

  SimpleInputSection(
    this.onPurchasePriceChanged,
    this.onSellingPriceChanged,
    this.onShareQuantityChanged,
  );

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      inners: [
        SectionInnerInput('Purchase Price', onPurchasePriceChanged),
        SectionInnerInput('Selling Price', onSellingPriceChanged),
        SectionInnerInput('Shares Quantity', onShareQuantityChanged),
      ],
      gradientColors: [
        Color(0xFF38ef7d),
        Color(0xFF11998e),
      ],
    );
  }
}
