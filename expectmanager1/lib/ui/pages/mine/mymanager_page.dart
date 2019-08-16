import 'package:common_utils/common_utils.dart';
import 'package:youxinbao/blocs/bloc_index.dart';
import 'package:youxinbao/common/screen.dart';
import 'package:youxinbao/res/colors.dart';
import 'package:youxinbao/res/styles.dart';
import 'package:youxinbao/ui/widgets/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import '../../../ui/pages/page_index.dart';
import 'package:event_bus/event_bus.dart';
import 'dart:async';

EventBus myEventBus = new EventBus();

class MasterFilter {
  Map<String, dynamic> filterMap;
  MasterFilter(this.filterMap);
}

class MasterScroll {
  bool isExpanded;
  MasterScroll(this.isExpanded);
}

class MasterPlan {
  bool isChoosePanel;
  MasterPlan(this.isChoosePanel);
}

class MyManagerPage extends StatelessWidget {
  const MyManagerPage(this.mapItem);
  final Map<String, dynamic> mapItem;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyManagerBloc>(
      bloc: MyManagerBloc(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Color(0xFF0DAEFF),
            title: Text(
              '我的管理师',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          body: ManagerPlanTab(mapItem),
        ),
      ),
    );
  }
}

class ManagerPlanTab extends StatefulWidget {
  final Map<String, dynamic> mapItem;
  ManagerPlanTab(this.mapItem);
  @override
  State<StatefulWidget> createState() => _ManagerPlanTab();
}

class _ManagerPlanTab extends State<ManagerPlanTab>
    with TickerProviderStateMixin {
  MyManagerBloc myManagerBloc;
  TabController tabController;
  bool isFirst = true;
  int planIndex = 0; //计划默认打开
  bool isExpanded = false;
  int tabIndex = 0;
  Map<String, dynamic> filterMap;
  final List<Tab> titleTabs = <Tab>[
    Tab(
      child: Text("代管信息"),
    ),
    Tab(
      child: Text("计划"),
    ),
  ];
  @override
  void initState() {
    super.initState();
    // 添加监听器
    tabController = TabController(vsync: this, length: titleTabs.length)
      ..addListener(() {
        if (tabController.index.toDouble() == tabController.animation.value) {
          if (mounted) {
            if (tabController.index == 0) {
              myEventBus.fire(MasterPlan(true));
            } else {
              myEventBus.fire(MasterPlan(false));
            }
            myManagerBloc.tabIndex = tabController.index;
          }
        }
      });

    myEventBus.on<MasterFilter>().listen((event) {
      if (mounted) {
        filterMap = event.filterMap;
      }
    });

    myEventBus.on<MasterScroll>().listen((event) {
      if (mounted) {
        isExpanded = event.isExpanded;
      }
    });
  }

  @override
  void dispose() {
    // tabController.removeListener(tabControlerListener);
    tabController.dispose();
    super.dispose();
  }

  Widget showMoreLoadingWidget() {
    return Container(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '加载中...',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
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
              child: MyManagerHead(widget.mapItem),
            ),
            appBarHeight),
      ),
    );

    return widgets;
  }

  Future<Null> onRefresh() {
    final Completer<Null> completer = new Completer<Null>();
    new Timer(const Duration(seconds: 1), () {
      completer.complete(null);
    });
    return completer.future.then(
      (_) {
        if (myManagerBloc.tabIndex == 1) {
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
            Future.delayed(new Duration(milliseconds: 10)).then((_) {
              myManagerBloc.getPlanLists(2, isExpanded, [1, 2],
                  startTime: startTMD.toString(),
                  endTime: endTMD.toString(),
                  planType: filterMap['filterType'],
                  masterId: widget.mapItem['id']);
            });
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
            myManagerBloc.getPlanLists(2, isExpanded, [1, 2],
                startTime: startTMD.toString(),
                endTime: endTMD.toString(),
                masterId: widget.mapItem['id']);
          }
          myEventBus.fire(MasterPlan(false));
        } else {
          myManagerBloc.getMasterOrderCards(myManagerBloc.orderId);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    myManagerBloc = BlocProvider.of<MyManagerBloc>(context);
    myManagerBloc.bloccontext = context;
    myManagerBloc.startTimeDate = (DateTime.now()).subtract(Duration(days: 6));
    myManagerBloc.endTimeDate = DateTime.now();
    if (isFirst) {
      myManagerBloc.escrowHeightSink.add(
          widget.mapItem['orderList'].length * Screen.screenRate * 100 +
              Screen.screenRate * 64);
      isFirst = false;
    }
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    var _appBarHeight = 288.0 - statusBarHeight;
    var primaryTabBar = Container(
      // color: Color(0xFFF2F2F2),
      child: Container(
        height: 44,
        color: Colours.white_color,
        margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: TabBar(
          controller: tabController,
          labelStyle: TextStyles.text16MediumLabel,
          labelColor: Colours.blue_color,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colours.text_lable,
          indicatorColor: Colours.blue_color,
          indicatorWeight: 2,
          tabs: titleTabs,
        ),
      ),
    );
    return NestedScrollViewRefreshIndicator(
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
                  MyManagerBottom(widget.mapItem),
                  MyManagerBottom2(widget.mapItem),
                ],
              ),
            ),
          ],
        ),
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
