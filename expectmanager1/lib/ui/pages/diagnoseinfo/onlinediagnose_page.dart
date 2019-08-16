import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class OnlineDiagnosePage extends StatelessWidget {
  OnlineDiagnosePage(this.cardItem, this.backType);
  final DiagnoseCardItem cardItem;
  final int backType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardOnlineDiagnoseBloc>(
      bloc: CardOnlineDiagnoseBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colours.blue_color,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            '信用卡诊断',
            style: TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: Colours.background_color,
        body: ListView(
          children: <Widget>[
            OnlineDiagnoseHead(this.cardItem, this.backType),
          ],
        ),
      ),
    );
  }
}
