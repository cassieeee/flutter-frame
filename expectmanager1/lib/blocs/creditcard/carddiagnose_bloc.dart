import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";

class CardDiagnoseBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  Map<String, dynamic> diagnoseData = Map<String, dynamic>();

  BehaviorSubject<Map<String, dynamic>> _cardDiagnoseController =
      BehaviorSubject<Map<String, dynamic>>();
  Sink<Map<String, dynamic>> get _cardDiagnoseSink =>
      _cardDiagnoseController.sink;
  Stream<Map<String, dynamic>> get cardDiagnoseStream =>
      _cardDiagnoseController.stream;

  Future cardDiagnoseInfo(String cardId, String sqTime, String sqLimit) {
    CardDiagnoseReq _cardDiagnoseReq =
        CardDiagnoseReq(AppInstance.currentUser.token, cardId, sqTime, sqLimit);
    XsProgressHud.show(bloccontext);

    return netRepository
        .cardDiagnoseInfo(_cardDiagnoseReq.toJson())
        .then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data != null) {
          if ((resp.data['code'] == 0) && resp.data['data'] != null) {
            diagnoseData = resp.data['data'];
            _cardDiagnoseSink.add(resp.data['data']);
          } else {
            showToast(resp.data['msg']);
          }
        }
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
    _cardDiagnoseController.close();
  }
}
