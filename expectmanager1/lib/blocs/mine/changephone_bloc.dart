import "../../common/component_index.dart";

class ChangePhoneBloc implements BlocBase {
  BuildContext bloccontext;

  Timer countdownTimer;
  int countdownNum = 60;

  NetRepository netRepository = NetRepository();

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

  Future changePhoneAction(String phoneNum, String code) async {
    XsProgressHud.show(bloccontext);
    return netRepository.changePhoneNum({
      'phone': phoneNum,
      'code': code,
      'token': AppInstance.currentUser.token
    }).then((resp) {
      XsProgressHud.hide();
      FocusScope.of(bloccontext).requestFocus(FocusNode());

      if (resp.code == Constant.SUCCESS_CODE) {
        showToast(resp.msg);
        countdownNum = 60;
        countdownTimer.cancel();
        countdownTimer = null;
        final ApplicationBloc applicationBloc =
            BlocProvider.of<ApplicationBloc>(bloccontext);
        applicationBloc.personalBackType = 1;
        Navigator.popUntil(
          bloccontext,
          ModalRoute.withName('MainPage'),
        );
      } else {
        showToast(resp.msg);
      }
    });
  }

  void showToast(String msg, {int duration, int gravity: 0}) {
    Toast.show(msg, bloccontext, duration: duration, gravity: gravity);
  }

  void dispose() {}
}
