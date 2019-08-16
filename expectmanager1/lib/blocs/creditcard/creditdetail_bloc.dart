import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";

class CreditDetailBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  CardItemModel cardModel;
  DateTime startTimeDate;
  DateTime endTimeDate;

  BehaviorSubject<List<dynamic>> _creditDetailController =
      BehaviorSubject<List<dynamic>>();
  Sink<List<dynamic>> get _creditDetailSink => _creditDetailController.sink;
  Stream<List<dynamic>> get creditDetailStream =>
      _creditDetailController.stream;

  BehaviorSubject<List<dynamic>> _billListController =
      BehaviorSubject<List<dynamic>>();
  Sink<List<dynamic>> get _billListSink => _billListController.sink;
  Stream<List<dynamic>> get billListStream => _billListController.stream;

  int currentPage = 0;
  List allPlanList = List();

  num planHeight = 0.0;
  int planIndex = 0;
  BehaviorSubject<num> _planHeightController = BehaviorSubject<num>();
  Sink<num> get _planHeightSink => _planHeightController.sink;
  Stream<num> get planHeightStream => _planHeightController.stream;

  Future getPlanLists(int loadType, bool isExpanded, List status,
      {String startTime,
      String endTime,
      int delegateType,
      int planType = 0,
      int cardId}) {
    String conditionStr = '{}';
    if (startTime != null && endTime != null) {
      conditionStr = conditionStr.replaceFirst(
          '{', '{"startTime": "$startTime","endTime": "$endTime",');
    }
    if (planType != 0) {
      conditionStr = conditionStr.replaceFirst('{', '{"planType": $planType,');
    }
    if (status != null) {
      conditionStr = conditionStr.replaceFirst('{', '{"status": $status,');
    }
    if (cardId != null) {
      conditionStr = conditionStr.replaceFirst('{', '{"cardId": $cardId,');
    }
    conditionStr = conditionStr.replaceFirst(',}', '}');

    planHeight = 0;
    if (loadType != 0) {
      if (loadType == 1) {
        currentPage++;
      } else {
        currentPage = 0;
        allPlanList = [];
      }
    }
    AllPlanListsReq _allPlanListsReq = AllPlanListsReq(
        AppInstance.currentUser.token, currentPage, conditionStr);
    XsProgressHud.show(bloccontext);
    return netRepository.getPlanLists(_allPlanListsReq.toJson()).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data != null) {
          if (resp.data['dataList'].length > 0) {
            allPlanList.addAll(resp.data['dataList']);
          } else {
            if (loadType == 1) {
              showToast('没有更多数据~');
              currentPage--;
            }
          }
          planHeight = allPlanList.length * 77.5 + 200;
          if (allPlanList.length > 0) {
            if (!isExpanded) {
              planHeight += 200;
            }
          }

          _planHeightSink.add(planHeight.toDouble());
          _creditDetailSink.add(allPlanList);
        } else {
          showToast(resp.msg);
        }
      } else {
        showToast(resp.msg);
      }
    });
  }

  void caculatePlanHeight(newIndex) {
    if (newIndex == planIndex) {
      planHeight = planHeight - 200;
      planIndex = -1;
    } else {
      if (planIndex == -1) {
        planHeight = planHeight + 200;
      }
      planIndex = newIndex;
    }

    _planHeightSink.add(planHeight.toDouble());
  }

  num billHeight = 0.0;
  int billIndex = 0;
  List billList = List();
  BehaviorSubject<num> _billHeightController = BehaviorSubject<num>();
  Sink<num> get _billHeightSink => _billHeightController.sink;
  Stream<num> get billHeightStream => _billHeightController.stream;

  Future getBillLists(int cardId, int index, bool isExpanded) {
    billHeight = 0.0;
    billList = [];
    XsProgressHud.show(bloccontext);
    return netRepository.getBillLists({
      "token": AppInstance.currentUser.token,
      "cardId": cardId,
    }).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data != null) _billListSink.add(resp.data['bill']);
        billList = resp.data['bill'];
        billHeight =
            resp.data['bill'].length * 50 + resp.data['bill'].length + 120;
        if (!isExpanded) {
          billHeight += resp.data['bill'][index]['detail'].length * 50 +
              resp.data['bill'][index]['detail'].length;
        }
        if (index != 0) {
          billHeight += 120;
        }
        _billHeightSink.add(billHeight.toDouble());
      } else {
        showToast(resp.msg);
      }
    });
  }

  //重新计算高度
  void changeBillHeight(newIndex) {
    int oldIndex = billIndex;
    if (newIndex == billIndex) {
      billHeight = billHeight -
          billList[newIndex]['detail'].length * 50 -
          billList[newIndex]['detail'].length;
      if (newIndex != 0) {
        billHeight -= 120;
      }
      billIndex = -1;
    } else {
      if (newIndex == 0) {
        if (oldIndex != -1) {
          billHeight = billHeight +
              billList[newIndex]['detail'].length * 50 +
              billList[newIndex]['detail'].length -
              billList[oldIndex]['detail'].length * 50 -
              120 -
              billList[oldIndex]['detail'].length;
        } else {
          billHeight = billHeight +
              billList[newIndex]['detail'].length * 50 +
              billList[newIndex]['detail'].length;
        }
      } else {
        if (oldIndex == -1) {
          billHeight = billHeight +
              billList[newIndex]['detail'].length * 50 +
              120 +
              billList[newIndex]['detail'].length;
        } else if (oldIndex == 0) {
          billHeight = billHeight +
              billList[newIndex]['detail'].length * 50 +
              120 +
              billList[newIndex]['detail'].length -
              billList[oldIndex]['detail'].length * 50 -
              billList[oldIndex]['detail'].length;
        } else {
          billHeight = billHeight +
              billList[newIndex]['detail'].length * 50 +
              120 +
              billList[newIndex]['detail'].length -
              billList[oldIndex]['detail'].length * 50 -
              120 -
              billList[oldIndex]['detail'].length;
        }
      }
      billIndex = newIndex;
    }
    _billHeightSink.add(billHeight.toDouble());
  }
  bool isBillOpen=true;
  bool isPlanOpen=true;
  bool isShow=false;
  //滑动显隐
   BehaviorSubject<bool> _showHeadController =
      BehaviorSubject<bool>();
  Sink<bool> get showHeadSink => _showHeadController.sink;
  Stream<bool> get showHeadStream =>
      _showHeadController.stream;

  void showToast(String msg, {int duration, int gravity: 0}) {
    Toast.show(msg, bloccontext, duration: duration, gravity: gravity);
  }

  @override
  void dispose() {
    _creditDetailController.close();
    _billListController.close();
    _billHeightController.close();
    _planHeightController.close();
    _showHeadController.close();
  }
}
