import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";

class CreditDiagnoseBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  BehaviorSubject<DiagnoseCardInfo> _diagnoseInfoController =
      BehaviorSubject<DiagnoseCardInfo>();
  Sink<DiagnoseCardInfo> get _diagnoseInfoSink => _diagnoseInfoController.sink;
  Stream<DiagnoseCardInfo> get diagnoseInfoStream =>
      _diagnoseInfoController.stream;

  Future getDiagnoseCardInfo() {
    XsProgressHud.show(bloccontext);

    return netRepository.getDiagnoseCardInfo({
      "token": AppInstance.currentUser.token,
    }).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data != null)
          _diagnoseInfoSink.add(DiagnoseCardInfo.fromJson(resp.data));
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
    _diagnoseInfoController.close();
  }
}
