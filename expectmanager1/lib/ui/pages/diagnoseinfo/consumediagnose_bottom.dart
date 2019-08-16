import '../../../common/component_index.dart';

class ConsumeDiagnoseBottom extends StatelessWidget {
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
          List bill = snapshot.data['bill'];
          return Column(
            children: <Widget>[
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
                            width: 15,
                          ),
                          Image.asset('assets/images/user/dqyhte_icon.png',
                              width: 22, height: 15),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            '快进快出消费',
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
                      height: 56,
                      color: Color(0x300DAEFF),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 21,
                      ),
                      child: Text(
                        '经诊断您有存在快进快出消费行为，此类行为可能会导致银行风控封卡或降额，请尽快调整，快进快出明细。',
                        style: TextStyles.text12MediumPPLabel,
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
                            '快进快出数据',
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
                      children: buildQuickCustomItem(
                          bill.cast<Map<dynamic, dynamic>>().toList()),
                    ),
                    Container(
                      height: 36,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            '管理师建议：',
                            style: TextStyles.text12MediumPPLabel,
                          ),
                        ],
                      ),
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
                            '消费时间诊断',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeights.medium,
                              color: Colours.blue_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 166,
                          height: 153,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colours.blue_color,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset(
                                  'assets/images/user/consumeday_img.png',
                                  width: 60,
                                  height: 60),
                              Text(
                                '9:00-21:00正常消费',
                                style: TextStyles.text12WihteMediumLabel,
                              ),
                              Text(
                                '${consumption['paydateDia']['normalcou']}笔',
                                style: TextStyles.text15WhiteMediumLabel,
                              ),
                              Text(
                                '${consumption['paydateDia']['normalmoney']}元',
                                style: TextStyles.text15WhiteMediumLabel,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 166,
                          height: 153,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colours.blue_color,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset(
                                  'assets/images/user/consumenight_img.png',
                                  width: 59,
                                  height: 60),
                              Text(
                                '其他时间消费',
                                style: TextStyles.text12WihteMediumLabel,
                              ),
                              Text(
                                '${consumption['paydateDia']['othercou']}笔',
                                style: TextStyles.text15WhiteMediumLabel,
                              ),
                              Text(
                                '${consumption['paydateDia']['othercoumoney']}元',
                                style: TextStyles.text15WhiteMediumLabel,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 38,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            '每月消费时间明细',
                            style: TextStyles.text15MediumLabel,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60,
                            color: Color(0xFF36A1DC),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 79,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '日期',
                                    style: TextStyles.text15WhiteMediumLabel,
                                  ),
                                ),
                                Container(
                                  width: 2,
                                  height: 60,
                                  color: Color(0x7054C3F1),
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: 262,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            '正常时间消费',
                                            style: TextStyles
                                                .text15WhiteMediumLabel,
                                          ),
                                          Container(
                                            width: 2,
                                            height: 30,
                                            color: Color(0x7054C3F1),
                                          ),
                                          Text(
                                            '其他时间消费',
                                            style: TextStyles
                                                .text15WhiteMediumLabel,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 262,
                                      height: 2,
                                      color: Color(0x7054C3F1),
                                    ),
                                    Container(
                                      width: 262,
                                      height: 28,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            '笔数',
                                            style: TextStyles
                                                .text15WhiteMediumLabel,
                                          ),
                                          Container(
                                            width: 2,
                                            height: 30,
                                            color: Color(0x7054C3F1),
                                          ),
                                          Text(
                                            '金额',
                                            style: TextStyles
                                                .text15WhiteMediumLabel,
                                          ),
                                          Container(
                                            width: 2,
                                            height: 30,
                                            color: Color(0x7054C3F1),
                                          ),
                                          Text(
                                            '笔数',
                                            style: TextStyles
                                                .text15WhiteMediumLabel,
                                          ),
                                          Container(
                                            width: 2,
                                            height: 30,
                                            color: Color(0x7054C3F1),
                                          ),
                                          Text(
                                            '金额',
                                            style: TextStyles
                                                .text15WhiteMediumLabel,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 180,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: bill.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map<dynamic, dynamic> billItem = bill[index];
                                return Container(
                                  height: 30,
                                  color: Colours.background_color,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        width: 2,
                                        height: 30,
                                        color: Color(0x7054C3F1),
                                      ),
                                      Container(
                                        width: 77,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${billItem['year']}年${billItem['month']}月',
                                          style: TextStyles.text12MediumLabel,
                                        ),
                                      ),
                                      Container(
                                        width: 2,
                                        height: 30,
                                        color: Color(0x7054C3F1),
                                      ),
                                      Container(
                                        width: 260,
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text(
                                              '${billItem['nor_date_pay_cou']}',
                                              style:
                                                  TextStyles.text12MediumLabel,
                                            ),
                                            Container(
                                              width: 2,
                                              height: 30,
                                              color: Color(0x7054C3F1),
                                            ),
                                            Text(
                                              '${billItem['nor_date_pay_mon']}',
                                              style:
                                                  TextStyles.text12MediumLabel,
                                            ),
                                            Container(
                                              width: 2,
                                              height: 30,
                                              color: Color(0x7054C3F1),
                                            ),
                                            Text(
                                              '${billItem['other_date_pay_cou']}',
                                              style:
                                                  TextStyles.text12MediumLabel,
                                            ),
                                            Container(
                                              width: 2,
                                              height: 30,
                                              color: Color(0x7054C3F1),
                                            ),
                                            Text(
                                              '${billItem['other_date_pay_mon']}',
                                              style:
                                                  TextStyles.text12MediumLabel,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 2,
                                        height: 30,
                                        color: Color(0x7054C3F1),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            height: 2,
                            color: Color(0x7054C3F1),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 35,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            '管理师建议：',
                            style: TextStyles.text12MediumPPLabel,
                          ),
                        ],
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
                  left: 16,
                  right: 16,
                ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 44,
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/user/dqyhte_icon.png',
                              width: 22, height: 15),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            '取现消费',
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
                      height: 61,
                      color: Color(0x300DAEFF),
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '近12个月有',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['cash12']['count']}',
                                style: TextStyles.text15RedMediumLabel,
                              ),
                              Text(
                                '次取现消费，共计',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['cash12']['money']}元',
                                style: TextStyles.text15RedMediumLabel,
                              ),
                              Text(
                                '；',
                                style: TextStyles.text15MediumLabel,
                              ),
                            ],
                          ),
                          Text(
                            '${consumption['paymode']['cash12']['msg']}',
                            style: TextStyles.text12MediumPPLabel,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 36,
                      child: Row(
                        children: <Widget>[
                          Text(
                            '管理师建议：建议一年1-2次小金额，有助于提额。',
                            style: TextStyles.text12MediumPPLabel,
                          ),
                        ],
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
                  left: 16,
                  right: 16,
                ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 44,
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/user/dqyhte_icon.png',
                              width: 22, height: 15),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            '境外消费',
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
                      height: 61,
                      color: Color(0x300DAEFF),
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '近12个月有',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['abroadpay12']['count']}',
                                style: TextStyles.text15RedMediumLabel,
                              ),
                              Text(
                                '次境外消费，共计',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['abroadpay12']['money']}元',
                                style: TextStyles.text15RedMediumLabel,
                              ),
                              Text(
                                '；',
                                style: TextStyles.text15MediumLabel,
                              ),
                            ],
                          ),
                          Text(
                            '${consumption['paymode']['abroadpay12']['msg']}',
                            style: TextStyles.text12MediumPPLabel,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 36,
                      child: Row(
                        children: <Widget>[
                          Text(
                            '管理师建议：此银行非常喜欢境外消费，有助于强提额。',
                            style: TextStyles.text12MediumPPLabel,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
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

  List<Widget> buildQuickCustomItem(List<Map<dynamic, dynamic>> dataList) {
    List<Widget> widgetList = List<Widget>();
    for (int i = 0; i < dataList.length; i++) {
      Map dataItem = dataList[i];
      Widget wd = Column(
        children: <Widget>[
          Container(
            height: 48,
            padding: EdgeInsets.only(
              left: 15,
              right: 14,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${dataItem['year']}年${dataItem['month']}月',
                  style: TextStyles.text15MediumPPLabel,
                ),
                Text(
                  dataItem['imex'] == 'yes' ? '有' : '无',
                  style: TextStyles.text15RedMediumLabel,
                ),
                Text(
                  '${dataItem['imexmsg']}',
                  style: TextStyles.text15MediumLabel,
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
