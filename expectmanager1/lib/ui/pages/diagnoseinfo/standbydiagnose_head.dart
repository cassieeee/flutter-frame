import '../../../common/component_index.dart';

class StandbyDiagnoseHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CardDiagnoseBloc cardDiagnoseBloc =
        BlocProvider.of<CardDiagnoseBloc>(context);
    return StreamBuilder(
        stream: cardDiagnoseBloc.cardDiagnoseStream,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) return Container();
          Map quota = snapshot.data['quota'];
          Map consumption = snapshot.data['consumption'];
          Map other = snapshot.data['other'];
          List bill = snapshot.data['bill'];
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    // top: 10,
                    ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 44,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Image.asset('assets/images/user/dqyhte_icon.png',
                              width: 22, height: 15),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            '备用金诊断',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeights.medium,
                              color: Colours.blue_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 38,
                      color: Color(0x300DAEFF),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            '当前无备用金',
                            style: TextStyles.text15MediumLabel,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 38,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            '备用金提升空间',
                            style: TextStyles.text15MediumLabel,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Column(
                      children: buildInfoItem(other['reserve']['lists']
                          .cast<Map<dynamic, dynamic>>()
                          .toList()),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 44,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Image.asset('assets/images/user/dqyhte_icon.png',
                              width: 22, height: 15),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            '积分诊断',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeights.medium,
                              color: Colours.blue_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 160,
                          color: Color(0x300DAEFF),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 114,
                                height: 136,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/user/jfzd_bg.png'),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      '${consumption['amountRate']}%',
                                      style: TextStyles.text12WihteMediumLabel,
                                    ),
                                    Text(
                                      '${other['integral']['key']}',
                                      style: TextStyles.text12WihteMediumLabel,
                                    ),
                                    Text(
                                      '${consumption['paymode']['monthray12']['money']}',
                                      style: TextStyles.text12WihteMediumLabel,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    '近12个月${consumption['amountRate']}%的消费没有积分。',
                                    style: TextStyles.text12MediumLabel,
                                  ),
                                  Text(
                                    '近12个月获得积分${other['integral']['key']}。',
                                    style: TextStyles.text12MediumLabel,
                                  ),
                                  Text(
                                    '近12个月消费金额${consumption['paymode']['monthray12']['money']}元。',
                                    style: TextStyles.text12MediumLabel,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 158,
                          top: 15,
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
                          left: 164,
                          top: 17.5,
                          child: Container(
                            width: 190,
                            height: 1,
                            color: Colours.text_placehold,
                          ),
                        ),
                        Positioned(
                          left: 354,
                          top: 15,
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
                          left: 190,
                          top: 60,
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
                          left: 196,
                          top: 62.5,
                          child: Container(
                            width: 163,
                            height: 1,
                            color: Colours.text_placehold,
                          ),
                        ),
                        Positioned(
                          left: 354,
                          top: 60,
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
                          left: 217,
                          top: 103,
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
                          left: 224,
                          top: 105.5,
                          child: Container(
                            width: 130,
                            height: 1,
                            color: Colours.text_placehold,
                          ),
                        ),
                        Positioned(
                          left: 354,
                          top: 103,
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
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 44,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Image.asset('assets/images/user/dqyhte_icon.png',
                              width: 22, height: 15),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            '卡片负债率',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeights.medium,
                              color: Colours.blue_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 166,
                      height: 166,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/user/edbll_bg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${quota['quotaRate']['amountRate'].toStringAsFixed(1)}%',
                            style: TextStyle(
                              fontSize: 35,
                              color: Colours.blue_color,
                              fontWeight: FontWeights.medium,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            '近1年负债率',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colours.blue_color,
                              fontWeight: FontWeights.medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          '管理师建议：此银行建议额度保持率30%以上有助于提额。',
                          style: TextStyles.text12MediumPPLabel,
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '每月负债明细',
                            style: TextStyles.text15MediumLabel,
                          ),
                          Text(
                            '负债率',
                            style: TextStyles.text15MediumLabel,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 338,
                      child: ListView.builder(
                        itemCount: bill.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          Map billItem = bill[index];
                          return Container(
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Text(
                                    '${billItem['year']}年${billItem['month']}月',
                                    style: TextStyles.text15MediumPPLabel,
                                  ),
                                  trailing: Text(
                                    '${billItem['amountRate']}%',
                                    style: TextStyles.text15BlueMediumLabel,
                                  ),
                                ),
                                Container(
                                  height: 0.5,
                                  color: Colours.background_color2,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                height: 45,
                child: Column(
                  children: <Widget>[
                    Text(
                      '数据有误，请参考官网',
                      style: TextStyles.text12MediumPLabel,
                    ),
                    Text(
                      '此报告解释权归期望管家',
                      style: TextStyles.text12MediumPLabel,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  List<Widget> buildInfoItem(List<Map<dynamic, dynamic>> dataList) {
    List<Widget> widgetList = List<Widget>();
    for (int i = 0; i < dataList.length; i++) {
      Map dataItem = dataList[i];
      Widget wd = Column(
        children: <Widget>[
          Container(
            height: 62,
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 280 * Screen.screenRate,
                  child: Text(
                    '${dataItem['title']}',
                    style: TextStyles.text15MediumPPLabel,
                  ),
                ),
                Container(
                  // width: 80 * Screen.screenRate,
                  child: Text(
                    '${dataItem['keys']}',
                    style: TextStyles.text15RedMediumLabel,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Colours.background_color2,
          ),
        ],
      );
      widgetList.add(wd);
    }
    return widgetList;
  }
}
