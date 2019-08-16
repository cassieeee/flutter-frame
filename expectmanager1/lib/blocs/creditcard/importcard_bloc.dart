import 'dart:math';

import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";
import '../../ui/pages/page_index.dart';

class ImportCardBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  TextEditingController phoneCtl = TextEditingController();

  // BehaviorSubject<List<AddCardListItem>> _importCardController =
  //     BehaviorSubject<List<AddCardListItem>>();
  // Sink<List<AddCardListItem>> get _importCardSink => _importCardController.sink;
  // Stream<List<AddCardListItem>> get importCardStream =>
  //     _importCardController.stream;

  Future importCardInfo(String accountNo, String password, num cardNo,
      num delegateType, num toUid) {
    AddCreditCardReq _addCreditCardReqReq = AddCreditCardReq(
        AppInstance.currentUser.token,
        accountNo,
        password,
        cardNo,
        delegateType,
        toUid); //,delegateType
    // XsProgressHud.showMessage(bloccontext, '正在查询...');

    return netRepository
        .importCardInfo(_addCreditCardReqReq.toJson())
        .then((resp) {
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data != null) {
          if (resp.data['code'] == 0) {
            eventBus1.fire(OpenAnimationEvent(true));
            // XsProgressHud.hide();
            final ApplicationBloc bloc =
                BlocProvider.of<ApplicationBloc>(bloccontext);
            bloc.backType = 1;
            Navigator.popUntil(bloccontext, ModalRoute.withName('MainPage'));
            return;
          } else if (resp.data['code'] == 11) {
            // XsProgressHud.hide();
            getCardStatusAction(resp.data['taskid'], cardNo);
          } else if (resp.data['code'] == 2001) {
            eventBus1.fire(OpenAnimationEvent(true));
            // XsProgressHud.hide();
            NavigatorUtil.pushWeb(bloccontext,
                url: "http://www.baidu.com", title: '导入信用卡');
          } else {
            eventBus1.fire(OpenAnimationEvent(true));
            // XsProgressHud.hide();
            showToast(resp.data['msg']);
          }
        } else {
          eventBus1.fire(OpenAnimationEvent(true));
          // XsProgressHud.hide();
          showToast(resp.msg);
          final ApplicationBloc bloc =
              BlocProvider.of<ApplicationBloc>(bloccontext);
          bloc.backType = 1;
          Navigator.popUntil(bloccontext, ModalRoute.withName('MainPage'));
          return;
        }
      } else {
        eventBus1.fire(OpenAnimationEvent(true));
        // XsProgressHud.hide();
        if (resp.data != null)
          showToast(resp.data['msg']);
        else
          showToast(resp.msg);
      }
    });
  }

  Future getCardStatusAction(String taskIdStr, num cardNo) {
    // XsProgressHud.showMessage(bloccontext, '正在查询...');
    return netRepository.getCardStatus({
      'token': AppInstance.currentUser.token,
      'taskId': taskIdStr,
    }).then((resp) {
      // XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        // if (resp.data != null)
        //   showToast(resp.data['msg']);
        // else
        //   showToast(resp.msg);
        if (resp.data['code'] == 0) {
          showToast(resp.data['msg']);
          eventBus1.fire(OpenAnimationEvent(true));
          // XsProgressHud.hide();
          final ApplicationBloc bloc =
              BlocProvider.of<ApplicationBloc>(bloccontext);
          bloc.backType = 1;
          Navigator.popUntil(bloccontext, ModalRoute.withName('MainPage'));
        } else if (resp.data['code'] == 2) {
          Future.delayed(Duration(seconds: 1)).then((_) {
            getCardStatusAction(taskIdStr, cardNo);
          });
        } else if (resp.data['code'] == 10) {
          // XsProgressHud.hide();
          if (resp.data['data']['type'] == 'imgcode' ||
              resp.data['data']['type'] == 'imgres') {
            StringBuffer imgUrl = StringBuffer();

            if (resp.data['data']['value'] != null) {
              imgUrl.write(resp.data['data']['value']);
              int randomInt = Random().nextInt(100000000);
              imgUrl.write('?yxbimport=$randomInt');
            } else {
              imgUrl.write("http://via.placeholder.com/100x100");
            }
            Alert(
              context: bloccontext,
              style: AlertStyle(
                  isOverlayTapDismiss: false,
                  isCloseButton: false,
                  overlayColor: Colors.black54),
              title: resp.data['msg'],
              content: Row(
                children: <Widget>[
                  Container(
                    width: 170,
                    child: TextField(
                      controller: phoneCtl,
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone_iphone),
                        // labelText: '您的昵称',
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 40,
                    child: CachedNetworkImage(
                      imageUrl: imgUrl.toString(),
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                  child: Text(
                    "确定",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    if (phoneCtl.text.length > 0) {
                      Navigator.pop(bloccontext);
                      setCardInputAction(
                          resp.data['taskid'], phoneCtl.text, cardNo);
                      phoneCtl = TextEditingController();
                    }
                  },
                  width: 120,
                ),
              ],
            ).show();
          } else {
            Alert(
              context: bloccontext,
              style: AlertStyle(
                  isOverlayTapDismiss: false,
                  isCloseButton: false,
                  overlayColor: Colors.black54),
              title: resp.data['msg'],
              content: Column(
                children: <Widget>[
                  TextField(
                    controller: phoneCtl,
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone_iphone),
                      // labelText: '您的昵称',
                    ),
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                  child: Text(
                    "确定",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    if (phoneCtl.text.length > 0) {
                      Navigator.pop(bloccontext);
                      setCardInputAction(
                          resp.data['taskid'], phoneCtl.text, cardNo);
                      phoneCtl = TextEditingController();
                    }
                  },
                  width: 120,
                ),
              ],
            ).show();
          }
        } else if (resp.data['code'] == 2001) {
          eventBus1.fire(OpenAnimationEvent(true));
          // XsProgressHud.hide();
          NavigatorUtil.pushWeb(bloccontext,
              url: "http://www.baidu.com", title: '导入信用卡');
        } else {
          if (resp.data != null)
            showToast(resp.data['msg']);
          else
            showToast(resp.msg);
          eventBus1.fire(OpenAnimationEvent(true));
          // XsProgressHud.hide();
        }
      } else {
        eventBus1.fire(OpenAnimationEvent(true));
        // XsProgressHud.hide();
        if (resp.data != null)
          showToast(resp.data['msg']);
        else
          showToast(resp.msg);
      }
    });
  }

  Future setCardInputAction(String taskIdStr, String inputStr, num banCodeStr) {
    // XsProgressHud.showMessage(bloccontext, '正在查询...');
    return netRepository.setCardInput({
      'token': AppInstance.currentUser.token,
      'taskId': taskIdStr,
      'input': inputStr,
      'banCode': banCodeStr
    }).then((resp) {
      // XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data['code'] == 9) {
          Future.delayed(Duration(seconds: 1)).then((_) {
            getCardStatusAction(taskIdStr, banCodeStr);
          });
        } else {
          if (resp.data != null)
            showToast(resp.data['msg']);
          else
            showToast(resp.msg);
          eventBus1.fire(OpenAnimationEvent(true));
          // XsProgressHud.hide();
        }
      } else {
        eventBus1.fire(OpenAnimationEvent(true));
        // XsProgressHud.hide();
        if (resp.data != null)
          showToast(resp.data['msg']);
        else
          showToast(resp.msg);
      }
    });
  }

  void showToast(String msg, {int duration, int gravity: 0}) {
    Toast.show(msg, bloccontext, duration: duration, gravity: gravity);
  }

  @override
  void dispose() {
    // _importCardController.close();
  }
}
