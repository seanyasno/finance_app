import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandedProfitInfo extends StatefulWidget {
  final String title;
  final String titleValue;
  final List<Widget> children;

  ExpandedProfitInfo({this.title, this.titleValue, this.children});

  @override
  _ExpandedProfitInfoState createState() => _ExpandedProfitInfoState();
}

class _ExpandedProfitInfoState extends State<ExpandedProfitInfo>
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
    return Container(
      child: ListTileTheme(
        dense: true,
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                widget.titleValue,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
          children: widget.children ?? [],
        ),
      ),
    );
  }
}
