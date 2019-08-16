import '../../../common/component_index.dart';
// import '../../../../ui/pages/page_index.dart';

class CreditDetailHead extends StatelessWidget {
  CreditDetailHead(this.showType, this.cardItemModel);
  final int showType;
  final CardItemModel cardItemModel;
  Widget build(BuildContext context) {
    int delegateType = cardItemModel.delegateType;
    String icon = cardItemModel.icon ?? "";
    var bankName = cardItemModel.bankName ?? "";
    String cardIdStr =
        cardItemModel.cardId != null ? cardItemModel.cardId.toString() : '0000';
    String cardId = cardIdStr.length >= 4
        ? cardIdStr.substring(cardIdStr.length - 4)
        : cardIdStr;
    double accLimit = cardItemModel.accLimit.toDouble() ?? 0.00;
    String nearAccPayday = cardItemModel.nearAccPayday ?? "";
    String nearAccDay = cardItemModel.nearAccDay ?? "";
    int nearAccDays = cardItemModel.nearAccDays.toInt() ?? 0;
    int nearAccPaydays = cardItemModel.nearAccPaydays.toInt() ?? 0;
    double accLimitCost = cardItemModel.accLimitCost.toDouble() ?? 0.00;
    String payStatus;
    switch (cardItemModel.payStatus.toInt()) {
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
    double usableMoney = cardItemModel.usableMoney.toDouble() ?? 0.00;
    return Container(
      color: Color(0xFFF2F2F2),
      padding: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          showType == 2
              ? Container(
                  margin: EdgeInsets.only(
                    left: 16 * Screen.screenRate,
                    right: 16 * Screen.screenRate,
                    top: 10 * Screen.screenRate,
                  ),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        '管理师：${cardItemModel.masterName}',
                        style: TextStyles.text15MediumLabel,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        delegateType == 1
                            ? '托管类型：单次代还'
                            : delegateType == 2 ? '托管类型：精养代操' : '托管类型：提额代操',
                        style: TextStyles.text15MediumLabel,
                      ),
                    ],
                  ),
                )
              : Container(),
          Container(
            margin: EdgeInsets.only(
              left: 16 * Screen.screenRate,
              right: 16 * Screen.screenRate,
              top: 10 * Screen.screenRate,
            ),
            height: 177,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xFF2B176F),
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
                            style: TextStyles.text16WhiteMediumLabel,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$cardId',
                            style: TextStyles.text14WhiteMediumLabel,
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
                            style: TextStyles.text14WhiteMediumLabel,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '$accLimit',
                            style: TextStyles.text14WhiteMediumLabel,
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
                            style: TextStyles.text14WhiteMediumLabel,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '$nearAccDay',
                            style: TextStyles.text13WhiteMediumLabel,
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
                            style: TextStyles.text14WhiteMediumLabel,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '$nearAccPayday',
                            style: TextStyles.text13WhiteMediumLabel,
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
                            style: TextStyles.text13WhiteMediumLabel,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            '$nearAccPaydays天后',
                            style: TextStyles.text13WhiteMediumLabel,
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
                            style: TextStyles.text14WhiteMediumLabel,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '$accLimitCost',
                            style: TextStyles.text13WhiteMediumLabel,
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
                            style: TextStyles.text13WhiteMediumLabel,
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
                            style: TextStyles.text14WhiteMediumLabel,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '$usableMoney',
                            style: TextStyles.text13WhiteMediumLabel,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
