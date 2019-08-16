import 'package:youxinbao/ui/pages/main/main_page.dart';

import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

import 'package:youxinbao/ui/widgets/extended_nested_scroll_view.dart';

class DiagnoseInfoPage extends StatefulWidget {
  DiagnoseInfoPage(this.cardId, this.backType);
  final int cardId;
  final int backType;
  @override
  State<StatefulWidget> createState() => DiagnoseInfoPageState();
}

class DiagnoseInfoPageState extends State<DiagnoseInfoPage>
    with AutomaticKeepAliveClientMixin {
  bool showTipView = false;
  CardDiagnoseBloc cardDiagnoseBloc = CardDiagnoseBloc();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    cardDiagnoseBloc.bloccontext = context;
    Future.delayed(new Duration(milliseconds: 10)).then((_) {
      if (cardDiagnoseBloc.diagnoseData.isEmpty)
        cardDiagnoseBloc.cardDiagnoseInfo('${widget.cardId}', '', '');
    });
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    var _appBarHeight = 248 + 15 - statusBarHeight + 12;
    return BlocProvider<CardDiagnoseBloc>(
      bloc: cardDiagnoseBloc,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            leading: FlatButton(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colours.white_color,
              ),
              onPressed: () {
                if (widget.backType == 1) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(builder: (ctx) => MainPage()),
                    (Route<dynamic> route) => false,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: RouteSettings(name: "CreditDiagnosePage"),
                      builder: (BuildContext context) => CreditDiagnosePage(),
                    ),
                  );
                } else if (widget.backType == 2) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(builder: (ctx) => MainPage()),
                    (Route<dynamic> route) => false,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: RouteSettings(name: "CreditDiagnosePage"),
                      builder: (BuildContext context) => CreditDiagnosePage(),
                    ),
                  );
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
            backgroundColor: Colours.blue_color,
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              '信用卡诊断',
              style: TextStyle(fontSize: 18),
            ),
            // actions: <Widget>[
            //   Container(
            //     width: 40,
            //     height: 20,
            //     child: FlatButton(
            //       padding: EdgeInsets.all(0),
            //       child: Icon(
            //         Icons.more_horiz,
            //         color: Colors.white,
            //       ),
            //       onPressed: () {
            //         showTipView = !showTipView;
            //         setState(() {});
            //       },
            //     ),
            //   ),
            // ],
          ),
          backgroundColor: Colours.background_color,
          body: NestedScrollView(
            headerSliverBuilder: (c, f) {
              return buildSliverHeader(_appBarHeight);
            },
            body: Column(
              children: <Widget>[
                Container(
                  height: 64,
                  color: Colours.background_color,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    height: 44,
                    color: Colours.white_color,
                    child: TabBar(
                      labelStyle: TextStyles.text15MediumLabel,
                      labelColor: Colours.blue_color,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colours.text_lable,
                      indicatorColor: Colours.blue_color,
                      indicatorWeight: 2,
                      tabs: <Widget>[
                        Tab(
                          child: Text("额度诊断"),
                        ),
                        Tab(
                          child: Text("消费诊断"),
                        ),
                        Tab(
                          child: Text("还款诊断"),
                        ),
                        Tab(
                          child: Text("其他诊断"),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      LimitDiagnosePage(),
                      ConsumeDiagnosePage(),
                      RepaymentDiagnosePage(),
                      StandbyDiagnosePage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildSliverHeader(appBarHeight) {
    var widgets = <Widget>[];
    widgets.add(
      SliverPersistentHeader(
        pinned: false,
        delegate: _SliverAppBarDelegate(
            Container(
              child: buildHead(),
            ),
            appBarHeight),
      ),
    );
    return widgets;
  }

  Widget buildHead() {
    return StreamBuilder(
      stream: cardDiagnoseBloc.cardDiagnoseStream,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        String icon;
        String title;
        num grade;
        String amountDesc;
        String amountDate;
        if (snapshot.data == null) {
          return Container();
        } else {
          icon = snapshot.data['iconurl'];
          title = snapshot.data['title'];
          grade = snapshot.data['amountRate'];
          amountDesc = snapshot.data['amountDesc'];
          amountDate = snapshot.data['tevaedate'];
        }
        return Stack(
          children: <Widget>[
            Container(
              height: 248,
              color: Colours.blue_color,
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 15,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                        height: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/user/card_default.jpeg",
                            image: icon,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          title == null ? '诊断报告' : '$title诊断报告',
                          style: TextStyles.text16WhiteMediumLabel,
                        ),
                      ),
                      Image.asset('assets/images/user/dvip_icon.png',
                          width: 19, height: 17),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'VIP特权',
                        style: TextStyles.text14WhiteMediumLabel,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     Text(
                  //       '吴哈',
                  //       style: TextStyles.text18WhiteMediumLabel,
                  //     ),
                  //     Container(
                  //       width: 68,
                  //       height: 22,
                  //       alignment: Alignment.center,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(11.0),
                  //         color: Colours.orange_color,
                  //       ),
                  //       child: Text(
                  //         '金卡',
                  //         style: TextStyles.text16WhiteMediumLabel,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Container(
                    width: 150,
                    height: 121,
                    margin: EdgeInsets.only(
                      top: 22,
                    ),
                    // color: Colours.background_color2,
                    child: Stack(
                      children: <Widget>[
                        grade != null
                            ? CustomPaint(
                                size: Size(150, 121),
                                painter: MyPainter.dottingArc(grade, 1),
                              )
                            : Container(),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(
                            top: 55,
                          ),
                          child: Text(
                            grade == null ? '0' : '${grade.toInt()}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeights.medium,
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(
                            top: 100,
                          ),
                          child: Text(
                            amountDesc == null ? '' : '$amountDesc',
                            textAlign: TextAlign.center,
                            style: TextStyles.text14WhiteMediumLabel,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    amountDate == null ? '诊断时间：' : '诊断时间：$amountDate日',
                    style: TextStyles.text12WihteMediumLabel,
                  ),
                ],
              ),
            ),
            Positioned(
              right: 6,
              child: AnimatedOpacity(
                opacity: showTipView ? 1.0 : 0.0,
                duration: Duration(
                  milliseconds: 300,
                ),
                child: Container(
                  width: 127,
                  height: 74,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/user/diagnosemore_bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 127,
                        height: 33,
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                  'assets/images/user/historyreport_icon.png',
                                  width: 16,
                                  height: 15),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '历史报告',
                                style: TextStyles.text13WhiteMediumLabel,
                              ),
                            ],
                          ),
                          onPressed: () {
                            showTipView = false;
                            setState(() {});
                          },
                        ),
                      ),
                      Container(
                        width: 127,
                        height: 33,
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                  'assets/images/user/usehelp_icon.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '使用帮助',
                                style: TextStyles.text13WhiteMediumLabel,
                              ),
                            ],
                          ),
                          onPressed: () {
                            showTipView = false;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._head, this._height);

  final Container _head;
  final double _height;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _head;
  }

  @override
  double get maxExtent => _height;

  @override
  double get minExtent => _height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
