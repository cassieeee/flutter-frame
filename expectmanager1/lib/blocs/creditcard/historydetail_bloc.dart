import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";

class HistoryDetailBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  int valueId = 0;
  int fromType = 0;
  String searchTextStr;

  List<dynamic> dataList = List<dynamic>();
  int currentPage = 0;
  Map<String, dynamic> filterMap;
  bool isChoosePanel = false;

  BehaviorSubject<List<dynamic>> _historyDetailController =
      BehaviorSubject<List<dynamic>>();
  Sink<List<dynamic>> get _historyDetailSink => _historyDetailController.sink;
  Stream<List<dynamic>> get historyDetailStream =>
      _historyDetailController.stream;

  Future getPlanLists(int page, List status,
      {String startTime,
      String endTime,
      int delegateType,
      int planType = 0,
      int cardId,
      bool questionOnly = false,
      String order = 'DESC'}) {
    String conditionStr = '{}';
    if (startTime != null && endTime != null) {
      conditionStr = conditionStr.replaceFirst(
          '{', '{"startTime": "$startTime","endTime": "$endTime",');
    }
    if (planType != 0) {
      conditionStr = conditionStr.replaceFirst('{', '{"planType": $planType,');
    }
    if (questionOnly) {
      conditionStr = conditionStr.replaceFirst('{', '{"status": [-1],');
    } else if (status != null) {
      conditionStr = conditionStr.replaceFirst('{', '{"status": [-1,1,2,4],');
    }
    if (searchTextStr != null) {
      conditionStr =
          conditionStr.replaceFirst('{', '{"searchStr": "$searchTextStr",');
    }
    if (cardId != null) {
      if (fromType == 1)
        conditionStr = conditionStr.replaceFirst('{', '{"cardId": $cardId,');
      if (fromType == 2)
        conditionStr = conditionStr.replaceFirst('{', '{"masterId": $cardId,');
    }
    conditionStr = conditionStr.replaceFirst('{', '{"order": "$order",');
    conditionStr = conditionStr.replaceFirst(',}', '}');
    AllPlanListsReq _allPlanListsReq =
        AllPlanListsReq(AppInstance.currentUser.token, page, conditionStr);
    XsProgressHud.show(bloccontext);
    return netRepository.getPlanLists(_allPlanListsReq.toJson()).then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data != null) {
          if (page == 0) dataList = List<dynamic>();
          _historyDetailSink.add(resp.data['dataList']);
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
    _historyDetailController.close();
  }
}
