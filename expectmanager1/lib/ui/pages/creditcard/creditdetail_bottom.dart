import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';
import 'creditdetail_bottom2.dart';

class PlanFilter {
  Map<String, dynamic> filterMap;
  PlanFilter(this.filterMap);
}

class PlanScrollHeight {
  bool isExpanded;
  PlanScrollHeight(this.isExpanded);
}

class PlanSetPanel {
  bool isSetPanel;
  PlanSetPanel(this.isSetPanel);
}

class CreditDetailBottom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreditDetailBottomState();
  }
}

class CreditDetailBottomState extends State<CreditDetailBottom>
    with AutomaticKeepAliveClientMixin {
  CreditDetailBloc creditDetailBloc;
  var currentPanelIndex = 0; // -1默认全部闭合
  Container _expansionPanelList;
  List<dynamic> dataList = List<dynamic>();
  bool isPlanExpanded = false; //是否打开折叠块
  bool isSetPanel = false;
  bool isFirst = true;
  Map<String, dynamic> filterMap;
  void initState() {
    super.initState();
    eventBuss.on<PlanScrollHeight>().listen((event) {
      if (mounted) {
        isPlanExpanded = event.isExpanded;
      }
    });

    eventBuss.on<PlanSetPanel>().listen((event) {
      if (mounted) {
        isSetPanel = event.isSetPanel;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    creditDetailBloc = BlocProvider.of<CreditDetailBloc>(context);
    creditDetailBloc.bloccontext = context;
    if (isFirst) {
      Future.delayed(new Duration(milliseconds: 500)).then((_) {
        StringBuffer startTMD = StringBuffer();
        StringBuffer endTMD = StringBuffer();
        isSetPanel = false;
        startTMD.write(DateUtil.getDateStrByDateTime(
            creditDetailBloc.startTimeDate,
            format: DateFormat.YEAR_MONTH_DAY));
        startTMD.write(' 00:00:00');
        endTMD.write(DateUtil.getDateStrByDateTime(creditDetailBloc.endTimeDate,
            format: DateFormat.YEAR_MONTH_DAY));
        endTMD.write(' 23:59:59');
        Future.delayed(new Duration(milliseconds: 10)).then((_) {
          creditDetailBloc.getPlanLists(2, isPlanExpanded, [1, 2],
              startTime: startTMD.toString(),
              endTime: endTMD.toString(),
              cardId: creditDetailBloc.cardModel.id);
        });
      });
      isFirst = false;
    }
    return StreamBuilder(
      stream: creditDetailBloc.creditDetailStream,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData && !isSetPanel) {
          if (snapshot.data != null) {
            dataList = snapshot.data;
          }
        }
        return NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollEndNotification) {
              if (notification.metrics.extentAfter == 0.0 &&
                  dataList.length >= 10) {
                if (filterMap != null) {
                  StringBuffer startTMD = StringBuffer();
                  startTMD.write(DateUtil.getDateStrByDateTime(
                      creditDetailBloc.startTimeDate,
                      format: DateFormat.YEAR_MONTH_DAY));
                  startTMD.write(' 00:00:00');
                  StringBuffer endTMD = StringBuffer();
                  endTMD.write(DateUtil.getDateStrByDateTime(
                      creditDetailBloc.endTimeDate,
                      format: DateFormat.YEAR_MONTH_DAY));
                  endTMD.write(' 23:59:59');
                  creditDetailBloc.getPlanLists(1, isPlanExpanded, [1, 2],
                      startTime: startTMD.toString(),
                      endTime: endTMD.toString(),
                      planType: filterMap['filterType'],
                      cardId: creditDetailBloc.cardModel.id);
                } else {
                  StringBuffer startTMD = StringBuffer();
                  StringBuffer endTMD = StringBuffer();
                  startTMD.write(DateUtil.getDateStrByDateTime(
                      creditDetailBloc.startTimeDate,
                      format: DateFormat.YEAR_MONTH_DAY));
                  startTMD.write(' 00:00:00');
                  endTMD.write(DateUtil.getDateStrByDateTime(
                      creditDetailBloc.endTimeDate,
                      format: DateFormat.YEAR_MONTH_DAY));
                  endTMD.write(' 23:59:59');
                  creditDetailBloc.getPlanLists(1, isPlanExpanded, [1, 2],
                      startTime: startTMD.toString(),
                      endTime: endTMD.toString(),
                      cardId: creditDetailBloc.cardModel.id);
                }
                eventBuss.fire(PlanSetPanel(false));
                eventBuss.fire(BillSetPanel(false));
              }
            }
          },
          child: Container(
            padding: EdgeInsets.only(
              left: 16 * Screen.screenRate,
              right: 16 * Screen.screenRate,
            ),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                buildPlanOrderList(dataList),
                Container(
                  width: 343,
                  height: 44,
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colours.blue_color,
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      '查看历史计划',
                      style: TextStyles.text16WhiteMediumLabel,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HistoryDetailPage(
                              creditDetailBloc.cardModel.id, 1),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPlanOrderList(List planListData) {
    _expansionPanelList = Container(
      width: 343,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.elliptical(5, 5))),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: ExpansionPanelCustomList(
          animationDuration: Duration(milliseconds: 500),
          expansionCallback: (panelIndex, isExpanded) {
            creditDetailBloc.caculatePlanHeight(panelIndex);
            eventBuss.fire(PlanScrollHeight(isExpanded));
            setState(() {
              isSetPanel = true;
              currentPanelIndex =
                  (currentPanelIndex != panelIndex) ? panelIndex : -1;
            });
          },
          parms: {
            'type': 'custom',
            'backgroundcolor': 0xffffffff,
            'iconcolor': 0xff666666,
            'iconsize': 35.0,
          },
          children: buildPlanListView(planListData),
        ),
      ),
    );
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 100,
            height: 40,
            margin: EdgeInsets.only(left: 290),
            child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Row(
                children: <Widget>[
                  Image.asset('assets/images/user/filtrate_icon.png',
                      width: 17, height: 17),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '筛选',
                    style: TextStyles.text13MediumLabel,
                  ),
                ],
              ),
              onPressed: () {
                showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (BuildContext context) {
                    return PlanFiltrateAlert(1);
                  },
                ).then((Map<String, dynamic> resMap) {
                  if (resMap != null) {
                    filterMap = resMap;
                    eventBuss.fire(PlanFilter(resMap));
                    StringBuffer startTMD = StringBuffer();
                    StringBuffer endTMD = StringBuffer();
                    isSetPanel = false;
                    startTMD.write(DateUtil.getDateStrByDateTime(
                        creditDetailBloc.startTimeDate,
                        format: DateFormat.YEAR_MONTH_DAY));
                    startTMD.write(' 00:00:00');
                    endTMD.write(DateUtil.getDateStrByDateTime(
                        creditDetailBloc.endTimeDate,
                        format: DateFormat.YEAR_MONTH_DAY));
                    endTMD.write(' 23:59:59');
                    Future.delayed(new Duration(milliseconds: 10)).then((_) {
                      creditDetailBloc.getPlanLists(2, isPlanExpanded, [1, 2],
                          startTime: startTMD.toString(),
                          endTime: endTMD.toString(),
                          planType: resMap['filterType'],
                          cardId: creditDetailBloc.cardModel.id);
                    });
                  }
                });
              },
            ),
          ),
          planListData.length > 0 ? _expansionPanelList : Container(),
        ],
      ),
    );
  }

  List<ExpansionPanelCustom> buildPlanListView(List planListData) {
    List<ExpansionPanelCustom> planList = List<ExpansionPanelCustom>();
    for (int i = 0; i < planListData.length; i++) {
      Map dataItem = planListData[i];
      ExpansionPanelCustom planItem = buildCreditDetailItem(
        context,
        dataItem,
        currentPanelIndex,
        i,
      );
      planList.add(planItem);
    }
    return planList;
  }

  @override
  bool get wantKeepAlive => true;
}
