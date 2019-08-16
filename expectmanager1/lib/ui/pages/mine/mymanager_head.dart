import '../../../common/component_index.dart';

class MyManagerHead extends StatefulWidget {
  MyManagerHead(this.mapItem);
  final Map<String, dynamic> mapItem;
  @override
  State<StatefulWidget> createState() {
    return MyManagerHeadState(mapItem);
  }
}

class MyManagerHeadState extends State<MyManagerHead> {
  MyManagerHeadState(this.mapItem);
  Map<String, dynamic> mapItem;
  Map cardData = Map();
  String orderStr = '订单1';
  MyManagerBloc myManagerBloc;
  Widget build(BuildContext context) {
    myManagerBloc = BlocProvider.of<MyManagerBloc>(context);
    myManagerBloc.bloccontext = context;

    return StreamBuilder(
      stream: myManagerBloc.orderCardsStream,
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        cardData = snapshot.data;
        if (!snapshot.hasData)
          return Stack(
            children: <Widget>[
              Container(
                height: 146,
                color: Colours.blue_color,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 68,
                      height: 68,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(34),
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/user/head_default.jpeg",
                          image: mapItem['icon'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 112,
                        ),
                        Text(
                          mapItem['name'] != null ? '${mapItem['name']}' : '',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colours.background_color,
                            fontWeight: FontWeights.medium,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 56,
                          height: 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: Color.fromARGB(50, 0, 0, 0),
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/images/user/pauth_icon.png',
                                    width: 9, height: 9),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  mapItem['isCertification'] == 1
                                      ? '已实名'
                                      : '未实名',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colours.background_color,
                                    fontWeight: FontWeights.medium,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      mapItem['account'] != null ? '${mapItem['account']}' : '',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeights.medium,
                        color: Color(0xFFFFFEFE),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 44,
                margin: EdgeInsets.only(
                  top: 146,
                ),
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/user/mgender_icon.png',
                              width: 14, height: 12),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            mapItem['sex'] != null
                                ? '性别：${mapItem['sex']}'
                                : '性别：男',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeights.medium,
                              color: Colours.text_placehold2,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 1,
                            height: 10,
                            color: Color(0xFFCCCCCC),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/user/mage_icon.png',
                              width: 12, height: 12),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            mapItem['age'] != null
                                ? '年龄：${mapItem['age']}'
                                : '年龄：',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeights.medium,
                              color: Colours.text_placehold2,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 1,
                            height: 10,
                            color: Color(0xFFCCCCCC),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/user/mworkday_icon.png',
                              width: 12, height: 12),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            mapItem['workAge'] != null
                                ? '工龄：${mapItem['workAge']}'
                                : '工龄：',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeights.medium,
                              color: Colours.text_placehold2,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 1,
                            height: 10,
                            color: Color(0xFFCCCCCC),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/user/mregion_icon.png',
                              width: 10, height: 12),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            mapItem['area'] != null
                                ? '所在地：${mapItem['area']}'
                                : '所在地：',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeights.medium,
                              color: Colours.text_placehold2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 44,
                margin: EdgeInsets.only(
                  top: 200,
                ),
                color: Colours.white_color,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: 16,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '订单',
                        style: TextStyles.text16MediumLabel,
                      ),
                    ),
                    Container(
                      width: 85,
                      // alignment: Alignment.center,
                      padding: EdgeInsets.only(
                        left: 5,
                        right: 16,
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '$orderStr',
                              style: TextStyles.text16MediumLabel,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Image.asset('assets/images/user/arrow_sdown.png'),
                          ],
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200 * Screen.screenRate,
                                margin: EdgeInsets.only(
                                  top: (Screen.height -
                                          200 * Screen.screenRate) /
                                      2.0,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)),
                                child: ListView.builder(
                                  itemCount: mapItem['orderList'].length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Map orderItem = mapItem['orderList'][index];
                                    return Column(
                                      children: <Widget>[
                                        Container(
                                          width: 343,
                                          height: 40,
                                          color: Colours.white_color,
                                          child: FlatButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  '订单${index + 1}',
                                                  style: TextStyles
                                                      .text16MediumLabel,
                                                ),
                                                Text(
                                                  '${orderItem['createTime']}',
                                                  style: TextStyles
                                                      .text16MediumLabel,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              orderStr = '订单${index + 1}';
                                              Future.delayed(new Duration(
                                                      milliseconds: 10))
                                                  .then((_) {
                                                myManagerBloc.orderId =
                                                    mapItem['orderList'][index]
                                                        ['id'];
                                                myManagerBloc
                                                    .getMasterOrderCards(
                                                        mapItem['orderList']
                                                            [index]['id']);

                                                StringBuffer startTMD =
                                                    StringBuffer();
                                                StringBuffer endTMD =
                                                    StringBuffer();
                                                startTMD.write(DateUtil
                                                    .getDateStrByDateTime(
                                                        myManagerBloc
                                                            .startTimeDate,
                                                        format: DateFormat
                                                            .YEAR_MONTH_DAY));
                                                startTMD.write(' 00:00:00');
                                                endTMD.write(DateUtil
                                                    .getDateStrByDateTime(
                                                        myManagerBloc
                                                            .endTimeDate,
                                                        format: DateFormat
                                                            .YEAR_MONTH_DAY));
                                                endTMD.write(' 23:59:59');
                                                myManagerBloc.getPlanLists(
                                                    2, false, [1, 2],
                                                    startTime:
                                                        startTMD.toString(),
                                                    endTime: endTMD.toString(),
                                                    masterId:
                                                        widget.mapItem['id']);
                                              });
                                            },
                                          ),
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
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colours.background_color2,
                margin: EdgeInsets.only(
                  top: 244,
                ),
              ),
              Container(
                height: 44,
                margin: EdgeInsets.only(
                  top: 245,
                ),
                color: Colours.white_color,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                        left: 16,
                      ),
                      child: Text(
                        '托管类型',
                        style: TextStyles.text15MediumLabel,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                        right: 16,
                      ),
                      child: Text(
                        '',
                        style: TextStyles.text15MediumLabel,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        int delegateType = cardData['delegateType'];
        return Stack(
          children: <Widget>[
            Container(
              height: 146,
              color: Colours.blue_color,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 68,
                    height: 68,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(34),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/user/head_default.jpeg",
                        image: mapItem['icon'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 112,
                      ),
                      Text(
                        mapItem['name'] != null ? '${mapItem['name']}' : '',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colours.background_color,
                          fontWeight: FontWeights.medium,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 56,
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: Color.fromARGB(50, 0, 0, 0),
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/images/user/pauth_icon.png',
                                  width: 9, height: 9),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                mapItem['isCertification'] == 1 ? '已实名' : '未实名',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colours.background_color,
                                  fontWeight: FontWeights.medium,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    mapItem['account'] != null ? '${mapItem['account']}' : '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeights.medium,
                      color: Color(0xFFFFFEFE),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 44,
              margin: EdgeInsets.only(
                top: 146,
              ),
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Image.asset('assets/images/user/mgender_icon.png',
                            width: 14, height: 12),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          mapItem['sex'] != null
                              ? '性别：${mapItem['sex']}'
                              : '性别：男',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeights.medium,
                            color: Colours.text_placehold2,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          width: 1,
                          height: 10,
                          color: Color(0xFFCCCCCC),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Image.asset('assets/images/user/mage_icon.png',
                            width: 12, height: 12),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          mapItem['age'] != null
                              ? '年龄：${mapItem['age']}'
                              : '年龄：',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeights.medium,
                            color: Colours.text_placehold2,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          width: 1,
                          height: 10,
                          color: Color(0xFFCCCCCC),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Image.asset('assets/images/user/mworkday_icon.png',
                            width: 12, height: 12),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          mapItem['workAge'] != null
                              ? '工龄：${mapItem['workAge']}'
                              : '工龄：',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeights.medium,
                            color: Colours.text_placehold2,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          width: 1,
                          height: 10,
                          color: Color(0xFFCCCCCC),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Image.asset('assets/images/user/mregion_icon.png',
                            width: 10, height: 12),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          mapItem['area'] != null
                              ? '所在地：${mapItem['area']}'
                              : '所在地：',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeights.medium,
                            color: Colours.text_placehold2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 44,
              margin: EdgeInsets.only(
                top: 200,
              ),
              color: Colours.white_color,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 16,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '订单',
                      style: TextStyles.text16MediumLabel,
                    ),
                  ),
                  Container(
                    width: 85,
                    // alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 16,
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '$orderStr',
                            style: TextStyles.text16MediumLabel,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Image.asset('assets/images/user/arrow_sdown.png'),
                        ],
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200 * Screen.screenRate,
                              margin: EdgeInsets.only(
                                top: (Screen.height - 200 * Screen.screenRate) /
                                    2.0,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: ListView.builder(
                                itemCount: mapItem['orderList'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  Map orderItem = mapItem['orderList'][index];
                                  return Column(
                                    children: <Widget>[
                                      Container(
                                        width: 343,
                                        height: 40,
                                        color: Colours.white_color,
                                        child: FlatButton(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text(
                                                '订单${index + 1}',
                                                style: TextStyles
                                                    .text16MediumLabel,
                                              ),
                                              Text(
                                                '${orderItem['createTime']}',
                                                style: TextStyles
                                                    .text16MediumLabel,
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            orderStr = '订单${index + 1}';
                                            Future.delayed(new Duration(
                                                    milliseconds: 10))
                                                .then((_) {
                                              myManagerBloc.orderId =
                                                  mapItem['orderList'][index]
                                                      ['id'];
                                              myManagerBloc.getMasterOrderCards(
                                                  mapItem['orderList'][index]
                                                      ['id']);

                                              StringBuffer startTMD =
                                                  StringBuffer();
                                              StringBuffer endTMD =
                                                  StringBuffer();
                                              startTMD.write(
                                                  DateUtil.getDateStrByDateTime(
                                                      myManagerBloc
                                                          .startTimeDate,
                                                      format: DateFormat
                                                          .YEAR_MONTH_DAY));
                                              startTMD.write(' 00:00:00');
                                              endTMD.write(
                                                  DateUtil.getDateStrByDateTime(
                                                      myManagerBloc.endTimeDate,
                                                      format: DateFormat
                                                          .YEAR_MONTH_DAY));
                                              endTMD.write(' 23:59:59');
                                              myManagerBloc.getPlanLists(
                                                  2, false, [1, 2],
                                                  startTime:
                                                      startTMD.toString(),
                                                  endTime: endTMD.toString(),
                                                  masterId:
                                                      widget.mapItem['id']);
                                            });
                                          },
                                        ),
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
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colours.background_color2,
              margin: EdgeInsets.only(
                top: 244,
              ),
            ),
            Container(
              height: 44,
              margin: EdgeInsets.only(
                top: 245,
              ),
              color: Colours.white_color,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: 16,
                    ),
                    child: Text(
                      '托管类型',
                      style: TextStyles.text15MediumLabel,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      right: 16,
                    ),
                    child: Text(
                      delegateType == 3
                          ? '提额代操'
                          : delegateType == 2 ? '精养代操' : '单次代操',
                      style: TextStyles.text15MediumLabel,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
