import "../common/component_index.dart";
import 'package:rxdart/rxdart.dart';

class ApplicationBloc implements BlocBase {
  BehaviorSubject<int> _appEvent = BehaviorSubject<int>();

  Sink<int> get _appEventSink => _appEvent.sink;

  Stream<int> get appEventStream => _appEvent.stream;
  bool expandPanel = false;


  int backType = 0;
  int personalBackType = 0;

  @override
  void dispose() {
    _appEvent.close();
  }

  void sendAppEvent(int type) {
    _appEventSink.add(type);
  }
}
