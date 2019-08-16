import '../../../common/component_index.dart';

class QuestionOrderAlert extends StatelessWidget {
  const QuestionOrderAlert(this.questionType);
  final int questionType;
  @override
  Widget build(BuildContext context) {
    if (questionType == 1)
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 343,
              height: 238,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 343,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        color: Colours.blue_color,
                      ),
                      child: FlatButton(
                        child: Text(
                          '问题订单',
                          style: TextStyles.text16WhiteMediumLabel,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 343,
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
                              SizedBox(
                                width: 25,
                              ),
                              Container(
                                width: 25,
                                height: 15,
                                margin: EdgeInsets.only(
                                  bottom: 4,
                                ),
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  child: null,
                                  onPressed: null,
                                ),
                              ),
                              SizedBox(
                                width: 9,
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
                                  '王坤明',
                                  style: TextStyles.text14MediumPLabel,
                                ),
                              ),
                              Container(
                                width: 106,
                                child: Text(
                                  '25000.00',
                                  style: TextStyles.text14MediumPLabel,
                                ),
                              ),
                              SizedBox(
                                width: 9,
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
                                  '2019-03-22  09：30-22：00',
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
                    ),
                    Container(
                      width: 343,
                      height: 110,
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
                                '建议行业：【宠物店】 【健身俱乐部】 【航空票务】',
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
                                // width: 150,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 11,
                                    ),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset(
                                          'assets/images/user/jtyh_icon.png'),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      '交行',
                                      style: TextStyles.text16MediumLabel,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '3948',
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
                                      '100000.00',
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
                                      '待确认',
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
                                      '消费金额：',
                                      style: TextStyles.text14MediumLabel,
                                    ),
                                    Text(
                                      '-',
                                      style: TextStyles.text14MediumLabel,
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 60,
              height: 60,
              child: FlatButton(
                child: Image.asset('assets/images/user/carddiagnose_close.png',width: 20,height: 20),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    else
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 343,
              height: 253,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 343,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        color: Colours.blue_color,
                      ),
                      child: FlatButton(
                        child: Text(
                          '问题订单',
                          style: TextStyles.text16WhiteMediumLabel,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 343,
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
                              SizedBox(
                                width: 25,
                              ),
                              Container(
                                width: 25,
                                height: 15,
                                margin: EdgeInsets.only(
                                  bottom: 4,
                                ),
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  child: null,
                                  onPressed: null,
                                ),
                              ),
                              SizedBox(
                                width: 9,
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
                                  '王坤明',
                                  style: TextStyles.text14MediumPLabel,
                                ),
                              ),
                              Container(
                                width: 106,
                                child: Text(
                                  '25000.00',
                                  style: TextStyles.text14MediumPLabel,
                                ),
                              ),
                              SizedBox(
                                width: 9,
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
                                  '2019-03-22  09：30-22：00',
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
                    ),
                    Container(
                      width: 343,
                      height: 125,
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
                                      child: Image.asset(
                                          'assets/images/user/jtyh_icon.png'),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      '交行',
                                      style: TextStyles.text16MediumLabel,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '3948',
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
                                      '100000.00',
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
                                      '待确认',
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
                                      '实际消费：',
                                      style: TextStyles.text14MediumLabel,
                                    ),
                                    Text(
                                      '-',
                                      style: TextStyles.text14MediumLabel,
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                  ],
                                ),
                              )
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
                            height: 9,
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
                                      '未扣费',
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
                                      '待扣费金额：',
                                      style: TextStyles.text14MediumLabel,
                                    ),
                                    Text(
                                      '460.00',
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
                            height: 0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 60,
              height: 60,
              child: FlatButton(
                child: Image.asset('assets/images/user/carddiagnose_close.png',width: 20,height: 20),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
  }
}
