import 'package:youxinbao/ui/pages/login/login_index.dart';

import '../../../common/component_index.dart';

class PersonalBottom extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: FlatButton(
              child: Text(
                '退出登录',
                style: TextStyles.text18MediumLabel,
              ),
              onPressed: () {
                showAlertActionStyle(context, '退出登录', '取消', () {
                  AppInstance.remove('upgradeM');
                  AppInstance.remove('upgradeC');
                  AppInstance.remove("user");
                  AppInstance.putString(Constant.KEY_THEME_COLOR, 'usercolor');
                  final ApplicationBloc bloc =
                      BlocProvider.of<ApplicationBloc>(context);
                  bloc.sendAppEvent(1);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
