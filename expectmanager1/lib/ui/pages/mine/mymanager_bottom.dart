import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class MyManagerBottom extends StatefulWidget {
  MyManagerBottom(this.mapItem);
  final Map<String, dynamic> mapItem;
  @override
  State<StatefulWidget> createState() {
    return MyManagerBottomState(mapItem);
  }
}

class MyManagerBottomState extends State<MyManagerBottom>
    with AutomaticKeepAliveClientMixin {
  MyManagerBottomState(this.mapItem);
  Map<String, dynamic> mapItem;
  MyManagerBloc myManagerBloc;
  Map cardData = Map();
  Widget build(BuildContext context) {
    super.build(context);
    myManagerBloc = BlocProvider.of<MyManagerBloc>(context);
    myManagerBloc.bloccontext = context;
    if (myManagerBloc.isBillOpen) {
      if (cardData.isEmpty)
        Future.delayed(new Duration(milliseconds: 10)).then((_) {
          if (mapItem['orderList'] != null &&
              mapItem['orderList'].length > 0) if (myManagerBloc.orderId == 0)
            myManagerBloc.orderId = mapItem['orderList'][0]['id'];
          myManagerBloc.getMasterOrderCards(mapItem['orderList'][0]['id']);
        });
      myManagerBloc.isBillOpen = false;
    }

    return StreamBuilder(
      stream: myManagerBloc.orderCardsStream,
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (!snapshot.hasData) return Container();
        cardData = snapshot.data;
        return Column(
          children: <Widget>[
            //代管信息
            Container(
              height: 54,
              color: Colours.background_color2,
              padding: EdgeInsets.only(
                top: 7,
                bottom: 7,
                left: 15,
                right: 15,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 130,
                        alignment: Alignment.center,
                        child: Text(
                          cardData['cardInfoList'] != null
                              ? '${cardData['cardInfoList'].length}'
                              : '0',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeights.medium,
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        alignment: Alignment.center,
                        child: Text(
                          cardData['totalDelegateMoney'] != null
                              ? '${double.tryParse(cardData['totalDelegateMoney'].toString()).toStringAsFixed(2)}'
                              : '0.00',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeights.medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 130,
                        alignment: Alignment.center,
                        child: Text(
                          '代管卡数(张)',
                          style: TextStyles.text13MediumLabel,
                        ),
                      ),
                      Container(
                        width: 130,
                        alignment: Alignment.center,
                        child: Text(
                          '代管总金额(元)',
                          style: TextStyles.text13MediumLabel,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              // height: Screen.height - 50 - Screen.navigationBarHeight - 64,
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: ListView.builder(
                itemCount: cardData['cardInfoList'].length,
                // itemExtent: 73,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> cardItem =
                      cardData['cardInfoList'][index];
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage.assetNetwork(
                              placeholder:
                                  "assets/images/user/card_default.jpeg",
                              image: cardItem['icon'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          cardItem['bankName'] != null
                              ? '${cardItem['bankName']}银行'
                              : '银行',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colours.text_placehold2,
                            fontWeight: FontWeights.medium,
                          ),
                        ),
                        subtitle: Text(
                          cardItem['cardId'] != null
                              ? '${cardItem['cardId']}'
                              : '',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colours.text_placehold2,
                            fontWeight: FontWeights.medium,
                          ),
                        ),
                        trailing: Stack(
                          children: <Widget>[
                            Container(
                              width: 90,
                              child: Text(
                                cardItem['usableMoney'] != null
                                    ? '${cardItem['usableMoney']}'
                                    : '0.00',
                                style: TextStyles.text14MediumLabel,
                              ),
                            ),
                            Positioned(
                              left: 70,
                              top: -3.5,
                              child: Icon(Icons.keyboard_arrow_right),
                            ),
                          ],
                        ),
                        onTap: () {
                          CardItemModel cardItemModel =
                              CardItemModel.fromJson(cardItem);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreditDetailPage(2, cardItemModel),
                            ),
                          );
                        },
                      ),
                      Container(
                        width: 343,
                        height: 1,
                        color: Colours.background_color2,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
