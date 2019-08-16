import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";
import '../../ui/pages/page_index.dart';

class RoleChangeBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  BehaviorSubject<int> _editUserInfoController = BehaviorSubject<int>();
  Sink<int> get _editUserInfoSink => _editUserInfoController.sink;
  Stream<int> get editUserInfoStream => _editUserInfoController.stream;

  Future editUserInfoAction({
    String name,
    String sex,
    String birthDay,
    String provinces,
    String city,
    int roleType,
  }) {
    Map<String, dynamic> userInfo = Map<String, dynamic>();
    userInfo['token'] = AppInstance.currentUser.token;
    if (name != null) userInfo['name'] = name;
    if (sex != null) userInfo['sex'] = sex;
    if (birthDay != null) userInfo['birthDay'] = birthDay;
    if (provinces != null) userInfo['provinces'] = provinces;
    if (city != null) userInfo['city'] = city;
    if (roleType != null) userInfo['roleType'] = roleType;

    XsProgressHud.show(bloccontext);

    return netRepository.editUserInfo(userInfo).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        if (roleType != null) {
          UserModel userModel =
              UserModel.fromJson(AppInstance.getObject('user'));
          userModel.roleType = roleType.toString();
          AppInstance.putObject("user", userModel.toJson());
          Navigator.pushReplacementNamed(bloccontext, '/splash');
        } else {
          _editUserInfoSink.add(1);
        }
        showToast('操作成功');
      } else {
        if (resp.code == 50008) {
          Navigator.pushReplacement(bloccontext,
              MaterialPageRoute<void>(builder: (ctx) => LoginPage()));
          AppInstance.putString(Constant.KEY_THEME_COLOR, 'usercolor');
          final ApplicationBloc bloc =
              BlocProvider.of<ApplicationBloc>(bloccontext);
          bloc.sendAppEvent(1);
        }
        showToast(resp.msg);
      }
    });
  }

  Future upgradeUser(int roleType) {
    XsProgressHud.show(bloccontext);
    return netRepository.userUpgrade({
      "token": AppInstance.currentUser.token,
      "roleType": roleType,
    }).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        showToast(resp.msg);
        if (roleType == 2) AppInstance.putInt('upgradeM', 1);
        if (roleType == 4) AppInstance.putInt('upgradeC', 1);
      } else {
        if (resp.code == 50008) {
          Navigator.pushReplacement(bloccontext,
              MaterialPageRoute<void>(builder: (ctx) => LoginPage()));
          AppInstance.putString(Constant.KEY_THEME_COLOR, 'usercolor');
          final ApplicationBloc bloc =
              BlocProvider.of<ApplicationBloc>(bloccontext);
          bloc.sendAppEvent(1);
        }
        if (resp.code == 60003) {
          if (roleType == 2) AppInstance.putInt('upgradeM', 1);
          if (roleType == 4) AppInstance.putInt('upgradeC', 1);
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
    _editUserInfoController.close();
  }
}
