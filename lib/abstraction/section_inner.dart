
import 'package:finance_app/models/types/section_inner_type.dart';

abstract class ISectionInner<T> {
  String get label;
  T get value;
  SectionInnerType get type;
  List<ISectionInner> get children;
}