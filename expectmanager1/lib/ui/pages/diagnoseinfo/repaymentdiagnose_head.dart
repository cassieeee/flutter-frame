import '../../../common/component_index.dart';

class RepaymentDiagnoseHead extends StatelessWidget {
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
          Map repayment = snapshot.data['repayment'];
          List bill = snapshot.data['bill'];
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
                ),
                height: 267,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colours.white_color,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 44,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '整体还款指数评分',
                        style: TextStyles.text16BlueMediumLabel,
                      ),
                    ),
                    Container(
                      width: 319,
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 222.5,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 47,
                            left: 87,
                            child: Container(
                              width: 163,
                              height: 170,
                              child: Stack(
                                children:
                                    buildGradeChildren(repayment['amountRate']),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 96,
                            child: Text(
                              '${repayment['amountRate'].toStringAsFixed(0)}分',
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.red,
                                fontWeight: FontWeights.medium,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 59,
                            left: 120,
                            child: Text(
                              '不佳',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeights.medium,
                              ),
                            ),
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
                          Image.asset('assets/images/user/dqyhte_icon.png',width: 22,height: 15),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            '还款日期分析',
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
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 156,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xFFCCCCCC),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${repayment['repday']['front']}次',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ),
                              Text(
                                '账单日前还款',
                                style: TextStyles.text15MediumLabel,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 156,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colours.blue_color,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${repayment['repday']['after']}次',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                '账单日后还款',
                                style: TextStyles.text15MediumLabel,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 36,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            '管理师建议：偶尔在账单日前还款有助于降低负债实现提额；',
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
                          Image.asset('assets/images/user/dqyhte_icon.png',width: 22,height: 15),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            '还款笔数分析',
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
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 15,
                      ),
                      color: Color(0x300DAEFF),
                      alignment: Alignment.center,
                      child: Text(
                        '近${quota['beoverdue']['month']}个月还款笔数为${repayment['repmode']['mont12']['count']}笔',
                        style: TextStyles.text15MediumPPLabel,
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
                            '每月还款笔数分析',
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
                      height: 48.5 * bill.length,
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 16,
                      ),
                      child: ListView.builder(
                        itemCount: bill.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          Map billItem = bill[index];
                          return Column(
                            children: <Widget>[
                              Container(
                                height: 48,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '${billItem['year']}年${billItem['month']}月',
                                      style: TextStyles.text15MediumPPLabel,
                                    ),
                                    Text(
                                      '还款${billItem['repaycount']}笔',
                                      style: TextStyles.text15MediumLabel,
                                    ),
                                    Text(
                                      '消费${billItem['count']}笔',
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
                        },
                      ),
                    ),
                    Container(
                      height: 54,
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '管理师建议：尽量每次还款不能超过3次，否则银行会认定您资产较低；',
                        style: TextStyles.text12MediumPPLabel,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  List<Widget> buildGradeChildren(grade) {
    List<Widget> gradeChildrenList = List<Widget>();
    double gap = 4;
    double boxWidth = (163.0 - gap * 11) / 10;
    double boxHeight = (170.0 - gap * 12) / 11;
    int minus = 100 - grade;
    int index = 0;
    for (int i = 0; i < 11; i++) {
      for (int j = 0; j < 10; j++) {
        if (j < 5 && (i == 0 || i == 1)) continue;
        index++;
        Widget box = Positioned(
          left: gap + (gap + boxWidth) * j,
          top: gap + (gap + boxHeight) * i,
          width: boxWidth,
          height: boxHeight,
          child: Container(
            color:
                index <= minus ? Colours.background_color2 : Colours.blue_color,
          ),
        );
        gradeChildrenList.add(box);
      }
    }
    return gradeChildrenList;
  }
}
