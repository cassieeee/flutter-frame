import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';


class MineMiddle extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: FlatButton(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 3,
                  ),
                  Image.asset('assets/images/user/charge_icon.png',width: 17,height: 17),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      '充值',
                      style: TextStyles.text16MediumLabel,
                    ),
                  ),
                  Image.asset('assets/images/user/arrowmore_big.png',width: 10,height: 17),
                ],
              ),
              onPressed: () {},
            ),
          ),
          Container(
            height: 1,
            color: Colours.background_color2,
          ),
          Container(
            height: 50,
            child: FlatButton(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 3,
                  ),
                  Image.asset('assets/images/user/detail_icon.png',width: 17,height: 17),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      '明细',
                      style: TextStyles.text16MediumLabel,
                    ),
                  ),
                  Image.asset('assets/images/user/arrowmore_big.png',width: 10,height: 17),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => BalanceDetailPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
