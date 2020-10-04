import 'package:finance_app/abstraction/section_inner.dart';
import 'package:finance_app/abstraction/section_inner_type.dart';

class SectionInnerInfo implements ISectionInner<String> {
  final String _label;
  final String _value;

  SectionInnerInfo(this._label, this._value);

  @override
  String get label => _label;

  @override
  String get value => _value;

  @override
  List<ISectionInner> get children => [];

  @override
  SectionInnerType get type => SectionInnerType.INFO;
}