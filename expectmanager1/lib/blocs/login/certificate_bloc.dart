import "../../common/component_index.dart";
import '../../ui/pages/page_index.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CertificateBloc implements BlocBase {
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

  Future userAuthAction(
      String username, String userid, File fImg, File bImg) async {
    XsProgressHud.show(bloccontext);

    var fileAResult = await FlutterImageCompress.compressWithFile(
      fImg.absolute.path,
      minWidth: 1280,
      minHeight: 800,
      quality: 60,
      rotate: 0,
    );
    var fileBResult = await FlutterImageCompress.compressWithFile(
      bImg.absolute.path,
      minWidth: 1280,
      minHeight: 800,
      quality: 60,
      rotate: 0,
    );
    FormData userAuthReq = new FormData.from({
      "token": AppInstance.currentUser.token,
      "fileA": UploadFileInfo.fromBytes(fileAResult, "idfront.jpg"),
      "fileB": UploadFileInfo.fromBytes(fileBResult, "idback.jpg"),
      "name": username,
      "id": userid,
    });
    return netRepository.userAuth(userAuthReq).then((resp) {
      XsProgressHud.hide();
      FocusScope.of(bloccontext).requestFocus(FocusNode());
      if (resp.code == Constant.SUCCESS_CODE) {
        showToast("认证成功~");
        if (fromType == 1) {
          loginSwitch();
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
  void dispose() {}
}
