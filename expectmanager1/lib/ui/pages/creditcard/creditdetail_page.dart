import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:youxinbao/blocs/bloc_provider.dart';
import 'package:youxinbao/blocs/creditcard/creditdetail_bloc.dart';
import 'package:youxinbao/common/screen.dart';
import 'package:youxinbao/models/models.dart';
import 'package:youxinbao/res/colors.dart';
import 'package:youxinbao/res/styles.dart';
import 'package:youxinbao/ui/widgets/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import '../../../ui/pages/page_index.dart';
import 'creditdetail_bottom2.dart';

class CreditDetailPage extends StatefulWidget {
  CreditDetailPage(this.showType, this.cardItemModel);
  final int showType;
  final CardItemModel cardItemModel;
  @override
  State<StatefulWidget> createState() => _CreditDetailPage();
}

class _CreditDetailPage extends State<CreditDetailPage> {
  final CreditDetailBloc creditDetailBloc = CreditDetailBloc();
  @override
  Widget build(BuildContext context) {
    creditDetailBloc.cardModel = widget.cardItemModel;
    creditDetailBloc.startTimeDate =
        (DateTime.now()).subtract(Duration(days: 6));
    creditDetailBloc.endTimeDate = DateTime.now();
    return BlocProvider<CreditDetailBloc>(
      bloc: creditDetailBloc,
      child: DefaultTabController(
        length: widget.showType,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              '${widget.cardItemModel.bankName}卡',
              style: TextStyle(fontSize: 18),
            ),
          ),
          backgroundColor: Colours.background_color,
          body: CreditWholePage(
            showType: widget.showType,
            cardItemModel: widget.cardItemModel,
          ),
        ),
      ),
    );
  }
}

class CreditWholePage extends StatefulWidget {
  final int showType;
  final CardItemModel cardItemModel;
  CreditWholePage({
    Key key,
    @required this.showType,
    @required this.cardItemModel,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CreditWholePage();
}

class _CreditWholePage extends State<CreditWholePage>
    with TickerProviderStateMixin {
  TabController tabController;
  TabController tabController1;
  CreditDetailBloc creditDetailBloc;
  int billIndex = 0; //账单默认打开
  bool isPlanExpanded = false; //计划是否打开
  bool isExpanded = false; //账单是否打开
  int tabIndex = 0; //默认第一页
  Map<String, dynamic> filterMap;
  final List<Tab> titleTabs = <Tab>[
    Tab(
      child: Text("计划"),
    ),
    Tab(
      child: Text("账单"),
    )
  ];
  @override
  void initState() {
    // tabController = new TabController(length: 2, vsync: this);
    // tabController.addListener(tabControlerListener);
    super.initState();
    // 添加监听器
    tabController = TabController(vsync: this, length: titleTabs.length)
      ..addListener(() {
        if (tabController.index.toDouble() == tabController.animation.value) {
          if (mounted) {
            this.setState(() {
              if (tabController.index == 0) {
                eventBuss.fire(PlanSetPanel(false));
                eventBuss.fire(BillSetPanel(true));
              } else {
                eventBuss.fire(PlanSetPanel(true));
                eventBuss.fire(BillSetPanel(false));
              }
              tabIndex = tabController.index;
            });
          }
        }
      });

    eventBuss.on<PlanScrollHeight>().listen((event) {
      if (mounted) {
        isPlanExpanded = event.isExpanded;
      }
    });

    eventBuss.on<ScrollHeight>().listen((event) {
      if (mounted) {
        billIndex = event.index;
        isExpanded = event.isExpanded;
      }
    });

    eventBuss.on<PlanFilter>().listen((event) {
      if (mounted) {
        filterMap = event.filterMap;
      }
    });
  }

  @override
  void dispose() {
    // tabController.removeListener(tabControlerListener);
    tabController.dispose();
    super.dispose();
  }


  Future<Null> onRefresh() {
    final Completer<Null> completer = new Completer<Null>();
    new Timer(const Duration(seconds: 1), () {
      completer.complete(null);
    });
    return completer.future.then((_) {
      if (widget.showType != 1) {
        if (tabIndex == 1) {
          creditDetailBloc.getBillLists(
              creditDetailBloc.cardModel.id, billIndex, isExpanded);
        } else {
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
            creditDetailBloc.getPlanLists(2, isPlanExpanded, [1, 2],
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
            creditDetailBloc.getPlanLists(2, isPlanExpanded, [1, 2],
                startTime: startTMD.toString(),
                endTime: endTMD.toString(),
                cardId: creditDetailBloc.cardModel.id);
          }
          eventBuss.fire(PlanSetPanel(false));
          eventBuss.fire(BillSetPanel(false));
        }
      } else {
        creditDetailBloc.getBillLists(
            creditDetailBloc.cardModel.id, billIndex, isExpanded);
      }
    });
  }

  List<Widget> buildSliverHeader(appBarHeight) {
    var widgets = <Widget>[];
    widgets.add(
      SliverPersistentHeader(
        pinned: false,
        delegate: _SliverAppBarDelegate(
            Container(
              child: CreditDetailHead(widget.showType, widget.cardItemModel),
            ),
            appBarHeight),
      ),
    );
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    creditDetailBloc = BlocProvider.of<CreditDetailBloc>(context);
    creditDetailBloc.bloccontext = context;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    var _appBarHeight = widget.showType == 1
        ? 214.0 - statusBarHeight
        : 264.0 - statusBarHeight;
    var primaryTabBar = new Container(
      padding: EdgeInsets.only(
        left: 16 * Screen.screenRate,
        right: 16 * Screen.screenRate,
        top: 10,
        bottom: 10,
      ),
      height: 60 * Screen.screenRate,
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
      ),
      child: Container(
        height: 40 * Screen.screenRate,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: TabBar(
          controller: widget.showType == 1 ? tabController1 : tabController,
          labelStyle: TextStyles.text15MediumLabel,
          labelColor: Colours.blue_color,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colours.text_lable,
          indicatorColor: Colours.blue_color,
          indicatorWeight: 2,
          tabs: widget.showType == 1
              ? <Widget>[
                  Tab(
                    child: Text("账单"),
                  ),
                ]
              : titleTabs,
        ),
      ),
    );
    return widget.showType != 1 
        ? NestedScrollViewRefreshIndicator(
            onRefresh: onRefresh,
            child: NestedScrollView(
              headerSliverBuilder: (c, f) {
                return buildSliverHeader(_appBarHeight);
              },
              body: Column(
                children: <Widget>[
                  primaryTabBar,
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: <Widget>[
                        CreditDetailBottom(),
                        CreditDetailBottom2(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : NestedScrollView(
            headerSliverBuilder: (c, f) {
              return buildSliverHeader(_appBarHeight);
            },
            body: Column(
              children: <Widget>[
                primaryTabBar,
                Expanded(
                  child: widget.showType == 1
                      ? TabBarView(
                          controller: tabController1,
                          children: <Widget>[
                            CreditDetailBottom2(),
                          ],
                        )
                      : TabBarView(
                          controller: tabController,
                          children: <Widget>[
                            CreditDetailBottom(),
                            CreditDetailBottom2(),
                          ],
                        ),
                ),
              ],
            ),
          );
  }
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
