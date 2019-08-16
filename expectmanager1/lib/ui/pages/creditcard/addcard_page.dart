import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class AddCardPage extends StatelessWidget {
  AddCardPage({this.toUid});
  final int toUid;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddCreditCardBloc>(
      bloc: AddCreditCardBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            '添加信用卡',
            style: TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            AddCardHead(),
            AddCardMiddle(toUid:toUid),
            // AddCardBottom(),
          ],
        ),
      ),
    );
  }
}
