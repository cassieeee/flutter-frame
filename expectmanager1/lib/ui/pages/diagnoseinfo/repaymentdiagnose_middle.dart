import '../../../common/component_index.dart';

class RepaymentDiagnoseMiddle extends StatelessWidget {
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
                child: Column(
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
                                  width: 16,
                                ),
                                Image.asset(
                                    'assets/images/user/dqyhte_icon.png',
                                    width: 22,
                                    height: 15),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  '还款金额分析',
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
                          Container(
                            height: 68,
                            color: Color(0x300DAEFF),
                            padding: EdgeInsets.only(
                              left: 28,
                              right: 28,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      '最近一年',
                                      style: TextStyles.text15MediumLabel,
                                    ),
                                    Text(
                                      '${repayment['result']}',
                                      style: TextStyles.text15RedMediumLabel,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      '全额还款',
                                      style: TextStyles.text15MediumLabel,
                                    ),
                                    Text(
                                      '${repayment['repmode']['mont12']['wholecount']}次',
                                      style: TextStyles.text15RedMediumLabel,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      '最低还款',
                                      style: TextStyles.text15MediumLabel,
                                    ),
                                    Text(
                                      '${repayment['repmode']['mont12']['mincount']}次',
                                      style: TextStyles.text15RedMediumLabel,
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
                                  '还款金额明细',
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
                                String repayDesc;
                                int type = billItem['repay_type'];
                                switch (type) {
                                  case 1:
                                    repayDesc = billItem['repaydesc'];
                                    break;
                                  case 2:
                                    repayDesc =
                                        '${billItem['repaydesc']}${billItem['repaycount']}笔';
                                    break;
                                  case 3:
                                    repayDesc =
                                        '${billItem['repaydesc']}${billItem['repaycount']}笔';
                                    break;
                                  default:
                                    repayDesc = billItem['repaydesc'];
                                    break;
                                }
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
                                            style:
                                                TextStyles.text15MediumPPLabel,
                                          ),
                                          Text(
                                            '$repayDesc',
                                            style: (type == 1 || type == 3)
                                                ? TextStyles
                                                    .text15RedMediumLabel
                                                : type == 2
                                                    ? TextStyles
                                                        .text15BlueMediumLabel
                                                    : TextStyles
                                                        .text15MediumLabel,
                                          ),
                                          Text(
                                            '还款${billItem['repmoney']}.00元',
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
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(
              //     top: 10,
              //   ),
              //   color: Colours.white_color,
              //   child: Column(
              //     children: <Widget>[
              //       Container(
              //         height: 44,
              //         child: Row(
              //           children: <Widget>[
              //             SizedBox(
              //               width: 16,
              //             ),
              //             Image.asset('assets/images/user/dqyhte_icon.png',
              //                 width: 22, height: 15),
              //             SizedBox(
              //               width: 12,
              //             ),
              //             Text(
              //               '分期数据',
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeights.medium,
              //                 color: Colours.blue_color,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Container(
              //         height: 0.5,
              //         color: Colours.background_color2,
              //       ),
              //       Container(
              //         height: 38,
              //         padding: EdgeInsets.only(
              //           left: 16,
              //           right: 16,
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: <Widget>[
              //             Text(
              //               '账单分期明细',
              //               style: TextStyles.text15MediumLabel,
              //             ),
              //             Text(
              //               '${bill.length}笔',
              //               style: TextStyles.text15RedMediumLabel,
              //             ),
              //           ],
              //         ),
              //       ),
              //       Container(
              //         height: 0.5,
              //         color: Colours.background_color2,
              //       ),
              //       Container(
              //         height: 566,
              //         // padding: EdgeInsets.only(
              //         //   left: 15,
              //         //   right: 15,
              //         // ),
              //         child: ListView.builder(
              //           itemCount: bill.length,
              //           physics: NeverScrollableScrollPhysics(),
              //           itemBuilder: (BuildContext context, int index) {
              //             Map billItem = bill[index];
              //             return Container(
              //               child: Column(
              //                 children: <Widget>[
              //                   ExpansionTile(
              //                     leading: Text(
              //                       '${billItem['year']}年${billItem['month']}月',
              //                       textAlign: TextAlign.right,
              //                       style: TextStyles.text15MediumPPLabel,
              //                     ),
              //                     title: Row(
              //                       mainAxisAlignment: MainAxisAlignment.end,
              //                       children: <Widget>[
              //                         Text('分期金额4434元',
              //                             style:
              //                                 TextStyles.text15RedMediumLabel),
              //                       ],
              //                     ),
              //                     backgroundColor: Color(0x300DAEFF),
              //                     initiallyExpanded: false, //默认是否展开
              //                     children: <Widget>[
              //                       Container(
              //                         height: 108,
              //                         child: Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceAround,
              //                           children: <Widget>[
              //                             Container(
              //                               child: Column(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.spaceEvenly,
              //                                 children: <Widget>[
              //                                   Text(
              //                                     '4434.00元',
              //                                     style: TextStyle(
              //                                       fontSize: 16,
              //                                       color: Colours.orange_color,
              //                                       fontWeight:
              //                                           FontWeights.medium,
              //                                     ),
              //                                   ),
              //                                   Text(
              //                                     '本期应还',
              //                                     style: TextStyles
              //                                         .text12MediumLabel,
              //                                   ),
              //                                   Text(
              //                                     '本期到期还款日',
              //                                     style: TextStyles
              //                                         .text12MediumLabel,
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                             Container(
              //                               child: Column(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.spaceEvenly,
              //                                 children: <Widget>[
              //                                   Text(
              //                                     '正常',
              //                                     style: TextStyles
              //                                         .text12MediumLabel,
              //                                   ),
              //                                   Text(
              //                                     '766.70元',
              //                                     style: TextStyles
              //                                         .text12Red15MediumLabel,
              //                                   ),
              //                                   Text(
              //                                     '2018-12-17',
              //                                     style: TextStyles
              //                                         .text12MediumLabel,
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                             Container(
              //                               width: 1,
              //                               height: 43,
              //                               margin: EdgeInsets.only(
              //                                 top: 32,
              //                               ),
              //                               color: Color(0xFFCCCCCC),
              //                             ),
              //                             Container(
              //                               child: Column(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.spaceEvenly,
              //                                 children: <Widget>[
              //                                   Text(
              //                                     '2/6期',
              //                                     style: TextStyle(
              //                                       fontSize: 16,
              //                                       color: Colours.orange_color,
              //                                       fontWeight:
              //                                           FontWeights.medium,
              //                                     ),
              //                                   ),
              //                                   Container(
              //                                     width: 71,
              //                                     height: 22,
              //                                     decoration: BoxDecoration(
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               11),
              //                                       color: Colours.red_color,
              //                                     ),
              //                                     alignment: Alignment.center,
              //                                     child: Text('未还款',
              //                                         style: TextStyles
              //                                             .text10WihteMediumLabel),
              //                                   ),
              //                                   Text(
              //                                     '2018-12-16',
              //                                     style: TextStyle(
              //                                       fontSize: 12,
              //                                       color: Color(0xFFCCCCCC),
              //                                       fontWeight:
              //                                           FontWeights.medium,
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       Container(
              //                         height: 0.5,
              //                         color: Colours.background_color2,
              //                       ),
              //                       Container(
              //                         height: 108,
              //                         child: Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceAround,
              //                           children: <Widget>[
              //                             Container(
              //                               child: Column(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.spaceEvenly,
              //                                 children: <Widget>[
              //                                   Text(
              //                                     '4434.00元',
              //                                     style: TextStyle(
              //                                       fontSize: 16,
              //                                       color: Colours.orange_color,
              //                                       fontWeight:
              //                                           FontWeights.medium,
              //                                     ),
              //                                   ),
              //                                   Text(
              //                                     '本期应还',
              //                                     style: TextStyles
              //                                         .text12MediumLabel,
              //                                   ),
              //                                   Text(
              //                                     '本期到期还款日',
              //                                     style: TextStyles
              //                                         .text12MediumLabel,
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                             Container(
              //                               child: Column(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.spaceEvenly,
              //                                 children: <Widget>[
              //                                   Text(
              //                                     '正常',
              //                                     style: TextStyles
              //                                         .text12MediumLabel,
              //                                   ),
              //                                   Text(
              //                                     '766.70元',
              //                                     style: TextStyles
              //                                         .text12Red15MediumLabel,
              //                                   ),
              //                                   Text(
              //                                     '2018-12-17',
              //                                     style: TextStyles
              //                                         .text12MediumLabel,
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                             Container(
              //                               width: 1,
              //                               height: 43,
              //                               margin: EdgeInsets.only(
              //                                 top: 32,
              //                               ),
              //                               color: Color(0xFFCCCCCC),
              //                             ),
              //                             Container(
              //                               child: Column(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.spaceEvenly,
              //                                 children: <Widget>[
              //                                   Text(
              //                                     '2/6期',
              //                                     style: TextStyle(
              //                                       fontSize: 16,
              //                                       color: Colours.orange_color,
              //                                       fontWeight:
              //                                           FontWeights.medium,
              //                                     ),
              //                                   ),
              //                                   Container(
              //                                     width: 71,
              //                                     height: 22,
              //                                     decoration: BoxDecoration(
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               11),
              //                                       color: Colours.red_color,
              //                                     ),
              //                                     alignment: Alignment.center,
              //                                     child: Text('未还款',
              //                                         style: TextStyles
              //                                             .text10WihteMediumLabel),
              //                                   ),
              //                                   Text(
              //                                     '2018-12-16',
              //                                     style: TextStyle(
              //                                       fontSize: 12,
              //                                       color: Color(0xFFCCCCCC),
              //                                       fontWeight:
              //                                           FontWeights.medium,
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       Container(
              //                         height: 0.5,
              //                         color: Colours.background_color2,
              //                       ),
              //                     ],
              //                   ),
              //                   Container(
              //                     height: 0.5,
              //                     color: Colours.background_color2,
              //                   ),
              //                 ],
              //               ),
              //             );
              //           },
              //         ),
              //       ),
              //       Container(
              //         height: 0.5,
              //         color: Colours.background_color2,
              //       ),
              //       Container(
              //         height: 54,
              //         child: Row(
              //           children: <Widget>[
              //             SizedBox(
              //               width: 16,
              //             ),
              //             Text(
              //               '管理师建议：',
              //               style: TextStyles.text12MediumPPLabel,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
                            '额度保留率',
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
                            '${quota['quotaRate']['retain'].toStringAsFixed(1)}%',
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
                            '近${bill.length}个月保留率',
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
                            '每月保留明细',
                            style: TextStyles.text15MediumLabel,
                          ),
                          Text(
                            '保留率',
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
                      height: 56.5 * bill.length,
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
                                    '${billItem['retain']}%',
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
                height: 100,
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
}
