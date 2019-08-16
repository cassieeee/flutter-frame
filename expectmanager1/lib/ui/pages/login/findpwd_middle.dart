import '../../../common/component_index.dart';

class FindPwdMiddle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FindPwdMiddleState();
}

class FindPwdMiddleState extends State<FindPwdMiddle> {
  bool openObs = true;
  bool openObs2 = true;
  bool tryLogin = false;
  var phoneInputCtrl = TextEditingController();
  var codeInputCtrl = TextEditingController();
  var pwdInputCtrl = TextEditingController();
  var pwd2InputCtrl = TextEditingController();
  FindPwdBloc findPwdBloc;

  @override
  Widget build(BuildContext context) {
    if (findPwdBloc == null) {
      findPwdBloc = BlocProvider.of<FindPwdBloc>(context);
      findPwdBloc.bloccontext = context;
    }
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            width: 343,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color(0xFF999999),
                width: 1.0,
              ),
              borderRadius: new BorderRadius.all(
                const Radius.circular(5.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 64,
                  child: Center(
                    child: Text(
                      "手机号",
                      style: TextStyles.text15MediumLabel,
                    ),
                  ),
                ),
                SizedBox(
                  width: 263,
                  child: TextField(
                    controller: phoneInputCtrl,
                    style: TextStyles.text15MediumLabel,
                    decoration: new InputDecoration(
                        hintText: '请输入您的手机号',
                        hintStyle: TextStyles.text15MediumPLabel,
                        border: InputBorder.none),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 343,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color(0xFF999999),
                width: 1.0,
              ),
              borderRadius: new BorderRadius.all(
                const Radius.circular(5.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 64,
                  child: Center(
                    child: Text(
                      "验证码",
                      style: TextStyles.text15MediumLabel,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: codeInputCtrl,
                    style: TextStyles.text15MediumLabel,
                    decoration: new InputDecoration(
                      hintText: '请输入验证码',
                      hintStyle: TextStyles.text15MediumPLabel,
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (str) {
                      setState(() {
                        // tryLogin = showLoginBtn();
                      });
                    },
                  ),
                ),
                StreamBuilder(
                  stream: findPwdBloc.outCounter,
                  // initialData: 0,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.hasData && snapshot.data > 0) {
                      return SizedBox(
                        width: 120,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "${snapshot.data}s后重新发送",
                            maxLines: 1,
                            style: TextStyles.text14MediumPLabel,
                          ),
                          onPressed: () {
                            // loginBloc.decrementCounter.add(null);
                          },
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: 100,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "发送验证码",
                            maxLines: 1,
                            style: TextStyles.text14BlueMediumLabel,
                          ),
                          onPressed: () {
                            if (phoneInputCtrl.text.length == 11) {
                              findPwdBloc.decrementCounter.add(null);
                              findPwdBloc.sendCodeAction(
                                  phoneInputCtrl.text, 3);
                            } else {
                              FocusScope.of(context).requestFocus(FocusNode());
                              findPwdBloc.showToast("请输入合法的手机号码");
                            }
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 343,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color(0xFF999999),
                width: 1.0,
              ),
              borderRadius: new BorderRadius.all(
                const Radius.circular(5.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80,
                  child: Center(
                    child: Text(
                      "设置密码",
                      style: TextStyles.text15MediumLabel,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: pwdInputCtrl,
                    style: TextStyles.text15MediumLabel,
                    decoration: new InputDecoration(
                        hintText: '请输入新密码(6~20个字符)',
                        hintStyle: TextStyles.text15MediumPLabel,
                        border: InputBorder.none),
                    obscureText: openObs,
                    keyboardType: openObs ? null : TextInputType.url,
                  ),
                ),
                Container(
                  width: 52,
                  height: 50,
                  child: FlatButton(
                    child: openObs
                        ? Image.asset('assets/images/user/obscure_close.png')
                        : Image.asset('assets/images/user/obscure_show.png'),
                    onPressed: () {
                      setState(() {
                        openObs = !openObs;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 343,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color(0xFF999999),
                width: 1.0,
              ),
              borderRadius: new BorderRadius.all(
                const Radius.circular(5.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80,
                  child: Center(
                    child: Text(
                      "确认密码",
                      style: TextStyles.text15MediumLabel,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: pwd2InputCtrl,
                    style: TextStyles.text15MediumLabel,
                    decoration: new InputDecoration(
                        hintText: '请重复输入新密码',
                        hintStyle: TextStyles.text15MediumPLabel,
                        border: InputBorder.none),
                    obscureText: openObs2,
                    keyboardType: openObs2 ? null : TextInputType.url,
                  ),
                ),
                Container(
                  width: 52,
                  height: 50,
                  child: FlatButton(
                    child: openObs2
                        ? Image.asset('assets/images/user/obscure_close.png')
                        : Image.asset('assets/images/user/obscure_show.png'),
                    onPressed: () {
                      setState(() {
                        openObs2 = !openObs2;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 245,
            height: 40,
            // padding: EdgeInsets.only(top: 99, left: 49, right: 49),
            child: RaisedButton(
              textColor: Color(0xFFFFFFFF),
              color: Color(0xFF666666),
              shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                "确认",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                if(phoneInputCtrl.text.length!=11)
                {
                  findPwdBloc.showToast("请输入合法手机号码");
                  return;
                }
                if(codeInputCtrl.text.length==0)
                {
                  findPwdBloc.showToast("请输入短信验证码");
                  return;
                }
                if(pwdInputCtrl.text.length==0)
                {
                  findPwdBloc.showToast("请输入登录密码");
                  return;
                }
                if(pwd2InputCtrl.text.length==0)
                {
                  findPwdBloc.showToast("请再次输入登录密码");
                  return;
                }
                if(pwdInputCtrl.text != pwd2InputCtrl.text)
                {
                  findPwdBloc.showToast("两次输入密码不一致");
                  return;
                }
                findPwdBloc.forgetPwdAction(phoneInputCtrl.text, codeInputCtrl.text, pwdInputCtrl.text);
                // //未注册，需要注册弹窗
                // showDialog<void>(
                //   context: context,
                //   barrierDismissible: true,
                //   builder: (BuildContext context) {
                //     return Center(
                //       child: Container(
                //         width: 250,
                //         height: 130,
                //         color: Colors.white,
                //         child: Center(
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: <Widget>[
                //               SizedBox(
                //                 height: 20,
                //               ),
                //               Text(
                //                 "您还未注册",
                //                 style: TextStyle(
                //                   fontSize: 16,
                //                   color: Color(0xFF121212),
                //                   decoration: TextDecoration.none,
                //                   fontWeight: FontWeight.w400,
                //                 ),
                //               ),
                //               Text(
                //                 "请先用验证码注册",
                //                 style: TextStyle(
                //                   fontSize: 16,
                //                   color: Color(0xFF121212),
                //                   decoration: TextDecoration.none,
                //                   fontWeight: FontWeight.w400,
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 16,
                //               ),
                //               Container(
                //                   height: 1, color: Colours.text_placehold),
                //               Container(
                //                 height: 45,
                //                 child: FlatButton(
                //                   child: Text(
                //                     '返回注册',
                //                     style: TextStyle(
                //                       color: Colours.blue_color,
                //                       fontSize: 16,
                //                     ),
                //                   ),
                //                   onPressed: () {
                //                     Navigator.pop(context);
                //                     Navigator.pop(context);
                //                   },
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // );

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => IdAuthPage(),
                //   ),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
