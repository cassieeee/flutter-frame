import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class LoginMiddle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginMiddleState();
}

class LoginMiddleState extends State<LoginMiddle> {
  int loginType = 1;
  bool openObs = true;
  bool tryLogin = false;
  var phoneInputCtrl = TextEditingController(
      text: AppInstance.getString('lastLoginAccount') ?? '');
  var codeInputCtrl = TextEditingController();
  var pwdInputCtrl = TextEditingController();

  Timer _countdownTimer;
  String _codeCountdownStr = '发送验证码';
  int _countdownNum = 60;

  void reGetCountdown() {
    setState(() {
      if (_countdownTimer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _codeCountdownStr = '${_countdownNum--}重新获取';
      _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownNum > 0) {
            _codeCountdownStr = '${_countdownNum--}重新获取';
          } else {
            _codeCountdownStr = '获取验证码';
            _countdownNum = 60;
            _countdownTimer.cancel();
            _countdownTimer = null;
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    loginBloc.bloccontext = context;

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
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (str) {
                      setState(() {
                        tryLogin = showLoginBtn();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          //用户验证码登录
          Offstage(
            offstage: loginType != 1,
            child: Container(
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
                          tryLogin = showLoginBtn();
                        });
                      },
                    ),
                  ),
                  _countdownNum != 60
                      ? SizedBox(
                          width: 120,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "${_countdownNum}s后重新发送",
                              maxLines: 1,
                              style: TextStyles.text14MediumPLabel,
                            ),
                            onPressed: () {},
                          ),
                        )
                      : SizedBox(
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
                                reGetCountdown();
                                loginBloc.sendCodeAction(
                                    phoneInputCtrl.text, 1);
                              } else {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                loginBloc.showToast("请输入合法的手机号码");
                              }
                            },
                          ),
                        )
                ],
              ),
            ),
          ),
          // 用户密码登录
          Offstage(
            offstage: loginType != 2,
            child: Container(
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
                        "输入密码",
                        style: TextStyles.text15MediumLabel,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: pwdInputCtrl,
                      style: TextStyles.text15MediumLabel,
                      decoration: new InputDecoration(
                        hintText: '请输入密码',
                        hintStyle: TextStyles.text15MediumPLabel,
                        border: InputBorder.none,
                      ),
                      obscureText: openObs,
                      keyboardType: openObs ? null : TextInputType.url,
                      onChanged: (str) {
                        setState(() {
                          tryLogin = showLoginBtn();
                        });
                      },
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                // color: Colors.red,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      const Radius.circular(5.0),
                    )),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "验证码错误",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.transparent,
                ),
              ),
              SizedBox(
                width: 50,
              ),
              FlatButton(
                child: Text(
                  loginType == 1 ? "" : "忘记密码",
                  maxLines: 1,
                  style: TextStyles.text12BlueMediumLabel,
                ),
                onPressed: loginType == 1
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => FindPwdPage(),
                          ),
                        );
                      },
              ),
              SizedBox(
                width: 16,
              ),
              FlatButton(
                child: Text(
                  loginType == 1 ? "使用密码登录" : "使用验证码登录",
                  maxLines: 1,
                  style: TextStyles.text12BlueMediumLabel,
                ),
                onPressed: () {
                  setState(() {
                    if (loginType == 1) {
                      loginType = 2;
                    } else {
                      loginType = 1;
                    }
                    tryLogin = showLoginBtn();
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 99,
          ),
          Container(
            alignment: Alignment.center,
            child: RaisedButton(
              textColor: Color(0xFFFFFFFF),
              color: tryLogin ? Colours.blue_color : Color(0xFF666666),
              shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Container(
                alignment: Alignment.center,
                width: 245,
                height: 40,
                child: Text(
                  "登录",
                  style: TextStyles.text16WhiteMediumLabel,
                ),
              ),
              onPressed: tryLogin
                  ? () {
                      if (loginType == 1) {
                        loginBloc.userLoginAction(
                            phoneInputCtrl.text, codeInputCtrl.text);
                      } else {
                        loginBloc.userLoginByPwd(
                            phoneInputCtrl.text, pwdInputCtrl.text);
                      }
                    }
                  : null,
            ),
          ),
          SizedBox(
            height: 26,
          ),
          Text(
            "未注册的用户可用验证码直接注册",
            style: TextStyles.text16BlueMediumLabel,
          ),
        ],
      ),
    );
  }

  bool showLoginBtn() {
    if ((phoneInputCtrl.text.length > 0 &&
            codeInputCtrl.text.length > 0 &&
            loginType == 1) ||
        (phoneInputCtrl.text.length > 0 &&
            pwdInputCtrl.text.length > 0 &&
            loginType == 2)) {
      return true;
    } else {
      return false;
    }
  }
}
