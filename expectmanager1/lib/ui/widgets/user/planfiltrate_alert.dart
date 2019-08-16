import '../../../common/component_index.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class PlanFiltrateAlert extends StatefulWidget {
  const PlanFiltrateAlert(
    this.showType,
  );

  final int showType;

  @override
  State<StatefulWidget> createState() => PlanFiltrateAlertState();
}

class PlanFiltrateAlertState extends State<PlanFiltrateAlert> {
  String selectDateRangeStr = '请选择日期范围';
  int filterType = 0;
  bool onlyQuestionOrder = false;
  DateTime startTime;
  DateTime endTime;
  @override
  Widget build(BuildContext context) {
    List<DateTime> picked = List<DateTime>();
    if (widget.showType == 1) {
      startTime = (DateTime.now()).subtract(Duration(days: 6));
      endTime = DateTime.now();
      picked.add(startTime);
      picked.add(endTime);
      StringBuffer strBuf = StringBuffer();
      for (int i = 0; i < 2; i++) {
        DateTime date = picked[i];
        strBuf.write("${date.year}-${date.month}-${date.day} ");
        if (i == 0) strBuf.write("至 ");
      }
      selectDateRangeStr = strBuf.toString();
    }
    return Container(
      width: 250,
      height: 144,
      margin: EdgeInsets.only(
        top: 193,
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 300,
            height: 278,
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colours.white_color,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.showType == 2 ? '请选择日期' : '日期范围',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colours.blue_color,
                    fontWeight: FontWeights.medium,
                    decoration: TextDecoration.none,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 280,
                      height: 30,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          selectDateRangeStr,
                          style: TextStyles.text14MediumLabel,
                        ),
                        onPressed: widget.showType == 2
                            ? () async {
                                final List<DateTime> picked =
                                    await DateRagePicker.showDatePicker(
                                  context: context,
                                  initialFirstDate: (DateTime.now())
                                      .subtract(Duration(days: 6)),
                                  initialLastDate: DateTime.now(),
                                  firstDate: DateTime(2015),
                                  lastDate: DateTime(2020),
                                  // selectableDayPredicate: (DateTime selTime) {
                                  //   var selTimeStr =
                                  //       DateUtil.getDateStrByDateTime(selTime,
                                  //           format: DateFormat.YEAR_MONTH_DAY);
                                  //   return true;
                                  // },
                                );
                                if (picked != null && picked.length == 2) {
                                  print(picked);
                                  selectDateRangeStr = picked.toString();
                                  StringBuffer strBuf = StringBuffer();
                                  for (int i = 0; i < 2; i++) {
                                    DateTime date = picked[i];
                                    strBuf.write(
                                        "${date.year}-${date.month}-${date.day} ");
                                    if (i == 0) strBuf.write("至 ");
                                  }
                                  selectDateRangeStr = strBuf.toString();
                                  startTime = picked[0];
                                  endTime = picked[1];
                                  setState(() {});
                                }
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 0.5,
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  color: Colours.background_color2,
                ),
                Text(
                  '类型',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colours.blue_color,
                    fontWeight: FontWeights.medium,
                    decoration: TextDecoration.none,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: filterType == 0
                              ? Colours.blue_color
                              : Colours.text_placehold2,
                          width: 1.0,
                        ),
                      ),
                      child: FlatButton(
                        child: Text(
                          '全部计划',
                          style: filterType == 0
                              ? TextStyles.text14BlueMediumLabel
                              : TextStyles.text14MediumLabel,
                        ),
                        onPressed: () {
                          filterType = 0;
                          setState(() {});
                        },
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: filterType == 1
                              ? Colours.blue_color
                              : Colours.text_placehold2,
                          width: 1.0,
                        ),
                      ),
                      child: FlatButton(
                        child: Text(
                          '消费计划',
                          style: filterType == 1
                              ? TextStyles.text14BlueMediumLabel
                              : TextStyles.text14MediumLabel,
                        ),
                        onPressed: () {
                          filterType = 1;
                          setState(() {});
                        },
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: filterType == 2
                              ? Colours.blue_color
                              : Colours.text_placehold2,
                          width: 1.0,
                        ),
                      ),
                      child: FlatButton(
                        child: Text(
                          '还款计划',
                          style: filterType == 2
                              ? TextStyles.text14BlueMediumLabel
                              : TextStyles.text14MediumLabel,
                        ),
                        onPressed: () {
                          filterType = 2;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 0.5,
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  margin: EdgeInsets.only(
                    top: 5,
                  ),
                  color: Colours.background_color2,
                ),
                widget.showType == 2
                    ? Container(
                        width: 110,
                        height: 30,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width: 11,
                                height: 11,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colours.background_color2,
                                  ),
                                ),
                                child: onlyQuestionOrder
                                    ? Image.asset(
                                        'assets/images/user/tickoff_icon.png',
                                        width: 9,
                                        height: 6)
                                    : null,
                              ),
                              Text(
                                '只查看问题订单',
                                style: TextStyle(
                                  fontWeight: FontWeights.medium,
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            onlyQuestionOrder = !onlyQuestionOrder;
                            setState(() {});
                          },
                        ))
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 135,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colours.blue_color,
                      ),
                      child: FlatButton(
                        child: Text(
                          '重置',
                          style: TextStyles.text16WhiteMediumLabel,
                        ),
                        onPressed: () {
                          selectDateRangeStr = "请选择日期范围";
                          filterType = 0;
                          onlyQuestionOrder = false;
                          startTime = null;
                          endTime = null;
                          setState(() {});
                        },
                      ),
                    ),
                    Container(
                      width: 135,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colours.blue_color,
                      ),
                      child: FlatButton(
                        child: Text(
                          '确定',
                          style: TextStyles.text16WhiteMediumLabel,
                        ),
                        onPressed: () {
                          if ((startTime == null || endTime == null) &&
                              widget.showType == 2) {
                            Toast.show('请选择日期范围', context);
                            return;
                          }
                          Map<String, dynamic> respMap = Map<String, dynamic>();
                          respMap['startTime'] = startTime;
                          respMap['endTime'] = endTime;
                          respMap['filterType'] = filterType;
                          respMap['onlyQuestionOrder'] = onlyQuestionOrder;
                          Navigator.pop(context, respMap);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
