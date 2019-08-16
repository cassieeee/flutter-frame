import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";

class MyManagerBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  int tabIndex = 0;

  bool isBillOpen = true;
  bool isPlanOpen = true;

  DateTime startTimeDate;
  DateTime endTimeDate;

  BehaviorSubject<int> _tabIndexController = BehaviorSubject<int>();
  Sink<int> get tabIndexSink => _tabIndexController.sink;
  Stream<int> get tabIndexStream => _tabIndexController.stream;

  BehaviorSubject<List<dynamic>> _masterPlanController =
      BehaviorSubject<List<dynamic>>();
  Sink<List<dynamic>> get _masterPlanSink => _masterPlanController.sink;
  Stream<List<dynamic>> get masterPlanStream => _masterPlanController.stream;
  int currentPage = 0;
  num planHeight = 0.0;
  List allPlanList = List();
  int planIndex = 0;

  num escrowHeight = 0.0;
  BehaviorSubject<num> _escrowHeightController = BehaviorSubject<num>();
  Sink<num> get escrowHeightSink => _escrowHeightController.sink;
  Stream<num> get escrowHeightStream => _escrowHeightController.stream;

  BehaviorSubject<num> _planHeightController = BehaviorSubject<num>();
  Sink<num> get _planHeightSink => _planHeightController.sink;
  Stream<num> get planHeightStream => _planHeightController.stream;

  BehaviorSubject<Map> _orderCardsController = BehaviorSubject<Map>();
  Sink<Map> get _orderCardsPlanSink => _orderCardsController.sink;
  Stream<Map> get orderCardsStream => _orderCardsController.stream;

  int orderId = 0;

  Future getPlanLists(int loadType, bool isExpanded, List status,
      {String startTime,
      String endTime,
      int delegateType,
      int planType = 0,
      int cardId,
      int masterId}) {
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
    if (masterId != null) {
      conditionStr = conditionStr.replaceFirst('{', '{"masterId": $masterId,');
    }
    if (orderId != 0) {
      conditionStr = conditionStr.replaceFirst('{', '{"orderId": $orderId,');
    }
    conditionStr = conditionStr.replaceFirst(',}', '}');
    planHeight = 0.0;
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
          planHeight = resp.data['dataList'].length * 50 + 200;
          if (allPlanList.length > 0) {
            if (!isExpanded) {
              planHeight += 200;
            }
          }
          _planHeightSink.add(planHeight.toDouble());
          _masterPlanSink.add(allPlanList);
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

  Future getMasterOrderCards(int orderId) {
    XsProgressHud.show(bloccontext);
    Map reqMap = {"token": AppInstance.currentUser.token, "orderId": orderId};
    return netRepository.getMasterOrderCards(reqMap).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data != null) {
          _orderCardsPlanSink.add(resp.data);
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

  @override
  void dispose() {
    _masterPlanController.close();
    _planHeightController.close();
    _orderCardsController.close();
    _tabIndexController.close();
    _escrowHeightController.close();
  }
}
