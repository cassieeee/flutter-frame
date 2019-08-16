import '../../../common/component_index.dart';

class LimitDiagnoseMiddle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CardDiagnoseBloc cardDiagnoseBloc =
        BlocProvider.of<CardDiagnoseBloc>(context);
    return StreamBuilder(
        stream: cardDiagnoseBloc.cardDiagnoseStream,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if(!snapshot.hasData) return Container();
          Map quota = snapshot.data['quota'];
          List bill = snapshot.data['bill'];
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                padding: EdgeInsets.only(
                  top: 15,
                ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset('assets/images/user/dqyhte_icon.png',width: 22,height: 15),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          '信用卡逾期数据',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeights.medium,
                            color: Colours.blue_color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 58,
                      color: Color(0x500DAEFF),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '诊断结果：近${quota['beoverdue']['month']}个月逾期${quota['beoverdue']['count']}次',
                                style: TextStyles.text15MediumLabel,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '建议：${quota['beoverdue']['amountMsg']}',
                                style: TextStyles.text12MediumPPLabel,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 38,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            '逾期记录：',
                            style: TextStyles.text15MediumLabel,
                          ),
                          Text(
                            '通过账单获取，具体请参考征信报告详情；',
                            style: TextStyles.text15MediumPPLabel,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 282,
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: bill.length,
                        physics: new NeverScrollableScrollPhysics(), // 禁止用户滑动
                        itemBuilder: (BuildContext context, int index) {
                          Map billItem = bill[index];
                          return Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  '${billItem['year']}年${billItem['month']}月',
                                  style: TextStyles.text15MediumPPLabel,
                                ),
                                trailing: Text(
                                  billItem['is_overdue'] == 'yes'
                                      ? '有逾期'
                                      : '无逾期',
                                  style: billItem['is_overdue'] == 'yes'
                                      ? TextStyles.text15RedMediumLabel
                                      : TextStyles.text15MediumLabel,
                                ),
                              ),
                              Container(
                                height: 0.5,
                                width: 343,
                                color: Colours.background_color,
                              ),
                            ],
                          );
                        },
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
                  top: 14,
                ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset('assets/images/user/dqyhte_icon.png',width: 22,height: 15),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          '额度使用率',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeights.medium,
                            color: Colours.blue_color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
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
                            '${quota['quotaRate']['use'].toStringAsFixed(1)}%',
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
                            '近${bill.length}个月使用率',
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
                          width: 15,
                        ),
                        Text(
                          '提额建议：此银行建议额度保持率30%以上有助于提额。',
                          style: TextStyles.text12MediumPPLabel,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text('每月使用明细',
                              style: TextStyles.text15MediumLabel),
                        ),
                        Text('使用率', style: TextStyles.text15MediumLabel),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 47.0*bill.length,
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: bill.length,
                        physics: new NeverScrollableScrollPhysics(), // 禁止用户滑动
                        itemBuilder: (BuildContext context, int index) {
                          Map billItem = bill[index];
                          return Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  '${billItem['year']}年${billItem['month']}月',
                                  style: TextStyles.text15MediumPPLabel,
                                ),
                                trailing: Text(
                                  '${billItem['use']}%',
                                  style: TextStyles.text15BlueMediumLabel,
                                ),
                              ),
                              Container(
                                height: 0.5,
                                width: 343,
                                color: Colours.background_color,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
