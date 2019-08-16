import 'package:rxdart/rxdart.dart';

import "../../common/component_index.dart";

class AddCreditCardBloc implements BlocBase {
  BuildContext bloccontext;

  NetRepository netRepository = NetRepository();

  BehaviorSubject<List<AddCardListItem>> _addCardListController =
      BehaviorSubject<List<AddCardListItem>>();
  Sink<List<AddCardListItem>> get _addCardListSink =>
      _addCardListController.sink;
  Stream<List<AddCardListItem>> get addCardListStream =>
      _addCardListController.stream;

  Future getCardListInfo() {
    GetBankAddListReq _creditCardInfoReq =
        GetBankAddListReq(AppInstance.currentUser.token);
    XsProgressHud.show(bloccontext);

    return netRepository
        .getAddCardList(_creditCardInfoReq.toJson())
        .then((resp) {
      XsProgressHud.hide();
      if (resp.code == Constant.SUCCESS_CODE) {
        if (resp.data != null)
          _addCardListSink.add(resp.data['bankList']
              .map((value) {
                return AddCardListItem.fromJson(value);
              })
              .cast<AddCardListItem>()
              .toList());
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
    _addCardListController.close();
  }
}
