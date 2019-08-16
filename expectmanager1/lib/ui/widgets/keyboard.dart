import 'package:flutter/material.dart';

/// 自定义密码 键盘
class MyKeyboard extends StatefulWidget {
  final callback;
  MyKeyboard({Key key, @required this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyKeyboardState();
}

class MyKeyboardState extends State<MyKeyboard> {
  /// 定义 确定 按钮 接口  暴露给调用方
  ///回调函数执行体
  var backMethod;
  void onCommitChange() {
    widget.callback(new KeyEvent("commit"));
  }

  void onOneChange(BuildContext cont) {
    widget.callback(new KeyEvent("1"));
  }

  void onTwoChange(BuildContext cont) {
    widget.callback(new KeyEvent("2"));
  }

  void onThreeChange(BuildContext cont) {
    widget.callback(new KeyEvent("3"));
  }

  void onFourChange(BuildContext cont) {
    widget.callback(new KeyEvent("4"));
  }

  void onFiveChange(BuildContext cont) {
    widget.callback(new KeyEvent("5"));
  }

  void onSixChange(BuildContext cont) {
    widget.callback(new KeyEvent("6"));
  }

  void onSevenChange(BuildContext cont) {
    widget.callback(new KeyEvent("7"));
  }

  void onEightChange(BuildContext cont) {
    widget.callback(new KeyEvent("8"));
  }

  void onNineChange(BuildContext cont) {
    widget.callback(new KeyEvent("9"));
  }

  void onZeroChange(BuildContext cont) {
    widget.callback(new KeyEvent("0"));
  }

  /// 点击删除
  void onDeleteChange() {
    widget.callback(new KeyEvent("del"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: <Widget>[
            Container(
            height:30.0,
            color: Colors.white,
            alignment: Alignment.center,
            child: new Text(
              '下滑隐藏',
              style: new TextStyle(fontSize: 12.0, color: Color(0xff999999)),
            ),
          ),
          ///  键盘主体
          Column(
            children: <Widget>[
              ///  第一行
              Row(
                children: <Widget>[
                  CustomKbBtn(
                      text: '1', callback: (val) => onOneChange(context)),
                  CustomKbBtn(
                      text: '2', callback: (val) => onTwoChange(context)),
                  CustomKbBtn(
                      text: '3', callback: (val) => onThreeChange(context)),
                ],
              ),

              ///  第二行
              Row(
                children: <Widget>[
                  CustomKbBtn(
                      text: '4', callback: (val) => onFourChange(context)),
                  CustomKbBtn(
                      text: '5', callback: (val) => onFiveChange(context)),
                  CustomKbBtn(
                      text: '6', callback: (val) => onSixChange(context)),
                ],
              ),

              ///  第三行
              Row(
                children: <Widget>[
                  CustomKbBtn(
                      text: '7', callback: (val) => onSevenChange(context)),
                  CustomKbBtn(
                      text: '8', callback: (val) => onEightChange(context)),
                  CustomKbBtn(
                      text: '9', callback: (val) => onNineChange(context)),
                ],
              ),

              ///  第四行
              Row(
                children: <Widget>[
                  CustomKbBtn(text: '删除', callback: (val) => onDeleteChange()),
                  CustomKbBtn(
                      text: '0', callback: (val) => onZeroChange(context)),
                  CustomKbBtn(text: '确定', callback: (val) => onCommitChange()),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

///  支符密码  用于 密码输入框和键盘之间进行通信
class KeyEvent {
  ///  当前点击的按钮所代表的值
  String key;
  KeyEvent(this.key);

  bool isDelete() => this.key == "del";
  bool isCommit() => this.key == "commit";
}

///  自定义 键盘 按钮
class CustomKbBtn extends StatefulWidget {
  ///  按钮显示的文本内容
  String text;

  CustomKbBtn({Key key, this.text, this.callback}) : super(key: key);

  ///  按钮 点击事件的回调函数
  final callback;
  @override
  State<StatefulWidget> createState() {
    return ButtonState();
  }
}

class ButtonState extends State<CustomKbBtn> {
  ///回调函数执行体
  var backMethod;

  void back() {
    widget.callback('$backMethod');
  }

  @override
  Widget build(BuildContext context) {
    /// 获取当前屏幕的总宽度，从而得出单个按钮的宽度
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var _screenWidth = mediaQuery.size.width;

    return new Container(
        height: 50.0,
        width: _screenWidth / 3,
        child: new OutlineButton(
          // 直角
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(0.0)),
          // 边框颜色
          borderSide: new BorderSide(color: Color(0x10333333)),
          child: new Text(
            widget.text,
            style: new TextStyle(color: Color(0xff333333), fontSize: 20.0),
          ),
          // 按钮点击事件
          onPressed: back,
        ));
  }
}
