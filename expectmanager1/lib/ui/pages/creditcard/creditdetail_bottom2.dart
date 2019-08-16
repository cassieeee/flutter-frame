import 'package:flutter/rendering.dart';

import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';
import 'package:event_bus/event_bus.dart';

EventBus eventBuss = new EventBus();

class ScrollHeight {
  int index;
  bool isExpanded;
  ScrollHeight(this.index, this.isExpanded);
}

class BillSetPanel {
  bool isBillSetPanel;
  BillSetPanel(this.isBillSetPanel);
}

class CreditDetailBottom2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreditDetailBottom2State();
  }
}

class CreditDetailBottom2State extends State<CreditDetailBottom2>
    with AutomaticKeepAliveClientMixin {
  CreditDetailBloc creditDetailBloc;
  var currentPanelIndex = 0; // -1默认全部闭合
  Container _expansionPanelList;
  int billIndex = 0;
  bool isExpanded = false;
  bool isBillSetPanel = false;
  List<dynamic> dataList = List<dynamic>();
  void inistState() {
    super.initState();
    eventBuss.on<ScrollHeight>().listen(
      (event) {
        if (mounted) {
          billIndex = event.index;
          isExpanded = event.isExpanded;
        }
      },
    );

    eventBuss.on<BillSetPanel>().listen(
      (event) {
        if (mounted) {
          isBillSetPanel = event.isBillSetPanel;
        }
      },
    );
  }

  Widget build(BuildContext context) {
    super.build(context);
    creditDetailBloc = BlocProvider.of<CreditDetailBloc>(context);
    if (creditDetailBloc.isBillOpen) {
      Future.delayed(new Duration(milliseconds: 500)).then(
        (_) {
          creditDetailBloc.getBillLists(
              creditDetailBloc.cardModel.id, billIndex, isExpanded);
        },
      );
      creditDetailBloc.isBillOpen = false;
    }
    return StreamBuilder(
      stream: creditDetailBloc.billListStream,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData && !isBillSetPanel) {
          if (snapshot.data != null) {
            dataList = snapshot.data;
          }
        }
        return Container(
          child: ListView(
            children: <Widget>[
              dataList.length > 0
                  ? buildPlanOrderList(dataList, creditDetailBloc)
                  : Container(),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPlanOrderList(
      List planListData, CreditDetailBloc creditDetailBloc) {
    _expansionPanelList = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.elliptical(5, 5))),
      child: SingleChildScrollView(
        child: ExpansionPanelCustomList(
          animationDuration: Duration(milliseconds: 500),
          expansionCallback: (panelIndex, isExpanded) {
            creditDetailBloc.changeBillHeight(panelIndex);
            eventBuss.fire(ScrollHeight(panelIndex, isExpanded));
            setState(() {
              isBillSetPanel = true;
              currentPanelIndex =
                  (currentPanelIndex != panelIndex) ? panelIndex : -1;
            });
          },
          parms: {
            'type': 'custom',
            'backgroundcolor': 0xFFF2F2F2,
            'iconcolor': 0xff666666,
            'iconsize': 35.0,
          },
          children: buildBillListView(planListData),
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

  List<ExpansionPanelCustom> buildBillListView(List planListData) {
    List<ExpansionPanelCustom> planList = List<ExpansionPanelCustom>();
    for (int i = 0; i < planListData?.length; i++) {
      Map dataItem = planListData[i];
      ExpansionPanelCustom planItem = buildCreditBillItem(
        context,
        dataItem,
        currentPanelIndex,
        i,
      );
      planList.add(planItem);
    }
    return planList;
  }

  ExpansionPanelCustom buildCreditBillItem(
      BuildContext context, Map dataItem, int currentIndex, int itemIndex) {
    return ExpansionPanelCustom(
      headerBuilder: (context, isExpanded) {
        return Container(
          height: 50 * Screen.screenRate,
          color: Colours.background_color,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 8 * Screen.screenRate,
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.5 * Screen.screenRate,
                  ),
                  Container(
                    width: 11 * Screen.screenRate,
                    height: 11 * Screen.screenRate,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(5.5 * Screen.screenRate),
                      color: Colours.text_placehold,
                    ),
                  ),
                  Container(
                    width: 1,
                    margin: EdgeInsets.only(top: 2 * Screen.screenRate),
                    height: 26.5 * Screen.screenRate,
                    color: Colours.gray_cc,
                  ),
                ],
              ),
              SizedBox(
                width: 6 * Screen.screenRate,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 4 * Screen.screenRate,
                  ),
                  Text(
                    dataItem['mon'] == '' ? '待出账单' : '${dataItem['mon']}月账单',
                    style: TextStyles.text16MediumLabel,
                  ),
                  SizedBox(
                    height: 4 * Screen.screenRate,
                  ),
                  Text(
                    dataItem['billDate'] ?? '-',
                    style: TextStyles.text12MediumPLabel,
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 3 * Screen.screenRate,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${dataItem['billMoney']}',
                        style: TextStyles.text16MediumLabel,
                      ),
                      SizedBox(
                        width: 10 * Screen.screenRate,
                      ),
                      Text(
                        '${dataItem['count']}笔',
                        style: TextStyles.text16MediumLabel,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2 * Screen.screenRate,
                  ),
                  Text(
                    '本期消费金额',
                    style: TextStyles.text12MediumPLabel,
                  ),
                ],
              ),
            ],
          ),
        );
      },
      body: Container(
        color: Colours.background_color,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 13 * Screen.screenRate,
            ),
            Container(
              width: 1,
              height: dataItem['mon'] == ''
                  ? (dataItem['detail'].length * 50 + 10) * Screen.screenRate
                  : (114 + dataItem['detail'].length * 50 + 5) *
                      Screen.screenRate,
              color: Colours.gray_cc,
            ),
            SizedBox(
              width: 11 * Screen.screenRate,
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 342 * Screen.screenRate,
                  // height: 254 * Screen.screenRate,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colours.white_color,
                  ),
                  child: Column(
                    children: <Widget>[
                      dataItem['mon'] == ''
                          ? Container()
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 8 * Screen.screenRate,
                                ),
                                Container(
                                  width: 90 * Screen.screenRate,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 6 * Screen.screenRate,
                                      ),
                                      Text(
                                        '账单总额',
                                        style: TextStyles.text13MediumPLabel,
                                      ),
                                      SizedBox(
                                        height: 8 * Screen.screenRate,
                                      ),
                                      Text(
                                        '最低还款额',
                                        style: TextStyles.text13MediumPLabel,
                                      ),
                                      SizedBox(
                                        height: 8 * Screen.screenRate,
                                      ),
                                      Text(
                                        '剩余应还',
                                        style: TextStyles.text13MediumPLabel,
                                      ),
                                      SizedBox(
                                        height: 8 * Screen.screenRate,
                                      ),
                                      Text(
                                        '剩余最低应还',
                                        style: TextStyles.text13MediumPLabel,
                                      ),
                                      SizedBox(
                                        height: 6 * Screen.screenRate,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 100 * Screen.screenRate,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 6 * Screen.screenRate,
                                      ),
                                      Text(
                                        '￥${dataItem['billMoney']}',
                                        style: TextStyles.text13MediumLabel,
                                      ),
                                      SizedBox(
                                        height: 8 * Screen.screenRate,
                                      ),
                                      Text(
                                        '￥${dataItem['minRepayMoney']}',
                                        style: TextStyles.text13MediumLabel,
                                      ),
                                      SizedBox(
                                        height: 8 * Screen.screenRate,
                                      ),
                                      Text(
                                        '￥${dataItem['remainderRepay']}',
                                        style: TextStyles.text13MediumLabel,
                                      ),
                                      SizedBox(
                                        height: 8 * Screen.screenRate,
                                      ),
                                      Text(
                                        '￥${dataItem['remainderMinRepay']}',
                                        style: TextStyles.text13MediumLabel,
                                      ),
                                      SizedBox(
                                        height: 6 * Screen.screenRate,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Container(
                                  width: 100 * Screen.screenRate,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 6 * Screen.screenRate,
                                      ),
                                      Text(
                                        '${dataItem['count']}笔',
                                        style: TextStyles.text13MediumLabel,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8 * Screen.screenRate,
                                ),
                              ],
                            ),
                      Column(
                        children: buildListItem(dataItem['detail']),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10 * Screen.screenRate,
                ),
              ],
            ),
          ],
        ),
      ),
      isExpanded: currentIndex == itemIndex,
    );
  }

  List<Widget> buildListItem(List itemDataList) {
    List<Widget> itemList = List<Widget>();
    for (int i = 0; i < itemDataList.length; i++) {
      Map itemData = itemDataList[i];
      Widget wg = Container(
          height: 50 * Screen.screenRate,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 8 * Screen.screenRate,
                  right: 8 * Screen.screenRate,
                ),
                height: 1,
                color: Colours.background_color2,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 8 * Screen.screenRate,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 4 * Screen.screenRate,
                      ),
                      Text(
                        itemData['title'] ?? '',
                        style: TextStyles.text12MediumLabel,
                      ),
                      SizedBox(
                        height: 4 * Screen.screenRate,
                      ),
                      Text(
                        '${itemData['date']}来自${itemData['from'] ?? ''}',
                        style: TextStyles.text12MediumPLabel,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    itemData['money'].toString().contains('-')
                        ? '${itemData['money']}'
                        : '-${itemData['money']}',
                    style: TextStyles.text12OrangeMediumLabel,
                  ),
                  SizedBox(
                    width: 8 * Screen.screenRate,
                  ),
                ],
              ),
            ],
          ));
      itemList.add(wg);
    }
    return itemList;
  }

  @override
  bool get wantKeepAlive => true;
}
