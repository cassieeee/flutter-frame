import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class ChangePhonePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangePhonePageState();
}

class ChangePhonePageState extends State<ChangePhonePage> {
  bool tryLogin = false;

  var phoneInputCtrl = TextEditingController();
  var codeInputCtrl = TextEditingController();
  ChangePhoneBloc changePhoneBloc = ChangePhoneBloc();

  void reGetCountdown() {
    setState(() {
      if (changePhoneBloc.countdownTimer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      changePhoneBloc.countdownNum--;
      changePhoneBloc.countdownTimer =
          new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (changePhoneBloc.countdownNum > 0) {
            changePhoneBloc.countdownNum--;
          } else {
            changePhoneBloc.countdownNum = 60;
            changePhoneBloc.countdownTimer.cancel();
            changePhoneBloc.countdownTimer = null;
          }
        });
      });
    });
  }

  bool showLoginBtn() {
    if (phoneInputCtrl.text.length == 11 && codeInputCtrl.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    changePhoneBloc.bloccontext = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          '更换手机号',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: BlocProvider<LoginBloc>(
        bloc: LoginBloc(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                height: 145 * Screen.screenRate,
                color: themeColorMap[
                    (AppInstance.getString(Constant.KEY_THEME_COLOR))],
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/images/splash/icon-1024.png',
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
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
                                hintText: '请输入新手机号码',
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
                                  tryLogin = showLoginBtn();
                                });
                              },
                            ),
                          ),
                          changePhoneBloc.countdownNum != 60
                              ? SizedBox(
                                  width: 120,
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                      "${changePhoneBloc.countdownNum}s后重新发送",
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
                                      // style:TextStyles.text14BlueMediumLabel,
                                      style: TextStyle(
                                        fontSize: Dimens.font_sp14,
                                        color: themeColorMap[
                                            (AppInstance.getString(
                                                Constant.KEY_THEME_COLOR))],
                                        fontWeight: FontWeights.medium,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (phoneInputCtrl.text.length == 11) {
                                        reGetCountdown();
                                        changePhoneBloc.sendCodeAction(
                                            phoneInputCtrl.text, 6);
                                      } else {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        changePhoneBloc.showToast("请输入合法的手机号码");
                                      }
                                    },
                                  ),
                                )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 99,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        textColor: Color(0xFFFFFFFF),
                        color: tryLogin
                            ? themeColorMap[(AppInstance.getString(
                                Constant.KEY_THEME_COLOR))]
                            : Color(0xFF666666),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: 245,
                          height: 40,
                          child: Text(
                            "确定",
                            style: TextStyles.text16WhiteMediumLabel,
                          ),
                        ),
                        onPressed: tryLogin
                            ? () {
                                changePhoneBloc.changePhoneAction(
                                    phoneInputCtrl.text, codeInputCtrl.text);
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (changePhoneBloc.countdownTimer != null &&
        changePhoneBloc.countdownTimer.isActive) {
      changePhoneBloc.countdownNum = 60;
      changePhoneBloc.countdownTimer.cancel();
      changePhoneBloc.countdownTimer = null;
    }
  }
}
