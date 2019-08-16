import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class LimitDiagnosePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LimitDiagnosePageState();
}

class LimitDiagnosePageState extends State<LimitDiagnosePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        LimitDiagnoseHead(),
        LimitDiagnoseMiddle(),
        LimitDiagnoseBottom(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
