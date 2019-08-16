import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class FindPwdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            '忘记密码',
            style: TextStyle(fontSize: 18),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            tooltip: '返回',
            onPressed: () {
              Navigator.pop(context);
            },
          ),),
      body: BlocProvider<FindPwdBloc>(
        bloc: FindPwdBloc(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              FindPwdHead(),
              FindPwdMiddle(),
            ],
          ),
        ),
      ),
    );
  }
}
