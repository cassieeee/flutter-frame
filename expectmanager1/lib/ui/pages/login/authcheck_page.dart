import '../../../common/component_index.dart';


class AuthCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              '实名认证',
              style: TextStyle(fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              tooltip: '返回',
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  '资料已提交',
                  style: TextStyle(fontSize: 18, color: Colours.text_lable),
                ),
                SizedBox(
                  height: 51,
                ),
                Container(
                  width: 140,
                  child: Text(
                    '平台审核中，请耐心等待...',
                    style: TextStyle(fontSize: 23, color: Colours.text_lable),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
