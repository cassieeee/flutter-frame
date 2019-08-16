import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class RepaymentDiagnosePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RepaymentDiagnosePageState();
}

class RepaymentDiagnosePageState extends State<RepaymentDiagnosePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        RepaymentDiagnoseHead(),
        RepaymentDiagnoseMiddle(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
