import "../../common/component_index.dart";


class FindPwdBloc implements BlocBase {
  int _counter;
  TimerUtil _timerUtil;
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  //发送验证码
  StreamController<int> _counterController = StreamController<int>.broadcast();
  StreamSink<int> get _inMinus => _counterController.sink;
  Stream<int> get outCounter => _counterController.stream;

  StreamController _sendCodeActionController = StreamController();
  StreamSink get decrementCounter => _sendCodeActionController.sink;

  // 构造器
  FindPwdBloc() {
    _counter = 60;
    _sendCodeActionController.stream.listen(_sendCodeLogic);
  }

  void _sendCodeLogic(data) {
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

  Future forgetPwdAction(String phoneNum, String code, String pwd) async {
    ForgetPwdReq _forgetPwdReq = ForgetPwdReq(phoneNum, pwd, code);
    XsProgressHud.show(bloccontext);
    return netRepository.forgetPwd(_forgetPwdReq.toJson()).then((resp) {
      XsProgressHud.hide();
      FocusScope.of(bloccontext).requestFocus(FocusNode());

      if (resp.code == Constant.SUCCESS_CODE) {
        showToast("修改成功，返回登录");
        Navigator.of(bloccontext).pop();
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
    _sendCodeActionController.close();
    _counterController.close();
  }
}
