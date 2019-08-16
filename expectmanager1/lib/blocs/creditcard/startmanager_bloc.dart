import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";

class StartManagerBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  // BehaviorSubject<List<AddCardListItem>> _startManagerController =
  //     BehaviorSubject<List<AddCardListItem>>();
  // Sink<List<AddCardListItem>> get _startManagerSink =>
  //     _startManagerController.sink;
  // Stream<List<AddCardListItem>> get startManagerStream =>
  //     _startManagerController.stream;

  Future startMangerAction(
      String masterNum, String cardIdList, num delegateType, File file) {
    XsProgressHud.show(bloccontext);
    Map<String, dynamic> reqMap = Map<String, dynamic>();
    reqMap['token'] = AppInstance.currentUser.token;
    reqMap['master'] = masterNum;
    reqMap['cardInstIdList'] = cardIdList;
    reqMap['delegateType'] = delegateType;
    if (file != null) reqMap['file'] = UploadFileInfo(file, "authReport.jpg");
    FormData startManagerReq = FormData.from(reqMap);
    return netRepository.startManager(startManagerReq).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        showToast(resp.msg);
        final ApplicationBloc applicationBloc =
            BlocProvider.of<ApplicationBloc>(bloccontext);
        applicationBloc.backType = 1;
        Navigator.of(bloccontext).pop();
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
    // _startManagerController.close();
  }
}
