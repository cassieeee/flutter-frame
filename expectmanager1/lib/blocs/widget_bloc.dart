import 'package:rxdart/rxdart.dart';
import "../common/component_index.dart";

class FlexiblePanelBloc implements BlocBase {
  BuildContext bloccontext;
  BehaviorSubject<dynamic> _flexibleController = BehaviorSubject<dynamic>();
  Stream<dynamic> get outAccount => _flexibleController.stream;
  StreamSink<dynamic> get _accountInfoSink => _flexibleController.sink;

  void showToast(String msg, {int duration, int gravity: 0}) {
    Toast.show(msg, bloccontext, duration: duration, gravity: gravity);
  }

  void dispose() {
    _flexibleController.close();
  }
}
