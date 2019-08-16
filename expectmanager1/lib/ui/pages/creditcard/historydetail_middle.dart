import '../../../common/component_index.dart';

class HistoryDetailMiddle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HistoryDetailMiddleState();
  }
}

class HistoryDetailMiddleState extends State<HistoryDetailMiddle>
    with AutomaticKeepAliveClientMixin {
  HistoryDetailBloc historyDetailBloc;
  var currentPanelIndex = 0; // -1默认全部闭合
  Container _expansionPanelList;
  List snapshotDataList = List();

  @override
  void initState() {
    super.initState();
    Future.delayed(new Duration(milliseconds: 10)).then((_) {
      historyDetailBloc.getPlanLists(0, [-1, 4],
          cardId: historyDetailBloc.valueId, questionOnly: false);
    });
  }

  Widget build(BuildContext context) {
    super.build(context);
    historyDetailBloc = BlocProvider.of<HistoryDetailBloc>(context);
    historyDetailBloc.bloccontext = context;
    return StreamBuilder(
        stream: historyDetailBloc.historyDetailStream,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.data.length > 0 && !historyDetailBloc.isChoosePanel) {
            historyDetailBloc.dataList.addAll(snapshot.data);
            historyDetailBloc.currentPage++;
          }
          snapshotDataList = snapshot.data;
          return Column(
            children: <Widget>[
              historyDetailBloc.dataList.length > 0
                  ? buildPlanOrderList(historyDetailBloc.dataList)
                  : Container(),
              SizedBox(
                height: 10,
              ),
            ],
          );
        });
  }

  Widget buildPlanOrderList(List planListData) {
    // _expansionPanelList = snapshotDataList.length >0 ? Container(
    //   width: 343,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.vertical(top: Radius.elliptical(5, 5))),
    //   child: SingleChildScrollView(
    //     child: ExpansionPanelCustomList(
    //       animationDuration: Duration(milliseconds: 500),
    //       expansionCallback: (panelIndex, isExpanded) {
    //         setState(() {
    //           historyDetailBloc.isChoosePanel = true;
    //           currentPanelIndex =
    //               (currentPanelIndex != panelIndex) ? panelIndex : -1;
    //         });
    //       },
    //       parms: {
    //         'type': 'custom',
    //         'backgroundcolor': 0xffffffff,
    //         'iconcolor': 0xff666666,
    //         'iconsize': 35.0,
    //       },
    //       children: buildPlanListView(planListData),
    //     ),
    //   ),
    // ) : _expansionPanelList;

    _expansionPanelList = Container(
      width: 343,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.elliptical(5, 5))),
      child: SingleChildScrollView(
        child: ExpansionPanelCustomList(
          animationDuration: Duration(milliseconds: 500),
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              historyDetailBloc.isChoosePanel = true;
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
          SizedBox(
            height: 10,
          ),
          _expansionPanelList,
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
