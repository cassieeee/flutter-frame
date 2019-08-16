import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';
import 'mymanager_page.dart';

class MyManagerBottom2 extends StatefulWidget {
  MyManagerBottom2(this.mapItem);
  final Map<String, dynamic> mapItem;
  @override
  State<StatefulWidget> createState() {
    return MyManagerBottom2State(mapItem);
  }
}

class MyManagerBottom2State extends State<MyManagerBottom2>
    with AutomaticKeepAliveClientMixin {
  MyManagerBottom2State(this.mapItem);
  Map<String, dynamic> mapItem;
  MyManagerBloc myManagerBloc;
  var currentPanelIndex = 0; // -1默认全部闭合
  Container _expansionPanelList;
  List<dynamic> dataList = List<dynamic>();
  int currentPage = 0;
  bool isChoosePanel = false;
  bool isBigExpanded = false;
  Map<String, dynamic> filterMap;
  void initState() {
    super.initState();
    myEventBus.on<MasterScroll>().listen((event) {
      if (mounted) {
        isBigExpanded = event.isExpanded;
      }
    });

    myEventBus.on<MasterPlan>().listen((event) {
      if (mounted) {
        isChoosePanel = event.isChoosePanel;
      }
    });

    myManagerBloc = BlocProvider.of<MyManagerBloc>(context);
    myManagerBloc.bloccontext = context;
    if (myManagerBloc.isPlanOpen) {
      Future.delayed(new Duration(milliseconds: 500)).then((_) {
        StringBuffer startTMD = StringBuffer();
        StringBuffer endTMD = StringBuffer();
        startTMD.write(DateUtil.getDateStrByDateTime(
            myManagerBloc.startTimeDate,
            format: DateFormat.YEAR_MONTH_DAY));
        startTMD.write(' 00:00:00');
        endTMD.write(DateUtil.getDateStrByDateTime(myManagerBloc.endTimeDate,
            format: DateFormat.YEAR_MONTH_DAY));
        endTMD.write(' 23:59:59');
        myManagerBloc.getPlanLists(2, isBigExpanded, [1, 2],
            startTime: startTMD.toString(),
            endTime: endTMD.toString(),
            masterId: widget.mapItem['id']);
      });
      myManagerBloc.isPlanOpen = false;
    }
  }

  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: myManagerBloc.masterPlanStream,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData && !isChoosePanel) {
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
                      myManagerBloc.startTimeDate,
                      format: DateFormat.YEAR_MONTH_DAY));
                  startTMD.write(' 00:00:00');
                  StringBuffer endTMD = StringBuffer();
                  endTMD.write(DateUtil.getDateStrByDateTime(
                      myManagerBloc.endTimeDate,
                      format: DateFormat.YEAR_MONTH_DAY));
                  endTMD.write(' 23:59:59');
                  Future.delayed(new Duration(milliseconds: 10)).then(
                    (_) {
                      myManagerBloc.getPlanLists(1, isBigExpanded, [1, 2],
                          startTime: startTMD.toString(),
                          endTime: endTMD.toString(),
                          planType: filterMap['filterType'],
                          masterId: widget.mapItem['id']);
                    },
                  );
                } else {
                  StringBuffer startTMD = StringBuffer();
                  StringBuffer endTMD = StringBuffer();
                  startTMD.write(DateUtil.getDateStrByDateTime(
                      myManagerBloc.startTimeDate,
                      format: DateFormat.YEAR_MONTH_DAY));
                  startTMD.write(' 00:00:00');
                  endTMD.write(DateUtil.getDateStrByDateTime(
                      myManagerBloc.endTimeDate,
                      format: DateFormat.YEAR_MONTH_DAY));
                  endTMD.write(' 23:59:59');
                  Future.delayed(new Duration(milliseconds: 10)).then(
                    (_) {
                      myManagerBloc.getPlanLists(1, isBigExpanded, [1, 2],
                          startTime: startTMD.toString(),
                          endTime: endTMD.toString(),
                          masterId: widget.mapItem['id']);
                    },
                  );
                }
                myEventBus.fire(MasterPlan(false));
              }
            }
          },
          child: Container(
            padding: EdgeInsets.only(
              left: 16 * Screen.screenRate,
              right: 16 * Screen.screenRate,
            ),
            child: ListView(
              children: <Widget>[
                buildPlanOrderList(dataList),
                Container(
                  width: 343,
                  height: 44,
                  margin: EdgeInsets.only(top: 40),
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
                          builder: (BuildContext context) =>
                              HistoryDetailPage(widget.mapItem['id'], 2),
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
        child: ExpansionPanelCustomList(
          animationDuration: Duration(milliseconds: 500),
          expansionCallback: (panelIndex, isExpanded) {
            myManagerBloc.caculatePlanHeight(panelIndex);
            myEventBus.fire(MasterScroll(isExpanded));
            setState(() {
              isChoosePanel = true;
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
                  isChoosePanel = false;
                  if (resMap != null) {
                    filterMap = resMap;
                    myEventBus.fire(MasterFilter(resMap));
                    currentPage = 0;
                    dataList = List();
                    StringBuffer startTMD = StringBuffer();
                    startTMD.write(DateUtil.getDateStrByDateTime(
                        myManagerBloc.startTimeDate,
                        format: DateFormat.YEAR_MONTH_DAY));
                    startTMD.write(' 00:00:00');
                    StringBuffer endTMD = StringBuffer();
                    endTMD.write(DateUtil.getDateStrByDateTime(
                        myManagerBloc.endTimeDate,
                        format: DateFormat.YEAR_MONTH_DAY));
                    endTMD.write(' 23:59:59');
                    Future.delayed(new Duration(milliseconds: 10)).then((_) {
                      myManagerBloc.getPlanLists(2, isBigExpanded, [1, 2],
                          startTime: startTMD.toString(),
                          endTime: endTMD.toString(),
                          planType: resMap['filterType'],
                          masterId: mapItem['id']);
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
