import 'package:finance_app/abstraction/section_inner_factory.dart';
import 'package:finance_app/models/section_inner_factory.dart';
import 'package:finance_app/abstraction/section_inner.dart';
import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final List<ISectionInner> inners;
  final List<Color> gradientColors;
  final ISectionInnerFactory sectionInnerFactory;
  final bool useVerticalPadding;
  final bool addChildrenPadding;

  SectionCard({
    @required this.inners,
    @required this.gradientColors,
    this.sectionInnerFactory = const SectionInnerFactory(),
    this.useVerticalPadding = true,
    this.addChildrenPadding = true,
  })  : assert(inners != null && inners.length > 0),
        assert(gradientColors != null && gradientColors.length > 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < inners.length - 1; i++) {
      widgets.add(sectionInnerFactory.generateWidget(inners[i]));
      if (addChildrenPadding) widgets.add(SizedBox(height: 10));
    }
    widgets.add(sectionInnerFactory.generateWidget(inners[inners.length - 1]));

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 15, vertical: useVerticalPadding ? 15 : 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: widgets,
        ),
      ),
    );
  }
}
