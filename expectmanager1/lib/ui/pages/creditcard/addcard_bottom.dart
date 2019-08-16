import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class AddCardBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 10,
            color: Color(0xFFE6E6E6),
          ),
          Container(
            height: 96,
            color: Colors.white,
            child: FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset('assets/images/user/input_edit.png',width: 30,height: 30),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '手动导入',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF282828),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '手动输入信用卡相关信息导入',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              onPressed: () {
                NavigatorUtil.pushPage(context, ImportErrorPage('手动导入'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
