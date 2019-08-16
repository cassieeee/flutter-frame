import 'dart:math';

import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";
import '../../ui/pages/page_index.dart';

class CardOnlineDiagnoseBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  BehaviorSubject<Map<String, dynamic>> _cardDiagnoseController =
      BehaviorSubject<Map<String, dynamic>>();
  Sink<Map<String, dynamic>> get _cardDiagnoseSink =>
      _cardDiagnoseController.sink;
  Stream<Map<String, dynamic>> get cardDiagnoseStream =>
      _cardDiagnoseController.stream;

  int id;
  int backType = 0;

  final List<String> noteList = [
    '诊断用卡时长',
    '诊断卡片信用额度',
    '诊断卡片当前信用额度',
    '诊断卡片逾期数据',
    '诊断卡片还款方式',
    '诊断卡片还款笔数',
    '诊断卡片消费方式',
    '诊断卡片支付方式',
    '诊断卡片电子支付',
    '诊断卡片POS支付',
    '诊断卡片其他支付',
    '诊断卡片每月额度使用率',
    '诊断卡片近1年额度使用率',
    '诊断积分数据',
    '开始评估卡片分值',
    '开始预测下期提额时间',
    '开始预测下期可升额度',
    '开始预测最高可提额度',
    '开始计算提升建议',
    '正在生成报告……',
    '诊断报告生成成功',
    '即将跳转至诊断结果'
  ];
  TimerUtil _timerUtil;
  int showStrCount = 0;
  int showProgressNum = 0;
  int totalGrade = 100;
  int perGrade = 100 ~/ 22;
  List<int> randomStrList = [2, 3, 4, 5];
  bool isGetData = true;

  // Future cardDiagnoseInfo(String cardId, String sqTime, String sqLimit) {
  //   CardDiagnoseReq _cardDiagnoseReq =
  //       CardDiagnoseReq(AppInstance.currentUser.token, cardId, sqTime, sqLimit);
  //   XsProgressHud.show(bloccontext);

  //   return netRepository
  //       .cardDiagnoseInfo(_cardDiagnoseReq.toJson())
  //       .then((resp) {
  //     XsProgressHud.hide();
  //     if (resp.code == Constant.SUCCESS_CODE) {
  //       if (resp.data != null) {
  //         if ((int.tryParse(resp.data['code']) == 100) &&
  //             resp.data['data'] != null) {
  //           isGetData = true;
  //           _timerUtil.cancel();
  //         }
  //         if (int.tryParse(resp.data['code']) == 101) {
  //           showToast(resp.data['msg']);
  //           _timerUtil.cancel();
  //         }
  //         if (int.tryParse(resp.data['code']) == 102) {}
  //       }
  //     } else {
  //       showToast(resp.msg);
  //       _timerUtil.cancel();
  //     }
  //   });
  // }

  void startDiagnose() {
    if (_timerUtil == null) {
      _timerUtil = new TimerUtil(mTotalTime: 100 * 1000);
      _timerUtil.setOnTimerTickCallback((int tick) {
        print('tick\n');
        print(tick);
        int randomStrCount =
            randomStrList[Random().nextInt(randomStrList.length)];
        showStrCount += randomStrCount;
        if (showStrCount > noteList.length) showStrCount = noteList.length;
        List<String> showStrList = List<String>();
        for (int i = showStrCount - 1; i >= 0; i--) {
          showStrList.add(noteList[i]);
        }
        int grade = randomStrCount * perGrade;
        showProgressNum += grade;
        if (showProgressNum >= 95) {
          if (isGetData) {
            showProgressNum = 100;
            List<String> showStrList = List<String>();
            for (int i = noteList.length - 1; i >= 0; i--) {
              showStrList.add(noteList[i]);
            }
            _cardDiagnoseSink
                .add({'progressNum': showProgressNum, 'noteList': showStrList});
            _timerUtil.cancel();

            Navigator.pushAndRemoveUntil(
              bloccontext,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DiagnoseInfoPage(id, backType),
              ),
              (Route<dynamic> route) => false,
            );
            return;
          } else {
            showProgressNum = 99;
            _cardDiagnoseSink
                .add({'progressNum': showProgressNum, 'noteList': showStrList});
          }
        } else {
          _cardDiagnoseSink
              .add({'progressNum': showProgressNum, 'noteList': showStrList});
        }
        // cardDiagnoseInfo();
      });
      _timerUtil.startCountDown();
    }
  }

  void showToast(String msg, {int duration, int gravity: 0}) {
    Toast.show(msg, bloccontext, duration: duration, gravity: gravity);
  }

  @override
  void dispose() {
    if (_timerUtil != null) _timerUtil.cancel();
    _cardDiagnoseController.close();
  }
}
