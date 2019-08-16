import "../../common/component_index.dart";
import '../../ui/pages/page_index.dart';

import 'package:permission_handler/permission_handler.dart';

class SetPwdBloc implements BlocBase {
  BuildContext bloccontext;
  int fromType = 0;
  NetRepository netRepository = NetRepository();

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

  Future setPwdAction(String password) async {
    UserSetPwdReq _userSetPwdReq =
        UserSetPwdReq(AppInstance.currentUser.token, password);
    XsProgressHud.show(bloccontext);
    return netRepository.setPwd(_userSetPwdReq.toJson()).then((resp) {
      XsProgressHud.hide();
      FocusScope.of(bloccontext).requestFocus(FocusNode());
      if (resp.code == Constant.SUCCESS_CODE) {
        showToast("密码设置成功~");
        UserModel userModel = UserModel.fromJson(AppInstance.getObject('user'));
        userModel.isFirstLogin = '0';
        AppInstance.putObject("user", userModel.toJson());
        if (fromType == 1) {
          if (AppInstance.currentUser.isCertification == "0") {
            Navigator.push(
              bloccontext,
              MaterialPageRoute(
                builder: (BuildContext context) => IdAuthPage(1),
              ),
            );
          } else {
            loginSwitch();
          }
        }
        if (fromType == 2) {
          Navigator.popUntil(
            bloccontext,
            ModalRoute.withName('MainPage'),
          );
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
    // TODO: implement dispose
  }
}
