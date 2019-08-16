import 'package:flutter/gestures.dart';

import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class CreditDiagnoseMiddle extends StatelessWidget {
  Widget build(BuildContext context) {
    final CreditDiagnoseBloc creditDiagnoseBloc =
        BlocProvider.of<CreditDiagnoseBloc>(context);
    return StreamBuilder(
      stream: creditDiagnoseBloc.diagnoseInfoStream,
      builder:
          (BuildContext context, AsyncSnapshot<DiagnoseCardInfo> snapshot) {
        if (!snapshot.hasData) return Container();
        List<DiagnoseCardItem> diagnoseList =
            snapshot.data.cardList.cast<DiagnoseCardItem>().toList();
        return Container(
          margin: EdgeInsets.only(top: 92),
          height: MediaQuery.of(context).size.height - 64 - 92,
          child: ListView.builder(
            padding: EdgeInsets.only(
              top: 10,
            ),
            // itemExtent: 137,
            itemBuilder: (BuildContext context, int index) {
              DiagnoseCardItem diagnoseCardItem = diagnoseList[index];
              return GestureDetector(
                onTap: () {
                  if (diagnoseCardItem.isDiagnose.toInt() == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DiagnoseInfoPage(diagnoseCardItem.id.toInt(), 0),
                      ),
                    );
                  }
                },
                child: Container(
                  color: Colours.background_color,
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      index != 0
                          ? SizedBox(
                              height: 10,
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      Container(
                        width: 359,
                        height: 127,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Color(
                            Utils.getColorFromHex(diagnoseCardItem.color),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 13,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 16,
                                ),
                                Container(
                                  width: 23,
                                  height: 23,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(11.5),
                                    child: FadeInImage.assetNetwork(
                                      placeholder:
                                          "assets/images/user/card_default.jpeg",
                                      image: '${diagnoseCardItem.icon}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  diagnoseCardItem.bankName == null
                                      ? ''
                                      : '${diagnoseCardItem.bankName}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeights.medium,
                                  ),
                                ),
                                SizedBox(
                                  width: 128,
                                ),
                                Text(
                                  diagnoseCardItem.accLimit == null
                                      ? ''
                                      : '当前额度  ${diagnoseCardItem.accLimit}元',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeights.medium,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    diagnoseCardItem.cardId == null
                                        ? ''
                                        : '${diagnoseCardItem.cardId}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeights.medium,
                                    ),
                                  ),
                                ),
                                Offstage(
                                  offstage:
                                      diagnoseCardItem.isDiagnose.toInt() != 1,
                                  child: Container(
                                    width: 65,
                                    height: 23,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11.5),
                                      border: Border.all(
                                        color: Colours.white_color,
                                        width: 1,
                                      ),
                                    ),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0),
                                      child: Text(
                                        '再次诊断',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colours.white_color,
                                          fontWeight: FontWeights.medium,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                OnlineDiagnosePage(
                                                    diagnoseCardItem, 2),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              width: 329,
                              height: 1,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    diagnoseCardItem.isDiagnose.toInt() != 1
                                        ? ''
                                        : '上次诊断时间：${diagnoseCardItem.lastTime}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeights.medium,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 65,
                                  height: 23,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(11.5),
                                    color: Colors.white,
                                  ),
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                      diagnoseCardItem.isDiagnose.toInt() == 1
                                          ? '查看报告'
                                          : '立即诊断',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF0F3586),
                                        fontWeight: FontWeights.medium,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (diagnoseCardItem.isDiagnose.toInt() ==
                                          1) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                DiagnoseInfoPage(
                                                    diagnoseCardItem.id.toInt(),
                                                    0),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                OnlineDiagnosePage(
                                                    diagnoseCardItem, 2),
                                          ),
                                        );
                                        // showDialog(
                                        //   context: context,
                                        //   builder: (BuildContext context) {
                                        //     return Container(
                                        //       width:
                                        //           MediaQuery.of(context).size.width,
                                        //       margin: EdgeInsets.only(
                                        //         top: 151,
                                        //       ),
                                        //       child: Column(
                                        //         crossAxisAlignment:
                                        //             CrossAxisAlignment.center,
                                        //         children: <Widget>[
                                        //           Container(
                                        //             width: 287,
                                        //             height: 264,
                                        //             decoration: BoxDecoration(
                                        //               image: DecorationImage(
                                        //                 image: AssetImage(
                                        //                     'assets/images/user/diagnose_bg.png'),
                                        //                 fit: BoxFit.cover,
                                        //               ),
                                        //             ),
                                        //             child: Stack(
                                        //               children: <Widget>[
                                        //                 Container(
                                        //                   width: 287,
                                        //                   margin: EdgeInsets.only(
                                        //                     top: 72,
                                        //                   ),
                                        //                   child: Text(
                                        //                     '温馨提示',
                                        //                     textAlign:
                                        //                         TextAlign.center,
                                        //                     style: TextStyle(
                                        //                       fontSize: 18,
                                        //                       color: Colors.red,
                                        //                       fontWeight:
                                        //                           FontWeights.medium,
                                        //                       decoration:
                                        //                           TextDecoration.none,
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 Container(
                                        //                   width: 287,
                                        //                   margin: EdgeInsets.only(
                                        //                     top: 105,
                                        //                   ),
                                        //                   child: Text(
                                        //                     '每诊断一次会产生所需费用',
                                        //                     textAlign:
                                        //                         TextAlign.center,
                                        //                     style: TextStyle(
                                        //                       fontSize: 15,
                                        //                       color: Colors.white,
                                        //                       fontWeight:
                                        //                           FontWeights.medium,
                                        //                       decoration:
                                        //                           TextDecoration.none,
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 Container(
                                        //                   width: 287,
                                        //                   margin: EdgeInsets.only(
                                        //                       top: 170),
                                        //                   child: Row(
                                        //                     mainAxisAlignment:
                                        //                         MainAxisAlignment
                                        //                             .spaceEvenly,
                                        //                     children: <Widget>[
                                        //                       Container(
                                        //                         width: 80,
                                        //                         height: 70,
                                        //                         child: FlatButton(
                                        //                           padding:
                                        //                               EdgeInsets.all(
                                        //                                   0),
                                        //                           child: Column(
                                        //                             crossAxisAlignment:
                                        //                                 CrossAxisAlignment
                                        //                                     .center,
                                        //                             children: <
                                        //                                 Widget>[
                                        //                               Image.asset(
                                        //                                   'assets/images/user/wxpay_icon.png'),
                                        //                               SizedBox(
                                        //                                 height: 8,
                                        //                               ),
                                        //                               Text(
                                        //                                 '微信���付',
                                        //                                 style:
                                        //                                     TextStyle(
                                        //                                   fontSize:
                                        //                                       13,
                                        //                                   color: Color(
                                        //                                       0xFF282828),
                                        //                                   fontWeight:
                                        //                                       FontWeights
                                        //                                           .medium,
                                        //                                 ),
                                        //                               ),
                                        //                             ],
                                        //                           ),
                                        //                           onPressed: () {},
                                        //                         ),
                                        //                       ),
                                        //                       Container(
                                        //                         width: 70,
                                        //                         height: 70,
                                        //                         child: FlatButton(
                                        //                           padding:
                                        //                               EdgeInsets.all(
                                        //                                   0),
                                        //                           child: Column(
                                        //                             crossAxisAlignment:
                                        //                                 CrossAxisAlignment
                                        //                                     .center,
                                        //                             children: <
                                        //                                 Widget>[
                                        //                               Image.asset(
                                        //                                   'assets/images/user/zfbpay_icon.png'),
                                        //                               SizedBox(
                                        //                                 height: 8,
                                        //                               ),
                                        //                               Text(
                                        //                                 '支付宝支付',
                                        //                                 style:
                                        //                                     TextStyle(
                                        //                                   fontSize:
                                        //                                       13,
                                        //                                   color: Color(
                                        //                                       0xFF282828),
                                        //                                   fontWeight:
                                        //                                       FontWeights
                                        //                                           .medium,
                                        //                                 ),
                                        //                               ),
                                        //                             ],
                                        //                           ),
                                        //                           onPressed: () {},
                                        //                         ),
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                 ),
                                        //                 Positioned(
                                        //                   right: 10,
                                        //                   top: 38,
                                        //                   child: Container(
                                        //                     width: 30,
                                        //                     height: 30,
                                        //                     child: FlatButton(
                                        //                       padding:
                                        //                           EdgeInsets.all(0),
                                        //                       child: Image.asset(
                                        //                           'assets/images/user/close_icon.png'),
                                        //                       onPressed: () {
                                        //                         Navigator.pop(
                                        //                             context);
                                        //                       },
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //           ),
                                        //           Container(
                                        //             width: 274,
                                        //             height: 40,
                                        //             decoration: BoxDecoration(
                                        //               borderRadius:
                                        //                   BorderRadius.circular(5),
                                        //               color: Color(0xFFFFCC41),
                                        //             ),
                                        //             child: FlatButton(
                                        //               padding: EdgeInsets.all(0),
                                        //               child: Row(
                                        //                 children: <Widget>[
                                        //                   SizedBox(
                                        //                     width: 87,
                                        //                   ),
                                        //                   Text(
                                        //                     '查看诊断结果',
                                        //                     style: TextStyles
                                        //                         .text16WhiteMediumLabel,
                                        //                   ),
                                        //                   Text(
                                        //                     '(案例)',
                                        //                     style: TextStyle(
                                        //                       fontSize: 16,
                                        //                       color: Colors.red,
                                        //                       fontWeight:
                                        //                           FontWeights.medium,
                                        //                       decoration:
                                        //                           TextDecoration.none,
                                        //                     ),
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //               onPressed: () {
                                        //                 Navigator.pop(context);
                                        //                 Navigator.push(
                                        //                   context,
                                        //                   MaterialPageRoute(
                                        //                     builder: (BuildContext
                                        //                             context) =>
                                        //                         DiagnoseInfoPage(),
                                        //                   ),
                                        //                 );
                                        //                 // Navigator.pop(context);
                                        //               },
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     );
                                        //   },
                                        // );
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      index == (diagnoseList.length - 1)
                          ? SizedBox(
                              height: 20,
                            )
                          : SizedBox(
                              height: 0,
                            ),
                    ],
                  ),
                ),
              );
            },
            itemCount: diagnoseList.length,
          ),
        );
      },
    );
  }
}
