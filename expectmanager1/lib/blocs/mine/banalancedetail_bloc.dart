import 'package:rxdart/rxdart.dart';
import "../../common/component_index.dart";

class BanalanceDetailBloc implements BlocBase {
  BuildContext bloccontext;
  BehaviorSubject<List> _banalanceDetailController = BehaviorSubject<List>();
  Sink<List> get _banalanceDetailSink => _banalanceDetailController.sink;
  Stream<List> get banalanceDetailStream => _banalanceDetailController.stream;

  NetRepository netRepository = NetRepository();

  Future getBanalanceDetailAction({int page = 0}) async {
    XsProgressHud.show(bloccontext);
    return netRepository.getUserBanalanceDetail(
        {'token': AppInstance.currentUser.token, 'page': page}).then((resp) {
      XsProgressHud.hide();
      FocusScope.of(bloccontext).requestFocus(FocusNode());
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data != null) {
          _banalanceDetailSink.add(resp.data['usrIncomeList']);
          // dataList = resp.data['usrIncomeList'];
        } else {
          showToast(resp.msg);
        }
      } else {
        showToast(resp.msg);
      }
    });
  }

  void showToast(String msg, {int duration, int gravity: 0}) {
    Toast.show(msg, bloccontext, duration: duration, gravity: gravity);
  }

  void dispose() {
    _banalanceDetailController.close();
  }
}
