import '../../../common/component_index.dart';

class ConsumeDiagnoseHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CardDiagnoseBloc cardDiagnoseBloc =
        BlocProvider.of<CardDiagnoseBloc>(context);
    return StreamBuilder(
        stream: cardDiagnoseBloc.cardDiagnoseStream,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) return Container();
          Map consumption = snapshot.data['consumption'];
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  // top: 10,
                ),
                padding: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 12,
                ),
                height: 197,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colours.white_color,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '整体消费诊断',
                          style: TextStyles.text16BlueMediumLabel,
                        ),
                        Container(
                          width: 111,
                          height: 22,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: Colours.blue_color,
                          ),
                          child: Text(
                            '中等消费人群',
                            style: TextStyles.text12WihteMediumLabel,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Stack(
                      children: <Widget>[
                        CustomPaint(
                          size: Size(100, 100),
                          painter: MyPainter.dottingArc(
                              consumption['amountRate'], 3),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${consumption['amountRate'].toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colours.blue_color,
                                  fontWeight: FontWeights.medium,
                                ),
                              ),
                              Text(
                                '消费指数',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colours.blue_color,
                                  fontWeight: FontWeights.medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      '提醒：${consumption['amountMsg']}',
                      style: TextStyles.text12Red15MediumLabel,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                padding: EdgeInsets.only(
                  top: 10,
                ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset('assets/images/user/dqyhte_icon.png',
                            width: 22, height: 15),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          '此银行提额喜欢的消费方式',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeights.medium,
                            color: Colours.blue_color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Color(0x300DAEFF),
                      child: Column(
                        children: buildBankLikeItem(consumption['lists']
                            .cast<Map<dynamic, dynamic>>()
                            .toList()),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                padding: EdgeInsets.only(
                  top: 12,
                ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset('assets/images/user/dqyhte_icon.png',
                            width: 22, height: 15),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          '消费金额及笔数',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeights.medium,
                            color: Colours.blue_color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          '最近一年消费金额及笔数',
                          style: TextStyles.text15MediumLabel,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 180,
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      color: Color(0x300DAEFF),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '总笔数：',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Expanded(
                                child: Text(
                                  '${consumption['paymode']['monthray12']['count']}',
                                  style: TextStyles.text15RedMediumLabel,
                                ),
                              ),
                              Text(
                                '总金额：',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['monthray12']['money']}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF00BB00),
                                  fontWeight: FontWeights.medium,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Stack(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    width: 108,
                                    height: 118,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/user/xfje_img.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 0,
                                        ),
                                        Text(
                                          '${consumption['paymode']['monthray12']['rate3']}%',
                                          style:
                                              TextStyles.text12WihteMediumLabel,
                                        ),
                                        Text(
                                          '${consumption['paymode']['monthray12']['rate2']}%',
                                          style:
                                              TextStyles.text12WihteMediumLabel,
                                        ),
                                        Text(
                                          '${consumption['paymode']['monthray12']['rate1']}%',
                                          style:
                                              TextStyles.text12WihteMediumLabel,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Text(
                                        '5000元以上消费${consumption['paymode']['monthray12']['count3']}笔',
                                        style: TextStyles.text12MediumLabel,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '1000-4999元消费${consumption['paymode']['monthray12']['count2']}笔',
                                        style: TextStyles.text12MediumLabel,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '1000元以下消费${consumption['paymode']['monthray12']['count1']}笔',
                                        style: TextStyles.text12MediumLabel,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                left: 118,
                                top: 10,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colours.text_placehold2,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 124,
                                top: 12.5,
                                child: Container(
                                  width: 190,
                                  height: 1,
                                  color: Colours.text_placehold,
                                ),
                              ),
                              Positioned(
                                left: 314,
                                top: 10,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colours.text_placehold2,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 150,
                                top: 45,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colours.text_placehold2,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 156,
                                top: 47.5,
                                child: Container(
                                  width: 163,
                                  height: 1,
                                  color: Colours.text_placehold,
                                ),
                              ),
                              Positioned(
                                left: 314,
                                top: 45,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colours.text_placehold2,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 177,
                                top: 78,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colours.text_placehold2,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 184,
                                top: 80.5,
                                child: Container(
                                  width: 130,
                                  height: 1,
                                  color: Colours.text_placehold,
                                ),
                              ),
                              Positioned(
                                left: 314,
                                top: 78,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colours.text_placehold2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          '最近一年支付方式',
                          style: TextStyles.text15MediumLabel,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset('assets/images/user/dzzf_img.png',
                                  width: 100, height: 75),
                              Text(
                                '电子支付${consumption['paymode']['elpay']['rate']}%',
                                style: TextStyles.text15BlueMediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['elpay']['count']}笔',
                                style: TextStyles.text15RedMediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['elpay']['money']}',
                                style: TextStyles.text15GreenMediumLabel,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset('assets/images/user/posjzf_img.png',
                                  width: 100, height: 75),
                              Text(
                                'POS支付${consumption['paymode']['posPay']['rate']}%',
                                style: TextStyles.text15BlueMediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['posPay']['count']}笔',
                                style: TextStyles.text15RedMediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['posPay']['money']}',
                                style: TextStyles.text15GreenMediumLabel,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset('assets/images/user/qtzf_img.png',
                                  width: 78, height: 75),
                              Text(
                                '其他支付${consumption['paymode']['otherpay']['rate']}%',
                                style: TextStyles.text15BlueMediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['otherpay']['count']}笔',
                                style: TextStyles.text15RedMediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['otherpay']['money']}',
                                style: TextStyles.text15GreenMediumLabel,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  List<Widget> buildBankLikeItem(List<Map<dynamic, dynamic>> dataList) {
    List<Widget> widgetList = List<Widget>();
    for (int i = 0; i < dataList.length; i++) {
      Map dataItem = dataList[i];
      Widget wd = Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/user/yhtexf1_img.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(
                  '$i',
                  style: TextStyles.text15WhiteMediumLabel,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 270 * Screen.screenRate,
                child: Text(
                  '${dataItem['title']}',
                  style: TextStyles.text15MediumLabel,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      );
      widgetList.add(wd);
    }
    return widgetList;
  }
}
