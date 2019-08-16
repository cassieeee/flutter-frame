import 'package:rxdart/rxdart.dart';

import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class CreditCardHead extends StatelessWidget {
  Widget build(BuildContext context) {
    final CreditCardBloc creditCardBloc =
        BlocProvider.of<CreditCardBloc>(context);
    creditCardBloc.bloccontext = context;
    final ApplicationBloc applicationBloc =
        BlocProvider.of<ApplicationBloc>(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 36),
          alignment: Alignment.topCenter,
          height: 205,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/user/creditcard_head1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Text(
            '信用卡管理',
            style: TextStyles.text18WhiteBoldLabel,
          ),
        ),
        Container(
          width: 343,
          height: 78,
          margin: EdgeInsets.only(
            top: 230,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FlatButton(
                child: Container(
                  width: 77,
                  height: 78,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 42,
                        height: 42,
                        child:
                            Image.asset('assets/images/user/addcard_icon.png'),
                      ),
                      Text(
                        '添加卡片',
                        style: TextStyles.text14MediumLabel,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  if (AppInstance.currentUser.isCertification == '1') {
                    Navigator.push<int>(
                      context,
                      MaterialPageRoute<int>(
                        builder: (BuildContext context) => AddCardPage(toUid:AppInstance.currentUser.id),
                      ),
                    ).then((int type) {
                      if (applicationBloc.backType == 1)
                        creditCardBloc.getCreditInfo();
                      applicationBloc.backType = 0;
                    });
                  } else {
                    creditCardBloc.showToast('请先到个人中心进行实名认证~');
                  }
                },
              ),
              FlatButton(
                child: Container(
                  width: 77,
                  height: 78,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 42,
                        height: 42,
                        child: Image.asset(
                            'assets/images/user/creditdiagnose_icon.png'),
                      ),
                      Text(
                        '信用诊断',
                        style: TextStyles.text14MediumLabel,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  if (AppInstance.currentUser.isCertification == '1') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        settings: RouteSettings(name: "CreditDiagnosePage"),
                        builder: (BuildContext context) => CreditDiagnosePage(),
                      ),
                    );
                  } else {
                    creditCardBloc.showToast('请先到个人中心进行实名认证~');
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
