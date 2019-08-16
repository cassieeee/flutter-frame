import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";

class ModifyPwdBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  // BehaviorSubject<int> _modifyPwdController = BehaviorSubject<int>();
  // Sink<int> get _modifyPwdSink => _modifyPwdController.sink;
  // Stream<int> get modifyPwdStream => _modifyPwdController.stream;

  Future modifyPwdAction(String oldPwd, String newPwd) {
    XsProgressHud.show(bloccontext);

    return netRepository.modifyPwd({
      'token': AppInstance.currentUser.token,
      'originPassword': oldPwd,
      'newPassword': newPwd
    }).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        showToast('修改成功');
        Navigator.of(bloccontext).pop();
        // _modifyPwdSink.add(1);
      } else {
        showToast(resp.msg);
      }
    });
  }

  void showToast(String msg, {int duration, int gravity: 0}) {
    Toast.show(msg, bloccontext, duration: duration, gravity: gravity);
  }

  @override
  void dispose() {
    // _modifyPwdController.close();
  }
}
