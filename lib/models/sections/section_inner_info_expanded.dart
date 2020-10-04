import 'package:finance_app/abstraction/section_inner.dart';
import 'package:finance_app/abstraction/section_inner_type.dart';

class SectionInnerInfoExpanded implements ISectionInner<String> {
  final String _label;
  final String _value;
  final List<ISectionInner> _children;

  SectionInnerInfoExpanded(this._label, this._value, this._children);

  @override
  String get label => _label;

  @override
  String get value => _value;

  @override
  List<ISectionInner> get children => _children;

  @override
  SectionInnerType get type => SectionInnerType.EXPANDED;
}