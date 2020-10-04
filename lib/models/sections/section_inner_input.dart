import 'package:finance_app/abstraction/section_inner.dart';
import 'package:finance_app/abstraction/section_inner_type.dart';
import 'package:flutter/cupertino.dart';

class SectionInnerInput implements ISectionInner<ValueChanged> {
  String _label;
  ValueChanged _value;

  SectionInnerInput(this._label, this._value);

  @override
  String get label => _label;

  @override
  ValueChanged get value => _value;

  @override
  List<ISectionInner> get children => [];

  @override
  SectionInnerType get type => SectionInnerType.INPUT;
}