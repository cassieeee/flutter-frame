import 'package:flutter/cupertino.dart';

import '../../../common/component_index.dart';

class ChangePwdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangePwdPageState();
}

class ChangePwdPageState extends State<ChangePwdPage> {
  final TextEditingController oldPwdCtl = TextEditingController();
  final TextEditingController newPwdCtl = TextEditingController();
  final TextEditingController rnewPwdCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ModifyPwdBloc modifyPwdBloc = ModifyPwdBloc();
    modifyPwdBloc.bloccontext = context;
    return Scaffold(
      backgroundColor: Colours.background_color,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).accentColor,
        actions: <Widget>[
          Container(
            width: 70,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Text('完成', style: TextStyles.text16WhiteMediumLabel),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                if (oldPwdCtl.text.length == 0) {
                  modifyPwdBloc.showToast('请输入旧密码');
                  return;
                }
                if (newPwdCtl.text.length == 0) {
                  modifyPwdBloc.showToast('请输入新密码');
                  return;
                }
                if (rnewPwdCtl.text.length == 0) {
                  modifyPwdBloc.showToast('请再次输入新密码');
                  return;
                }
                if (newPwdCtl.text.length < 8) {
                  modifyPwdBloc.showToast('密码需至少8位');
                  return;
                }
                if (newPwdCtl.text != rnewPwdCtl.text) {
                  modifyPwdBloc.showToast('两次新密码输入不一致，请检查~');
                  return;
                }
                modifyPwdBloc.modifyPwdAction(oldPwdCtl.text, newPwdCtl.text);
              },
            ),
          ),
        ],
        title: Text(
          '修改密码',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 49,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    color: Colours.white_color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          '原密码',
                          style: TextStyles.text16MediumLabel,
                        ),
                        Container(
                          width: 200,
                          child: TextField(
                            controller: oldPwdCtl,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none,
                              hintText: '请输入旧密码',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 343,
                    height: 1,
                    color: Colours.background_color2,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 49,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    color: Colours.white_color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          '新密码',
                          style: TextStyles.text16MediumLabel,
                        ),
                        Container(
                          width: 200,
                          child: TextField(
                            controller: newPwdCtl,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none,
                              hintText: '请输入新密码',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 343,
                    height: 1,
                    color: Colours.background_color2,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    color: Colours.white_color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          '确认密码',
                          style: TextStyles.text16MediumLabel,
                        ),
                        Container(
                          width: 206,
                          child: TextField(
                            controller: rnewPwdCtl,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none,
                              hintText: '请再次输入新密码',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 45,
              alignment: Alignment.center,
              child: Text('密码必须至少8个字符，而且同时包含字母和数字。',
                  style: TextStyles.text14MediumLabel),
            ),
            Expanded(
              child: Container(
                color: Colours.background_color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
