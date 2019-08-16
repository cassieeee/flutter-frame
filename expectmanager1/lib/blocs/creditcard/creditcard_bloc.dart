import 'dart:math';

import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";
import '../../ui/pages/page_index.dart';

class CreditCardBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();
  TextEditingController phoneCtl = TextEditingController();

  BehaviorSubject<CardInfoModel> _cardInfoController =
      BehaviorSubject<CardInfoModel>();
  Sink<CardInfoModel> get _cardInfoSink => _cardInfoController.sink;
  Stream<CardInfoModel> get cardInfoStream => _cardInfoController.stream;

  BehaviorSubject<int> _changeTabController = BehaviorSubject<int>();
  Sink<int> get changeTabSink => _changeTabController.sink;
  Stream<int> get changeTabStream => _changeTabController.stream;

  CardInfoModel cardInfoModel;
  int currentTabIndex = 0;
  List<List<double>> progressAry = List<List<double>>();
  List<List<double>> managerProgressAry = List<List<double>>();
  int section;
  int index;
  int billIndex;
  Future getCreditInfo() {
    CreditCardInfoReq _creditCardInfoReq =
        CreditCardInfoReq(AppInstance.currentUser.token);
    XsProgressHud.show(bloccontext);

    return netRepository.getCardInfo(_creditCardInfoReq.toJson()).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data != null) {
          _cardInfoSink.add(CardInfoModel.fromJson(resp.data));
          cardInfoModel = CardInfoModel.fromJson(resp.data);
          changeTabSink.add(currentTabIndex);
        }
      } else {
        if (resp.code == 50008) {
          AppInstance.remove("user");
          Navigator.pushAndRemoveUntil(
            bloccontext,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            (Route<dynamic> route) => false,
          );
          AppInstance.putString(Constant.KEY_THEME_COLOR, 'usercolor');
          final ApplicationBloc bloc =
              BlocProvider.of<ApplicationBloc>(bloccontext);
          bloc.sendAppEvent(1);
        }
        showToast(resp.msg);
      }
    });
  }

  Future removeCard(num cardId) {
    RemoveCardReq _removeCardReq =
        RemoveCardReq(AppInstance.currentUser.token, cardId);
    XsProgressHud.show(bloccontext);

    return netRepository.removeCard(_removeCardReq.toJson()).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        showToast(resp.msg);
        getCreditInfo();
      } else {
        if (resp.code == 50008) {
          AppInstance.remove("user");
          Navigator.pushAndRemoveUntil(
            bloccontext,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            (Route<dynamic> route) => false,
          );
          AppInstance.putString(Constant.KEY_THEME_COLOR, 'usercolor');
          final ApplicationBloc bloc =
              BlocProvider.of<ApplicationBloc>(bloccontext);
          bloc.sendAppEvent(1);
        }
        showToast(resp.msg);
      }
    });
  }

  Future updateBillAction(
      num cardInstId, num bankCode, int ssection, int iindex, int bIndex) {
    section = ssection;
    index = iindex;
    billIndex = bIndex;
    UpdateBillReq _updateBillReq =
        UpdateBillReq(AppInstance.currentUser.token, cardInstId);
    // XsProgressHud.show(bloccontext);
    if (AppInstance.currentUser.roleType == '2') {
      managerProgressAry[index][billIndex] = 0.2;
      // eventBus3.fire(UpdateManagerProgressEvent());
    } else {
      progressAry[section][index] = 0.2;
      eventBus2.fire(UpdateProgressEvent(true));
    }
    return netRepository.updateBill(_updateBillReq.toJson()).then((resp) {
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data != null) {
          if (resp.data['code'] == 0) {
            // XsProgressHud.hide();
            showToast(resp.data['msg']);
            if (AppInstance.currentUser.roleType == '2') {
              managerProgressAry[index][billIndex] = 1.0;
              // eventBus3.fire(UpdateManagerProgressEvent());
              Future.delayed(Duration(seconds: 1)).then((_) {
                managerProgressAry[index][billIndex] = 0.0;
                // eventBus3.fire(UpdateManagerProgressEvent());
              });
            } else {
              progressAry[section][index] = 1.0;
              eventBus2.fire(UpdateProgressEvent(true));
              Future.delayed(Duration(seconds: 1)).then((_) {
                progressAry[section][index] = 0.0;
                eventBus2.fire(UpdateProgressEvent(false));
              });
            }
            return;
          } else if (resp.data['code'] == 11) {
            // XsProgressHud.hide();
            getCardStatusAction(resp.data['taskid'], bankCode);
          } else if (resp.data['code'] == 2001) {
            XsProgressHud.hide();
            if (AppInstance.currentUser.roleType == '2') {
              managerProgressAry[index][billIndex] = 0.0;
              // eventBus3.fire(UpdateManagerProgressEvent());
            } else {
              progressAry[section][index] = 0.0;
              eventBus2.fire(UpdateProgressEvent(false));
            }

            NavigatorUtil.pushWeb(bloccontext,
                url: "http://www.baidu.com", title: '更新账单');
          } else {
            if (AppInstance.currentUser.roleType == '2') {
              managerProgressAry[index][billIndex] = 0.0;
              // eventBus3.fire(UpdateManagerProgressEvent());
            } else {
              progressAry[section][index] = 0.0;
              eventBus2.fire(UpdateProgressEvent(false));
            }

            // XsProgressHud.hide();
            showToast(resp.data['msg']);
          }
        } else {
          // XsProgressHud.hide();
          if (AppInstance.currentUser.roleType == '2') {
            managerProgressAry[index][billIndex] = 0.0;
            // eventBus3.fire(UpdateManagerProgressEvent());
          } else {
            progressAry[section][index] = 0.0;
            eventBus2.fire(UpdateProgressEvent(false));
          }

          showToast(resp.msg);
          return;
        }
      } else {
        // XsProgressHud.hide();
        if (AppInstance.currentUser.roleType == '2') {
          managerProgressAry[index][billIndex] = 0.0;
          // eventBus3.fire(UpdateManagerProgressEvent());
        } else {
          progressAry[section][index] = 0.0;
          eventBus2.fire(UpdateProgressEvent(false));
        }

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
        if (resp.data['code'] == 0) {
          // XsProgressHud.hide();
          if (resp.data != null) {
            showToast(resp.data['msg']);
          } else {
            showToast(resp.msg);
          }
          if (AppInstance.currentUser.roleType == '2') {
            managerProgressAry[index][billIndex] = 1.0;
            // eventBus3.fire(UpdateManagerProgressEvent());
            Future.delayed(Duration(seconds: 1)).then((_) {
              managerProgressAry[index][billIndex] = 0.0;
              // eventBus3.fire(UpdateManagerProgressEvent());
            });
          } else {
            progressAry[section][index] = 1.0;
            eventBus2.fire(UpdateProgressEvent(true));
            Future.delayed(Duration(seconds: 1)).then((_) {
              progressAry[section][index] = 0.0;
              eventBus2.fire(UpdateProgressEvent(false));
            });
          }
        } else if (resp.data['code'] == 2) {
          if (AppInstance.currentUser.roleType == '2') {
            managerProgressAry[index][billIndex] =
                managerProgressAry[index][billIndex] + 0.02;
            if (managerProgressAry[index][billIndex] > 0.99)
              managerProgressAry[index][billIndex] = 0.99;
            // eventBus3.fire(UpdateManagerProgressEvent());
          } else {
            progressAry[section][index] = progressAry[section][index] + 0.02;
            if (progressAry[section][index] > 0.99)
              progressAry[section][index] = 0.99;
            eventBus2.fire(UpdateProgressEvent(true));
          }
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
                  isOverlayTapDismiss: false, overlayColor: Colors.black54),
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
                  isOverlayTapDismiss: false, overlayColor: Colors.black54),
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
          // XsProgressHud.hide();
          if (AppInstance.currentUser.roleType == '2') {
            managerProgressAry[index][billIndex] = 0.0;
            // eventBus3.fire(UpdateManagerProgressEvent());
          } else {
            progressAry[section][index] = 0.0;
            eventBus2.fire(UpdateProgressEvent(false));
          }

          NavigatorUtil.pushWeb(bloccontext,
              url: "http://www.baidu.com", title: '更新账单');
        } else {
          if (resp.data != null)
            showToast(resp.data['msg']);
          else
            showToast(resp.msg);
          if (AppInstance.currentUser.roleType == '2') {
            managerProgressAry[index][billIndex] = 0.0;
            // eventBus3.fire(UpdateManagerProgressEvent());
          } else {
            progressAry[section][index] = 0.0;
            eventBus2.fire(UpdateProgressEvent(false));
          }

          // XsProgressHud.hide();
        }
      } else {
        // XsProgressHud.hide();
        if (AppInstance.currentUser.roleType == '2') {
          managerProgressAry[index][billIndex] = 0.0;
          // eventBus3.fire(UpdateManagerProgressEvent());
        } else {
          progressAry[section][index] = 0.0;
          eventBus2.fire(UpdateProgressEvent(false));
        }
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
          if (AppInstance.currentUser.roleType == '2') {
            managerProgressAry[index][billIndex] =
                managerProgressAry[index][billIndex] + 0.1;
            if (managerProgressAry[index][billIndex] > 0.99)
              managerProgressAry[index][billIndex] = 0.99;
            // eventBus3.fire(UpdateManagerProgressEvent());
          } else {
            progressAry[section][index] = progressAry[section][index] + 0.1;
            if (progressAry[section][index] > 0.99)
              progressAry[section][index] = 0.99;
            eventBus2.fire(UpdateProgressEvent(true));
          }
          Future.delayed(Duration(seconds: 1)).then((_) {
            getCardStatusAction(taskIdStr, banCodeStr);
          });
        } else {
          if (AppInstance.currentUser.roleType == '2') {
            managerProgressAry[index][billIndex] = 0.0;
            // eventBus3.fire(UpdateManagerProgressEvent());
          } else {
            progressAry[section][index] = 0.0;
            eventBus2.fire(UpdateProgressEvent(false));
          }

          if (resp.data != null)
            showToast(resp.data['msg']);
          else
            showToast(resp.msg);
          // XsProgressHud.hide();
        }
      } else {
        // XsProgressHud.hide();
        if (AppInstance.currentUser.roleType == '2') {
          managerProgressAry[index][billIndex] = 0.0;
          // eventBus3.fire(UpdateManagerProgressEvent());
        } else {
          progressAry[section][index] = 0.0;
          eventBus2.fire(UpdateProgressEvent(false));
        }

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
    _cardInfoController.close();
    _changeTabController.close();
  }
}
