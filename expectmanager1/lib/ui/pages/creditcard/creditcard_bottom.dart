import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

EventBus eventBus2 = new EventBus();

class UpdateProgressEvent {
  bool isUpdate;
  UpdateProgressEvent(this.isUpdate);
}

class CreditCardBottom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CreditCardBottomState();
  }
}

class CreditCardBottomState extends State<CreditCardBottom>
    with AutomaticKeepAliveClientMixin {
  CardInfoModel cardInfoModel = CardInfoModel(10);
  var delMap = Map();
  bool updateBill = false;
  List<double> progressList1 = List<double>();
  List<double> progressList2 = List<double>();
  @override
  void initState() {
    eventBus2.on<UpdateProgressEvent>().listen(
      (event) {
        if (mounted) {
          updateBill = event.isUpdate;
          setState(() {});
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final CreditCardBloc creditCardBloc =
        BlocProvider.of<CreditCardBloc>(context);
    creditCardBloc.bloccontext = context;
    return StreamBuilder(
      stream: creditCardBloc.cardInfoStream,
      builder: (BuildContext context, AsyncSnapshot<CardInfoModel> snapshot) {
        if (cardInfoModel == null) return Container();
        cardInfoModel.cardList = snapshot.data.cardList;
        List<CardItemModel> _cardList =
            cardInfoModel.cardList.cast<CardItemModel>();
        List<CardItemModel> needList =
            _cardList.where((model) => model.isDelegated == 0).toList();
        List<CardItemModel> needList2 =
            _cardList.where((model) => model.isDelegated == 1).toList();
        if (delMap.length < needList.length)
          for (int i = 0; i < needList.length; i++) {
            delMap[i] = false;
          }

        if (!updateBill) {
          creditCardBloc.progressAry = List<List<double>>();
          progressList1 = List<double>();
          progressList2 = List<double>();
          for (int i = 0; i < needList.length; i++) {
            progressList1.add(0.0);
          }
          creditCardBloc.progressAry.add(progressList1);
          for (int i = 0; i < needList2.length; i++) {
            progressList2.add(0.0);
          }
          creditCardBloc.progressAry.add(progressList2);
        }

        return ListView.builder(
          padding: EdgeInsets.only(top: 20 * Screen.screenRate),
          physics: NeverScrollableScrollPhysics(),
          itemCount: needList.length,
          itemBuilder: (BuildContext context, int index) {
            String bankName = needList[index].bankName.toString() ?? "";
            int credit = needList[index].credit.toInt() ?? 00000;
            double accLimit = needList[index].accLimit.toDouble() ?? 0.00;
            int accDay = needList[index].accDay.toInt() ?? 0;
            int accPayday = needList[index].accPayday.toInt() ?? 0;
            double accLimitCost =
                needList[index].accLimitCost.toDouble() ?? 0.00;
            String payStatus;
            switch (needList[index].payStatus.toInt()) {
              case 0:
                payStatus = '未出账';
                break;
              case 1:
                payStatus = '已出账';
                break;
              case 2:
                payStatus = '还款部分';
                break;
              case 3:
                payStatus = '已还款';
                break;
              case 4:
                payStatus = '已逾期';
                break;
              default:
                payStatus = '无数据';
                break;
            }
            double usableMoney = needList[index].usableMoney.toDouble() ?? 0.00;
            String icon = needList[index].icon ?? "";
            String nearAccPayday = needList[index].nearAccPayday ?? "";
            String nearAccDay = needList[index].nearAccDay ?? "";
            int nearAccDays = needList[index].nearAccDays.toInt() ?? 0;
            int nearAccPaydays = needList[index].nearAccPaydays.toInt() ?? 0;
            num cardInstanceId = needList[index].id ?? 0;
            num bankCode = needList[index].bankCode ?? 0;
            String cardId = needList[index].cardId.toString();
            double updateProgress = creditCardBloc.progressAry[0][index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        CreditDetailPage(1, needList[index]),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: 343,
                    height: 177,
                    margin: EdgeInsets.only(
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // width: 150,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            "assets/images/user/card_default.jpeg",
                                        image: icon,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    '$bankName',
                                    style: TextStyles.text16MediumLabel,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${cardId.length >= 4 ? cardId.substring(cardId.length - 4) : cardId}',
                                    style: TextStyles.text13MediumPLabel,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // width: 193,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '信用额度',
                                    style: TextStyles.text14MediumLabel,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '$accLimit',
                                    style: TextStyles.text14MediumLabel,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // width: 150,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Text(
                                    '近期账单日:',
                                    style: TextStyles.text14MediumLabel,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '$nearAccDay',
                                    style: TextStyles.text13MediumPLabel,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // width: 193,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '最后还款日:',
                                    style: TextStyles.text14MediumLabel,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '$nearAccPayday',
                                    style: TextStyles.text13MediumPLabel,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 88,
                                  ),
                                  Text(
                                    '$nearAccDays天后',
                                    style: TextStyles.text13MediumPLabel,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '$nearAccPaydays天后',
                                    style: TextStyles.text13MediumPLabel,
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // width: 150,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Text(
                                    '已出账单',
                                    style: TextStyles.text14MediumLabel,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '$accLimitCost',
                                    style: TextStyles.text13MediumPLabel,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // width: 193,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '还款状态:',
                                    style: TextStyles.text14MediumLabel,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '$payStatus',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 323,
                          height: 1,
                          color: Colours.line_color,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // width: 150,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Text(
                                    '可用额度',
                                    style: TextStyles.text14MediumLabel,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '$usableMoney',
                                    style: TextStyles.text13MediumPLabel,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // width: 193,
                              child: Row(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        width: 80,
                                        height: 24,
                                        child: FlatButton(
                                          shape: const RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Color(0xFFF39818),
                                                  style: BorderStyle.solid,
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12))),
                                          child: Text(
                                            '更新账单',
                                            style: TextStyle(
                                              color: Color(0xFFF39818),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          onPressed: updateProgress == 0.0
                                              ? () {
                                                  creditCardBloc
                                                      .updateBillAction(
                                                          cardInstanceId,
                                                          bankCode,
                                                          0,
                                                          index,
                                                          0);
                                                }
                                              : null,
                                        ),
                                      ),
                                      AnimatedOpacity(
                                        opacity: 0.5,
                                        child: Container(
                                          width: 80 * updateProgress,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12))),
                                        ),
                                        duration: Duration(seconds: 1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width: 80,
                                    height: 24,
                                    child: FlatButton(
                                      shape: const RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colours.text_placehold,
                                              style: BorderStyle.solid,
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: Text(
                                        '查看账单',
                                        style: TextStyle(
                                          color: Colours.text_placehold,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                CreditDetailPage(
                                                    1, needList[index]),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 20 * Screen.screenRate,
                    width: 25 * Screen.screenRate,
                    height: 20,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        width: 25 * Screen.screenRate,
                        height: 20,
                        child: Icon(
                          Icons.more_horiz,
                          color: Colours.text_placehold2,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          delMap[index] = !delMap[index];
                          Alert(
                            context: context,
                            type: AlertType.warning,
                            title: "是否删除卡片",
                            buttons: [
                              DialogButton(
                                color: Colours.red_color,
                                child: Text(
                                  "确定",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  creditCardBloc.removeCard(needList[index].id);
                                  setState(() {
                                    delMap[index] = !delMap[index];
                                  });
                                },
                                width: 120,
                              ),
                              DialogButton(
                                child: Text(
                                  "取消",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    delMap[index] = !delMap[index];
                                  });
                                },
                                width: 120,
                              ),
                            ],
                          ).show();
                        });
                      },
                    ),
                  ),
                  //删除按钮
                  // delMap[index]
                  //     ? Positioned(
                  //         top: 20,
                  //         right: -16,
                  //         width: 160,
                  //         height: 62,
                  //         child: AnimatedOpacity(
                  //           child: MaterialButton(
                  //               height: 30,
                  //               minWidth: 30,
                  //               padding: EdgeInsets.all(0),
                  //               child: Container(
                  //                 width: 80,
                  //                 height: 31,
                  //                 decoration: BoxDecoration(
                  //                   image: DecorationImage(
                  //                     image: AssetImage(
                  //                         'assets/images/user/more_delete.png'),
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //                 ),
                  //                 padding: EdgeInsets.only(
                  //                   top: 8,
                  //                   left: 25,
                  //                 ),
                  //                 child: Text(
                  //                   '删除',
                  //                   style: TextStyle(
                  //                     fontSize: 15,
                  //                     color: Colors.white,
                  //                     fontWeight: FontWeights.medium,
                  //                   ),
                  //                 ),
                  //               ),
                  //               onPressed: () {
                  //                 Alert(
                  //                   context: context,
                  //                   type: AlertType.warning,
                  //                   title: "确定要删除吗",
                  //                   buttons: [
                  //                     DialogButton(
                  //                       color: Colours.red_color,
                  //                       child: Text(
                  //                         "确���",
                  //                         style: TextStyle(
                  //                             color: Colors.white, fontSize: 16),
                  //                       ),
                  //                       onPressed: () {
                  //                         Navigator.of(context).pop();
                  //                         creditCardBloc
                  //                             .removeCard(needList[index].id);
                  //                         setState(() {
                  //                           delMap[index] = !delMap[index];
                  //                         });
                  //                       },
                  //                       width: 120,
                  //                     ),
                  //                     DialogButton(
                  //                       child: Text(
                  //                         "取消",
                  //                         style: TextStyle(
                  //                             color: Colors.white, fontSize: 16),
                  //                       ),
                  //                       onPressed: () {
                  //                         Navigator.of(context).pop();
                  //                         setState(() {
                  //                           delMap[index] = !delMap[index];
                  //                         });
                  //                       },
                  //                       width: 120,
                  //                     ),
                  //                   ],
                  //                 ).show();
                  //               }),
                  //           duration: Duration(
                  //             milliseconds: 300,
                  //           ),
                  //           opacity: delMap[index] ? 1.0 : 0.0,
                  //         ),
                  //       )
                  //     : Container(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
