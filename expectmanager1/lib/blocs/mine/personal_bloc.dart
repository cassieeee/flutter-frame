import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";
import '../../ui/pages/page_index.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class PersonalBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  BehaviorSubject<UserInfoModel> _getUserInfoController =
      BehaviorSubject<UserInfoModel>();
  Sink<UserInfoModel> get _getUserInfoSink => _getUserInfoController.sink;
  Stream<UserInfoModel> get getUserInfoStream => _getUserInfoController.stream;

  // BehaviorSubject<UserInfoModel> _editUserInfoController =
  //     BehaviorSubject<UserInfoModel>();
  // Sink<UserInfoModel> get _editUserInfoSink => _editUserInfoController.sink;
  // Stream<UserInfoModel> get editUserInfoStream =>
  //     _editUserInfoController.stream;

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
          _getUserInfoSink.add(UserInfoModel.fromJson(resp.data));
        }
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

  Future editUserInfoAction({
    String name,
    String sex,
    String birthDay,
    String provinces,
    String city,
    int roleType,
    File headIcon,
  }) async {
    XsProgressHud.show(bloccontext);
    Map<String, dynamic> userInfo = Map<String, dynamic>();
    userInfo['token'] = AppInstance.currentUser.token;
    if (name != null) userInfo['name'] = name;
    if (sex != null) userInfo['sex'] = sex;
    if (birthDay != null) userInfo['birthDay'] = birthDay;
    if (provinces != null) userInfo['provinces'] = provinces;
    if (city != null) userInfo['city'] = city;
    if (roleType != null) userInfo['roleType'] = roleType;
    if (headIcon != null) {
      var fileResult = await FlutterImageCompress.compressWithFile(
        headIcon.absolute.path,
        minWidth: 1280,
        minHeight: 800,
        quality: 60,
        rotate: 0,
      );
      userInfo['uploadfile'] =
          UploadFileInfo.fromBytes(fileResult, "headIcon.jpg");
    }

    FormData startManagerReq = FormData.from(userInfo);
    return netRepository.editUserInfo(startManagerReq).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        // if (resp.data != null) {
        //   _editUserInfoSink.add(UserInfoModel.fromJson(resp.data));
        // }
        getUserInfoAction();
        showToast('修改成功');
        if (headIcon != null || name != null) {
          final ApplicationBloc bloc =
              BlocProvider.of<ApplicationBloc>(bloccontext);
          bloc.personalBackType = 1;
        }
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

  void showToast(String msg, {int duration, int gravity: 0}) {
    Toast.show(msg, bloccontext, duration: duration, gravity: gravity);
  }

  @override
  void dispose() {
    // _editUserInfoController.close();
    _getUserInfoController.close();
  }
}
