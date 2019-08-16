import '../../../common/component_index.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

class BalanceDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BalanceDetailPageState();
}

class BalanceDetailPageState extends State<BalanceDetailPage> {
  final BanalanceDetailBloc banalanceDetailBloc = BanalanceDetailBloc();
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  int pageindex = 0;
  List dataList = List();
  @override
  void initState() {
    banalanceDetailBloc.bloccontext = context;
    Future.delayed(new Duration(milliseconds: 10)).then((_) {
      banalanceDetailBloc.getBanalanceDetailAction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background_color,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          '余额明细',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: EasyRefresh(
        key: _easyRefreshKey,
        refreshHeader: MaterialHeader(
          key: _headerKey,
        ),
        refreshFooter: MaterialFooter(
          key: _footerKey,
        ),
        // behavior: ScrollOverBehavior(),
        child: StreamBuilder(
          stream: banalanceDetailBloc.banalanceDetailStream,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData) return Container();
            // if (pageindex == 0) dataList = List();
            if (snapshot.data.length > 0 && dataList.length == 0) {
              dataList.addAll(snapshot.data);
              pageindex++;
            }
            return Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              height: Screen.height - Screen.navigationBarHeight - 20,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    color: Colours.white_color,
                    padding: EdgeInsets.only(
                      left: 17,
                      right: 17,
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 260 * Screen.screenRate,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '${dataList[index]['desc']}',
                                    style: TextStyles.text14MediumLabel,
                                  ),
                                  // SizedBox(
                                  //   width: 9,
                                  // ),
                                  // Container(
                                  //   width: 60,
                                  //   height: 20,
                                  //   child: FlatButton(
                                  //     padding: EdgeInsets.all(0),
                                  //     child: Text(
                                  //       '查看该计划',
                                  //       style: TextStyle(
                                  //         fontSize: 12,
                                  //         color: Colours.blue_color,
                                  //         fontWeight: FontWeights.medium,
                                  //       ),
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
                            ),
                            Text(
                              '${dataList[index]['changeMoney']}',
                              style: TextStyles.text16MediumLabel,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '${dataList[index]['updateTime']}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colours.text_placehold2,
                                fontWeight: FontWeights.medium,
                              ),
                            ),
                            Text(
                              '余额：${dataList[index]['destMoney']}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colours.text_placehold2,
                                fontWeight: FontWeights.medium,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.5,
                        ),
                        Container(
                          width: 323,
                          height: 0.5,
                          color: Colours.background_color2,
                        ),
                      ],
                    ),
                  );
                },
                itemCount: dataList.length,
              ),
            );
          },
        ),
        onRefresh: () async {
          pageindex = 0;
          dataList = List();
          banalanceDetailBloc.getBanalanceDetailAction(page: pageindex);
        },
        loadMore: () async {
          banalanceDetailBloc.getBanalanceDetailAction(page: pageindex);
        },
      ),
    );
  }
}
