import '../../../common/component_index.dart';
import '../../pages/page_index.dart';

ExpansionPanelCustom buildCreditDetailItem(
  BuildContext context,
  Map<String, dynamic> dataItem,
  int currentIndex,
  int itemIndex,
) {
  int type = dataItem['planType'];
  int planType = dataItem['status'];
  bool hasQuestion = dataItem['status'] == -1;
  if (type == 1)
    return ExpansionPanelCustom(
      headerBuilder: (context, isExpanded) {
        return Container(
          width: 306,
          height: 84,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '类型：',
                    style: TextStyles.text14MediumLabel,
                  ),
                  Expanded(
                    child: Text(
                      '消费计划',
                      style: TextStyles.text14MediumLabel,
                    ),
                  ),
                  Text(
                    '计划消费',
                    style: TextStyles.text14MediumLabel,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '管理师：',
                    style: TextStyles.text14MediumLabel,
                  ),
                  Expanded(
                    child: Text(
                      '${dataItem['name'] ?? ''}',
                      style: TextStyles.text14MediumPLabel,
                    ),
                  ),
                  Container(
                    width: 100,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${dataItem['maxMoney']}',
                      style: TextStyles.text14MediumPLabel,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      '${dataItem['startTime']} - ${dataItem['endTime']}',
                      style: TextStyles.text12MediumPLabel,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
            ],
          ),
        );
      },
      body: Container(
        width: 343,
        // height: 178,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: 323,
              height: 1,
              color: Colours.divider_color,
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${dataItem['info'] ?? ''}',
                  style: TextStyles.text12MediumLabel,
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              width: 323,
              height: 1,
              color: Colours.divider_color,
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 150,
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
                            placeholder: "assets/images/user/card_default.jpeg",
                            image: dataItem['icon'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        '${dataItem['bankName']}',
                        style: TextStyles.text16MediumLabel,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${dataItem['cardNo']}',
                        style: TextStyles.text14MediumLabel,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  child: Row(
                    children: <Widget>[
                      Text(
                        '代管金额',
                        style: TextStyles.text14MediumLabel,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${dataItem['usableMoney']}',
                        style: TextStyles.text14MediumPLabel,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 150,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        '计划状态：',
                        style: TextStyles.text14MediumLabel,
                      ),
                      Text(
                        planType == 1 ? '待确认' : planType == 4 ? '已消费成功' : '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeights.medium,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  child: Row(
                    children: <Widget>[
                      Text(
                        '实际消费：',
                        style: TextStyles.text14MediumLabel,
                      ),
                      Text(
                        planType == 1
                            ? '-'
                            : planType == 4 ? '${dataItem['realMoney']}' : '',
                        style: TextStyles.text14MediumLabel,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '更新日期：${dataItem['updateTime']}',
                  style: TextStyles.text12MediumPLabel,
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              width: 323,
              height: 1,
              color: Colours.divider_color,
            ),
            SizedBox(
              height: 0,
            ),
            !hasQuestion
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 60,
                              height: 22,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colours.red_color,
                                  width: 1,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '问题订单',
                                style: TextStyles.text12RedMediumLabel,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              height: 32,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${dataItem['msg']}',
                                style: TextStyles.text12MediumPLabel,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   width: 79,
                      //   child: FlatButton(
                      //     padding: EdgeInsets.all(0),
                      //     child: Text(
                      //       '查看原计划',
                      //       style: TextStyles.text12OrangeMediumLabel,
                      //     ),
                      //     onPressed: () {
                      //       showDialog<void>(
                      //         context: context,
                      //         barrierDismissible: true,
                      //         builder: (BuildContext context) {
                      //           return QuestionOrderAlert(1);
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
          ],
        ),
      ),
      isExpanded: currentIndex == itemIndex,
    );
  else
    return ExpansionPanelCustom(
      headerBuilder: (context, isExpanded) {
        return Container(
          width: 306,
          height: 84,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '类型：',
                    style: TextStyles.text14MediumLabel,
                  ),
                  Expanded(
                    child: Text(
                      '还款计划',
                      style: TextStyles.text14MediumLabel,
                    ),
                  ),
                  Text(
                    '计划还款',
                    style: TextStyles.text14MediumLabel,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '管理师：',
                    style: TextStyles.text14MediumLabel,
                  ),
                  Expanded(
                    child: Text(
                      '${dataItem['name'] ?? ''}',
                      style: TextStyles.text14MediumPLabel,
                    ),
                  ),
                  Container(
                    width: 100,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${dataItem['maxMoney']}',
                      style: TextStyles.text14MediumPLabel,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      '${dataItem['startTime']} - ${dataItem['endTime']}',
                      style: TextStyles.text12MediumPLabel,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
            ],
          ),
        );
      },
      body: Container(
        width: 343,
        // height: 171,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: 323,
              height: 1,
              color: Colours.divider_color,
            ),
            SizedBox(
              height: 7,
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
                            placeholder: "assets/images/user/card_default.jpeg",
                            image: dataItem['icon'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        '${dataItem['bankName']}',
                        style: TextStyles.text16MediumLabel,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${dataItem['cardNo']}',
                        style: TextStyles.text14MediumLabel,
                      ),
                    ],
                  ),
                ),
                Container(
                  // width: 193,
                  child: Row(
                    children: <Widget>[
                      Text(
                        '代管金额',
                        style: TextStyles.text14MediumLabel,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${dataItem['usableMoney']}',
                        style: TextStyles.text14MediumPLabel,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
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
                        '还款日：',
                        style: TextStyles.text14MediumLabel,
                      ),
                      Text(
                        '${dataItem['accPayday']}',
                        style: TextStyles.text14MediumLabel,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 146,
                  child: Row(
                    children: <Widget>[
                      Text(
                        '应还金额：',
                        style: TextStyles.text14MediumLabel,
                      ),
                      Text(
                        '${dataItem['maxMoney']}',
                        style: TextStyles.text14MediumLabel,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
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
                        '计划状态：',
                        style: TextStyles.text14MediumLabel,
                      ),
                      Text(
                        planType == 1
                            ? '待确认'
                            : planType == 2
                                ? '已确认'
                                : planType == 4 ? '已还款成功' : '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeights.medium,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 146,
                  child: Row(
                    children: <Widget>[
                      Text(
                        '实际还款：',
                        style: TextStyles.text14MediumLabel,
                      ),
                      Text(
                        planType != 4 ? '-' : '${dataItem['realMoney']}',
                        style: TextStyles.text14MediumLabel,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '更新日期：${dataItem['updateTime']}',
                  style: TextStyles.text12MediumPLabel,
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              width: 323,
              height: 1,
              color: Colours.divider_color,
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 7,
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
                            '扣费情况：',
                            style: TextStyles.text14MediumLabel,
                          ),
                          Text(
                            planType == 1 ? '未扣费' : '已扣费',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeights.medium,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 146,
                      child: Row(
                        children: <Widget>[
                          Text(
                            planType == 1 ? '待扣费金额：' : '已扣费金额：',
                            style: TextStyles.text14MediumLabel,
                          ),
                          Text(
                            '${dataItem['payment']}',
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
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      planType == 1
                          ? '扣款日期：-'
                          : '扣款日期：${dataItem['paymentTime']}',
                      style: TextStyles.text12MediumPLabel,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  width: 323,
                  height: 1,
                  color: Colours.divider_color,
                ),
              ],
            ),
            !hasQuestion
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 60,
                              height: 22,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colours.red_color,
                                  width: 1,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '问题订单',
                                style: TextStyles.text12RedMediumLabel,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              height: 32,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${dataItem['msg']}',
                                style: TextStyles.text12MediumPLabel,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   width: 79,
                      //   child: FlatButton(
                      //     padding: EdgeInsets.all(0),
                      //     child: Text(
                      //       '查看原计划',
                      //       style: TextStyles.text12OrangeMediumLabel,
                      //     ),
                      //     onPressed: () {
                      //       showDialog<void>(
                      //         context: context,
                      //         barrierDismissible: true,
                      //         builder: (BuildContext context) {
                      //           return QuestionOrderAlert(2);
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
          ],
        ),
      ),
      isExpanded: currentIndex == itemIndex,
    );
}
