import 'package:finance_app/abstraction/section_inner_factory.dart';
import 'package:finance_app/models/section_inner_factory.dart';
import 'package:finance_app/abstraction/section_inner.dart';
import 'package:flutter/material.dart';

class SectionInnerInfoExpanded extends StatefulWidget {
  final String label;
  final String value;
  final List<ISectionInner> innerInfos;
  final ISectionInnerFactory sectionInnerFactory;

  SectionInnerInfoExpanded(
      {Key key,
      @required this.label,
      @required this.value,
      @required this.innerInfos,
      this.sectionInnerFactory = const SectionInnerFactory()})
      : assert(label != null),
        assert(value != null),
        assert(innerInfos != null && innerInfos.length > 0),
        super(key: key);

  @override
  _SectionInnerInfoExpandedState createState() =>
      _SectionInnerInfoExpandedState();
}

class _SectionInnerInfoExpandedState extends State<SectionInnerInfoExpanded>
    with SingleTickerProviderStateMixin {
  Duration _kExpand = Duration(milliseconds: 200);

  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  AnimationController _controller;
  Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < widget.innerInfos.length - 1; i++) {
      widgets
          .add(widget.sectionInnerFactory.generateWidget(widget.innerInfos[i]));
      widgets.add(SizedBox(height: 10));
    }
    widgets.add(widget.sectionInnerFactory
        .generateWidget(widget.innerInfos[widget.innerInfos.length - 1]));

    return Container(
      child: ListTileTheme(
        dense: true,
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )
            ],
          ),
          trailing: RotationTransition(
            turns: _iconTurns,
            child: const Icon(
              Icons.expand_more,
              color: Colors.white,
            ),
          ),
          tilePadding: EdgeInsets.all(0),
          childrenPadding: EdgeInsets.only(bottom: 10),
          expandedAlignment: Alignment.center,
          onExpansionChanged: (expanded) {
            if (expanded) {
              _controller.forward();
            } else {
              _controller.reverse().then<void>((void value) {
                if (!mounted) return;
              });
            }
          },
          children: widgets,
        ),
      ),
    );
  }
}
