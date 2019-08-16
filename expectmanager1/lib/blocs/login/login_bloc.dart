import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";
import '../../ui/pages/page_index.dart';

import 'package:permission_handler/permission_handler.dart';

class LoginBloc implements BlocBase {
  int _counter = 60;
  TimerUtil _timerUtil;
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();
  //发送验证码
  BehaviorSubject<int> _counterController = BehaviorSubject<int>();
  StreamSink<int> get _inMinus => _counterController.sink;
  Stream<int> get outCounter => _counterController.stream;

  void sendCodeLogic() {
    if (_timerUtil == null) {
      _timerUtil = new TimerUtil(mTotalTime: _counter * 1000);
      _timerUtil.setOnTimerTickCallback((int tick) {
        double _tick = tick / 1000;
        _counter = _counter - 1;
        _inMinus.add(_counter);
        if (_tick == 0 && _timerUtil != null) {
          _timerUtil.cancel();
          _timerUtil = null;
          _counter = 60;
          return;
        }
      });
      _timerUtil.startCountDown();
    }
  }

  Future sendCodeAction(String phoneNum, int type) async {
    ValidCodeReq _validCodeReq = ValidCodeReq(phoneNum, type);
    XsProgressHud.show(bloccontext);
    return netRepository.getValidCode(_validCodeReq.toJson()).then((resp) {
      XsProgressHud.hide();
      FocusScope.of(bloccontext).requestFocus(FocusNode());
      if (resp.code == Constant.SUCCESS_CODE) {
        showToast("验证码已发送~");
      } else {
        showToast(resp.msg);
      }
    });
  }

  void loginSwitch() async {
    

    await PermissionHandler().requestPermissions([PermissionGroup.contacts]);

    int type = int.tryParse(AppInstance.currentUser.roleType);

    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(bloccontext);
    String themeColor =
        (type == 4 ? "capitalcolor" : type == 2 ? "managercolor" : "usercolor");
    AppInstance.putString(Constant.KEY_THEME_COLOR, themeColor);
    bloc.sendAppEvent(1);

    Widget mainPage = MainPage();
    Navigator.pushAndRemoveUntil(
      bloccontext,
      MaterialPageRoute(
        settings: RouteSettings(name: "MainPage"),
        builder: (BuildContext context) => mainPage,
      ),
      (Route<dynamic> route) => false,
    );
  }

  Future userLoginAction(String phoneNum, String code) async {
    AppInstance.putString("lastLoginAccount", phoneNum);

    UserSignInReq _userSignInReq = UserSignInReq(phoneNum, code);
    XsProgressHud.show(bloccontext);
    return netRepository.userLogin(_userSignInReq.toJson()).then((resp) {
      XsProgressHud.hide();
      FocusScope.of(bloccontext).requestFocus(FocusNode());

      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data["isFirstLogin"] == 1) {
          Alert(
            context: bloccontext,
            style: AlertStyle(isOverlayTapDismiss: false),
            type: AlertType.success,
            title: "操作成功",
            buttons: [
              DialogButton(
                child: Text(
                  "设置密码",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    bloccontext,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SetPwdPage(1),
                    ),
                  );
                },
                width: 120,
              ),
              DialogButton(
                child: Text(
                  "直接登录",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  loginSwitch();
                },
                width: 120,
              ),
            ],
          ).show();

          return;
        }

        if (resp.data["isFirstLogin"] == 0 &&
            AppInstance.currentUser.isCertification == "0") {
          Alert(
            context: bloccontext,
            style: AlertStyle(isOverlayTapDismiss: false),
            type: AlertType.success,
            title: "操作成功",
            buttons: [
              DialogButton(
                child: Text(
                  "进入认证",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    bloccontext,
                    MaterialPageRoute(
                      builder: (BuildContext context) => IdAuthPage(1),
                    ),
                  );
                },
                width: 120,
              ),
              DialogButton(
                child: Text(
                  "直接登录",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  loginSwitch();
                },
                width: 120,
              ),
            ],
          ).show();

          return;
        }
        loginSwitch();
      } else {
        showToast(resp.msg);
        return;
      }
    });
  }

  Future userLoginByPwd(String phoneNum, String pwd) async {
    AppInstance.putString("lastLoginAccount", phoneNum);

    UserLoginByPwd _userLoginByPwd = UserLoginByPwd(phoneNum, pwd);
    XsProgressHud.show(bloccontext);
    return netRepository.userLoginByPwd(_userLoginByPwd.toJson()).then((resp) {
      XsProgressHud.hide();
      FocusScope.of(bloccontext).requestFocus(FocusNode());

      if (resp.code == Constant.SUCCESS_CODE) {
        if (AppInstance.currentUser.isCertification == "0") {
          Alert(
            context: bloccontext,
            style: AlertStyle(isOverlayTapDismiss: false),
            type: AlertType.success,
            title: "操作成功",
            buttons: [
              DialogButton(
                child: Text(
                  "进入认证",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    bloccontext,
                    MaterialPageRoute(
                      builder: (BuildContext context) => IdAuthPage(1),
                    ),
                  );
                },
                width: 120,
              ),
              DialogButton(
                child: Text(
                  "直接登录",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  loginSwitch();
                },
                width: 120,
              ),
            ],
          ).show();
          return;
        }

        loginSwitch();
      } else {
        showToast(resp.msg);
      }
    });
  }

  void showToast(String msg, {int duration, int gravity: 0}) {
    Toast.show(msg, bloccontext, duration: duration, gravity: gravity);
  }

  void dispose() {
    if (_timerUtil != null) _timerUtil.cancel();
    _counterController.close();
  }
}
