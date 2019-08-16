import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class StandbyDiagnosePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StandbyDiagnosePageState();
}

class StandbyDiagnosePageState extends State<StandbyDiagnosePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        StandbyDiagnoseHead(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
