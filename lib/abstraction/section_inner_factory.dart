import 'package:finance_app/abstraction/section_inner.dart';
import 'package:flutter/material.dart';

abstract class ISectionInnerFactory {
  Widget generateWidget(ISectionInner inner);
}