import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:youxinbao/common/component_index.dart';

class FlexiblePanel extends StatefulWidget {
  final Widget headerBuilder;
  final Widget body;
  final int itemCount;
  final int index;
  FlexiblePanel({
    Key key,
    @required this.headerBuilder,
    @required this.body,
    @required this.itemCount,
    @required this.index,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _FlexiblePanel();
}

class _FlexiblePanel extends State<FlexiblePanel>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool isCanClick = true; //判断动画是否还在进行。
  List data = List(); //列表折叠块是否显隐
  initState() {
    super.initState();
    for (int i = 0; i < widget.itemCount; i++) {
      data.add(false);
    }

    controller = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.ease);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isCanClick = true;
        this.setState(() {
          data[widget.index] = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        isCanClick = true;
        this.setState(() {
          data[widget.index] = false;
        });
      } else {
        isCanClick = false;
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Column(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (isCanClick) {
                if (!data[widget.index]) {
                  controller.forward();
                } else {
                  controller.reverse();
                }
              }
            },
            child: widget.headerBuilder,
          ),
          FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 0.0))
                      .animate(animation),
              child: Offstage(
                offstage: !data[widget.index],
                child: widget.body,
              ),
            ),
          ),
        ],
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
