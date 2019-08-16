import '../../../common/component_index.dart';

class LimitDiagnoseHead extends StatelessWidget {
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
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  // top: 10,
                  left: 16,
                  right: 16,
                ),
                padding: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 15,
                  // bottom: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colours.white_color,
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '预期提额诊断结果',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colours.blue_color,
                            fontWeight: FontWeights.medium,
                          ),
                        ),
                        Text(
                          '上次提额时间：${quota['Diagnosis']['squpddate']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colours.text_placehold2,
                            fontWeight: FontWeights.medium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      '预期提额率',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colours.blue_color,
                        fontWeight: FontWeights.medium,
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Container(
                      width: 308,
                      height: 155,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/user/yqtel_bg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        '${quota['beoverdue']['amountRate'].toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 55,
                          color: Colours.white_color,
                          fontWeight: FontWeights.medium,
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 150,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 59,
                                ),
                                Text(
                                  '${quota['Diagnosis']['credit_limit']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeights.medium,
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Image.asset(
                                    'assets/images/user/dqkped_img.png'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '当前卡片额度',
                                  style: TextStyles.text12MediumLabel,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 31,
                                ),
                                Text(
                                  '${quota['Diagnosis']['theAmountkey']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeights.medium,
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Image.asset(
                                    'assets/images/user/yjxqktz_img.png'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '预计下期可提至',
                                  style: TextStyles.text12MediumLabel,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  '${quota['Diagnosis']['theAmountmaxkey']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeights.medium,
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Image.asset(
                                    'assets/images/user/yjzgktz_img.png'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '预计最高可提至',
                                  style: TextStyles.text12MediumLabel,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '预提时间',
                        style: TextStyles.text12MediumLabel,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${quota['Diagnosis']['theAmountDate'].toString().substring(0, 2)}',
                            style: TextStyles.text20WhiteMediumLabel,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${quota['Diagnosis']['theAmountDate'].toString().substring(2, 4)}',
                            style: TextStyles.text20WhiteMediumLabel,
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          child: Text(
                            '年',
                            style: TextStyles.text20MediumLabel,
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${quota['Diagnosis']['theAmountDate'].toString().substring(5, 7)}',
                            style: TextStyles.text20WhiteMediumLabel,
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          child: Text(
                            '月',
                            style: TextStyles.text20MediumLabel,
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${quota['Diagnosis']['theAmountDate'].toString().substring(8)}',
                            style: TextStyles.text20WhiteMediumLabel,
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          child: Text(
                            '日',
                            style: TextStyles.text20MediumLabel,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Text(
                            '用卡大于',
                            style: TextStyles.text12MediumLabel,
                          ),
                          Text(
                            '${quota['Diagnosis']['length']}',
                            style: TextStyle(
                              fontSize: Dimens.font_sp12,
                              color: Colors.red,
                              fontWeight: FontWeights.medium,
                            ),
                          ),
                          Text(
                            '个月',
                            style: TextStyles.text12MediumLabel,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset('assets/images/user/cjt_img.png',
                            width: 319, height: 57),
                        Container(
                          width: 320,
                          margin: EdgeInsets.only(
                            top: 44,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  '${quota['repay']['start']}日',
                                  style: TextStyles.text12MediumPPLabel,
                                ),
                              ),
                              Text(
                                '${quota['repay']['end']}日',
                                style: TextStyles.text12MediumPPLabel,
                              ),
                              SizedBox(
                                width: 46,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      // color: Colours.background_color,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          CustomPaint(
                            size: Size(150, 150),
                            painter: MyPainter.dottingArc(
                                quota['repay']['repayRate'], 2),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${quota['repay']['repayRate'].toStringAsFixed(1)}%',
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Colours.blue_color,
                                  fontWeight: FontWeights.medium,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '月平均消费',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colours.blue_color,
                                  fontWeight: FontWeights.medium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('当前银行全国平均卡片额度为',
                            style: TextStyles.text12MediumPPLabel),
                        Text('${quota['Diagnosis']['avglimit']}元',
                            style: TextStyles.text12BlueMediumLabel),
                        Text('您低于', style: TextStyles.text12MediumPPLabel),
                        Text('${quota['Diagnosis']['avglimitRate']}%',
                            style: TextStyles.text12BlueMediumLabel),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('当前银行最高授权额度为',
                            style: TextStyles.text12MediumPPLabel),
                        Text('${quota['Diagnosis']['themaxkey']}元',
                            style: TextStyles.text12BlueMediumLabel),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '免费获取信用资产打造方案',
                                style: TextStyles.text12BlueMediumLabel,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colours.blue_color,
                                size: 12,
                              ),
                            ],
                          ),
                          onPressed: () {},
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
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 15,
                ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset('assets/images/user/dqyhte_icon.png',
                            width: 22, height: 15),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          '当前银行提额主要规则',
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
                      height: 48,
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/user/lgreen_icon.png',
                              width: 12, height: 12),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              '信用报告良好，无逾期',
                              style: TextStyles.text12MediumLabel,
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '逾期修复',
                                  style: TextStyles.text12BlueMediumLabel,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colours.blue_color,
                                  size: 12,
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/user/lorange_icon.png',
                              width: 12, height: 12),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              '个人固定资产良好，负债较低',
                              style: TextStyles.text12MediumLabel,
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '如何降低',
                                  style: TextStyles.text12BlueMediumLabel,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colours.blue_color,
                                  size: 12,
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/user/lblue_icon.png',
                              width: 12, height: 12),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              '新下卡需要间隔6个月，二次及以后提额时间为3个月',
                              style: TextStyles.text12MediumLabel,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/user/ldeepblue_icon.png',
                              width: 12, height: 12),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              '此银行喜欢每月消费25笔以上小金额（300元以下）',
                              style: TextStyles.text12MediumLabel,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/user/lpur_icon.png',
                              width: 12, height: 12),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              '卡不可刷空，长期保持30%以上额度有利于提额；',
                              style: TextStyles.text12MediumLabel,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/user/lred_icon.png',
                              width: 12, height: 12),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              '提额方式为银行主动提升，发送短信告知；',
                              style: TextStyles.text12MediumLabel,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/user/lgreen2_icon.png',
                              width: 12, height: 12),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              '更多规则请联系专属管家',
                              style: TextStyles.text12MediumLabel,
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '立即联系',
                                  style: TextStyles.text12BlueMediumLabel,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colours.blue_color,
                                  size: 12,
                                ),
                              ],
                            ),
                            onPressed: () {},
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
}
