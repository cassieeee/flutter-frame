import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class SetPwdPage extends StatelessWidget {
  final int fromType;
  SetPwdPage(this.fromType);
  final SetPwdBloc setPwdBloc = SetPwdBloc();

  @override
  Widget build(BuildContext context) {
    setPwdBloc.fromType = this.fromType;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            '设置密码',
            style: TextStyle(fontSize: 18),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            tooltip: '返回',
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: BlocProvider<SetPwdBloc>(
        bloc: setPwdBloc,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              SetPwdHead(),
              SetPwdMiddle(),
            ],
          ),
        ),
      ),
    );
  }
}
