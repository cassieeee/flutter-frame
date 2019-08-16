import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";
import '../../ui/pages/page_index.dart';

class MineBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  BehaviorSubject<UserInfoModel> _mineController =
      BehaviorSubject<UserInfoModel>();
  Sink<UserInfoModel> get _mineSink => _mineController.sink;
  Stream<UserInfoModel> get mineStream => _mineController.stream;

  BehaviorSubject<List<Map<String, dynamic>>> _myMasterController =
      BehaviorSubject<List<Map<String, dynamic>>>();
  Sink<List<Map<String, dynamic>>> get _myMasterSink =>
      _myMasterController.sink;
  Stream<List<Map<String, dynamic>>> get myMasterStream =>
      _myMasterController.stream;

  void getInfos() {
    getUserInfoAction();
    getMyMasterListsAction();
  }

  Future getUserInfoAction() {
    XsProgressHud.show(bloccontext);

    return netRepository
        .getUserInfo({'token': AppInstance.currentUser.token}).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data != null) {
          UserModel userModel =
              UserModel.fromJson(AppInstance.getObject('user'));
          userModel.isCertification = resp.data['isCertification'].toString();
          userModel.privilegeList = resp.data['privilegeList'];
          AppInstance.putObject("user", userModel.toJson());
          _mineSink.add(UserInfoModel.fromJson(resp.data));
        }
      } else {
        if (resp.code == 50008) {
          Navigator.pushReplacement(bloccontext,
              MaterialPageRoute<void>(builder: (ctx) => LoginPage()));
        }
        showToast(resp.msg);
      }
    });
  }

  Future getMyMasterListsAction() {
    XsProgressHud.show(bloccontext);

    return netRepository.getMyMasterLists(
        {'token': AppInstance.currentUser.token}).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data != null) {
          _myMasterSink
              .add(resp.data['dataList'].cast<Map<String, dynamic>>().toList());
        } else {
          showToast(resp.msg);
        }
      } else {
        if (resp.code == 50008) {
          Navigator.pushReplacement(bloccontext,
              MaterialPageRoute<void>(builder: (ctx) => LoginPage()));
        }
        showToast(resp.msg);
      }
    });
  }

  void showToast(String msg, {int duration, int gravity: 0}) {
    Toast.show(msg, bloccontext, duration: duration, gravity: gravity);
  }

  @override
  void dispose() {
    _mineController.close();
    _myMasterController.close();
  }
}
