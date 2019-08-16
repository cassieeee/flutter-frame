import '../../../common/component_index.dart';

class HistoryDetailHead extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HistoryDetailHeadState();
  }
}

class HistoryDetailHeadState extends State<HistoryDetailHead> {
  String planOrder = "DESC";
  TextEditingController searchWordTC = TextEditingController();
  Widget build(BuildContext context) {
    final HistoryDetailBloc historyDetailBloc =
        BlocProvider.of<HistoryDetailBloc>(context);
    historyDetailBloc.bloccontext = context;
    return Container(
      margin: EdgeInsets.only(
        top: 2,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 36,
          ),
          Expanded(
            child: Container(
              height: 30,
              decoration: new BoxDecoration(
                  color: Colours.white_color,
                  border: Border.all(
                    color: Colours.text_placehold,
                    width: 0.5,
                  ),
                  borderRadius: new BorderRadius.circular(5)),
              child: TextField(
                controller: searchWordTC,
                style: TextStyles.text13MediumLabel,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    left: 12,
                    bottom: 5,
                    top: 12,
                  ),
                  hintText: "搜索",
                  hintStyle: TextStyles.text13MediumPLabel,
                  border: InputBorder.none,
                ),
                onSubmitted: (searchText) {
                  // if (searchText.length == 0) {
                  //   historyDetailBloc.showToast('搜索关键字不能为空');
                  // }
                  // FocusScope.of(context).requestFocus(FocusNode());
                  historyDetailBloc.searchTextStr = searchText;
                  historyDetailBloc.isChoosePanel = false;
                  historyDetailBloc.currentPage = 0;
                  historyDetailBloc.dataList = List();
                  if (historyDetailBloc.filterMap != null) {
                    StringBuffer startTMD = StringBuffer();
                    startTMD.write(DateUtil.getDateStrByDateTime(
                        historyDetailBloc.filterMap['startTime'],
                        format: DateFormat.YEAR_MONTH_DAY));
                    startTMD.write(' 00:00:00');
                    StringBuffer endTMD = StringBuffer();
                    endTMD.write(DateUtil.getDateStrByDateTime(
                        historyDetailBloc.filterMap['endTime'],
                        format: DateFormat.YEAR_MONTH_DAY));
                    endTMD.write(' 23:59:59');
                    Future.delayed(new Duration(milliseconds: 10)).then((_) {
                      historyDetailBloc.getPlanLists(
                          historyDetailBloc.currentPage, [-1, 4],
                          startTime: startTMD.toString(),
                          endTime: endTMD.toString(),
                          planType: historyDetailBloc.filterMap['filterType'],
                          cardId: historyDetailBloc.valueId,
                          questionOnly:
                              historyDetailBloc.filterMap['onlyQuestionOrder'],
                          order: planOrder);
                    });
                  } else {
                    historyDetailBloc.getPlanLists(
                      historyDetailBloc.currentPage,
                      [-1, 4],
                      cardId: historyDetailBloc.valueId,
                      order: planOrder,
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(
            width: 18,
          ),
          Container(
            width: 55,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Row(
                children: <Widget>[
                  Image.asset('assets/images/user/order_icon.png',
                      width: 18, height: 15),
                  SizedBox(
                    width: 7,
                  ),
                  Text('排序', style: TextStyles.text13MediumLabel),
                ],
              ),
              onPressed: () {
                if (planOrder == "DESC") {
                  planOrder = "ASC";
                } else {
                  planOrder = "DESC";
                }
                historyDetailBloc.isChoosePanel = false;
                historyDetailBloc.currentPage = 0;
                historyDetailBloc.dataList = List();
                if (historyDetailBloc.filterMap != null) {
                  StringBuffer startTMD = StringBuffer();
                  startTMD.write(DateUtil.getDateStrByDateTime(
                      historyDetailBloc.filterMap['startTime'],
                      format: DateFormat.YEAR_MONTH_DAY));
                  startTMD.write(' 00:00:00');
                  StringBuffer endTMD = StringBuffer();
                  endTMD.write(DateUtil.getDateStrByDateTime(
                      historyDetailBloc.filterMap['endTime'],
                      format: DateFormat.YEAR_MONTH_DAY));
                  endTMD.write(' 23:59:59');
                  Future.delayed(new Duration(milliseconds: 10)).then((_) {
                    historyDetailBloc.getPlanLists(
                        historyDetailBloc.currentPage, [-1, 4],
                        startTime: startTMD.toString(),
                        endTime: endTMD.toString(),
                        planType: historyDetailBloc.filterMap['filterType'],
                        cardId: historyDetailBloc.valueId,
                        questionOnly:
                            historyDetailBloc.filterMap['onlyQuestionOrder'],
                        order: planOrder);
                  });
                } else {
                  historyDetailBloc.getPlanLists(
                      historyDetailBloc.currentPage, [-1, 4],
                      cardId: historyDetailBloc.valueId, order: planOrder);
                }
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 55,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Row(
                children: <Widget>[
                  Image.asset('assets/images/user/filtrate_icon.png',
                      width: 17, height: 17),
                  SizedBox(
                    width: 7,
                  ),
                  Text('筛选', style: TextStyles.text13MediumLabel),
                ],
              ),
              onPressed: () {
                showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (BuildContext context) {
                    return PlanFiltrateAlert(2);
                  },
                ).then((Map<String, dynamic> resMap) {
                  print(resMap);
                  historyDetailBloc.isChoosePanel = false;
                  if (resMap != null) {
                    historyDetailBloc.filterMap = resMap;
                    historyDetailBloc.currentPage = 0;
                    historyDetailBloc.dataList = List();
                    planOrder = "DESC";
                    StringBuffer startTMD = StringBuffer();
                    startTMD.write(DateUtil.getDateStrByDateTime(
                        resMap['startTime'],
                        format: DateFormat.YEAR_MONTH_DAY));
                    startTMD.write(' 00:00:00');
                    StringBuffer endTMD = StringBuffer();
                    endTMD.write(DateUtil.getDateStrByDateTime(
                        resMap['endTime'],
                        format: DateFormat.YEAR_MONTH_DAY));
                    endTMD.write(' 23:59:59');
                    Future.delayed(new Duration(milliseconds: 10)).then((_) {
                      historyDetailBloc.getPlanLists(0, [-1, 4],
                          startTime: startTMD.toString(),
                          endTime: endTMD.toString(),
                          planType: resMap['filterType'],
                          cardId: historyDetailBloc.valueId,
                          questionOnly: resMap['onlyQuestionOrder']);
                    });
                  }
                });
              },
            ),
          ),
          SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }
}
