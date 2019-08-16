import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class ConsumeDiagnosePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ConsumeDiagnosePageState();
}

class ConsumeDiagnosePageState extends State<ConsumeDiagnosePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        ConsumeDiagnoseHead(),
        ConsumeDiagnoseMiddle(),
        ConsumeDiagnoseBottom(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
