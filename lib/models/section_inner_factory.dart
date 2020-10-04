import 'package:finance_app/components/forms/section_cards/section_inner_info_expanded.dart';
import 'package:finance_app/components/forms/section_cards/section_inner_info.dart';
import 'package:finance_app/abstraction/section_inner_factory.dart';
import 'package:finance_app/abstraction/section_inner.dart';
import 'package:finance_app/components/forms/section_cards/section_inner_input.dart';
import 'package:finance_app/models/types/section_inner_type.dart';
import 'package:flutter/material.dart';

class SectionInnerFactory implements ISectionInnerFactory {
  const SectionInnerFactory();

  @override
  Widget generateWidget(ISectionInner inner) {
    switch (inner.type) {
      case SectionInnerType.INFO:
        return SectionInnerInfo(inner.label, inner.value);
      case SectionInnerType.EXPANDED:
        return SectionInnerInfoExpanded(
          label: inner.label,
          value: inner.value,
          innerInfos: inner.children,
        );
      case SectionInnerType.INPUT:
        return SectionInnerInput(
          label: inner.label,
          onChangeCallback: inner.value,
        );
      default:
        return Container();
    }
  }
}
