import 'package:finance_app/abstraction/section_inner.dart';
import 'package:finance_app/models/types/section_inner_type.dart';

class SectionInnerInputCommission implements ISectionInner<Map<String, Object>> {
  final String _label;
  final Map<String, Object> _value;

  SectionInnerInputCommission(this._label, this._value);

  @override
  String get label => _label;

  @override
  get value => _value;

  @override
  List<ISectionInner> get children => [];

  @override
  SectionInnerType get type => SectionInnerType.INPUT_COMMISSION;

}