import 'package:rxdart/rxdart.dart';

import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

class CreditCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreditCardPageState();
}

class CreditCardPageState extends State<CreditCardPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  CreditCardBloc creditCardBloc = CreditCardBloc();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<CreditCardBloc>(
      bloc: creditCardBloc,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colours.background_color,
          body: EasyRefresh(
            key: _easyRefreshKey,
            refreshHeader: MaterialHeader(
              key: _headerKey,
            ),
            refreshFooter: MaterialFooter(
              key: _footerKey,
            ),
            child: ListView(
              padding: EdgeInsets.only(top: 0),
              children: <Widget>[
                CreditCardHead(),
                CreditCardTabBar(),
                buildTabBarView(),
              ],
            ),
            onRefresh: () async {
              creditCardBloc.getCreditInfo();
            },
            // loadMore: () async {
            //   await Future.delayed(const Duration(seconds: 1), () {});
            // },
          ),
        ),
      ),
    );
  }

  Widget buildTabBarView() {
    return StreamBuilder(
        stream: creditCardBloc.changeTabStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (!snapshot.hasData) return Container();
          List<CardItemModel> _cardList =
              creditCardBloc.cardInfoModel.cardList.cast<CardItemModel>();
          List<CardItemModel> need1List =
              _cardList.where((model) => model.isDelegated == 0).toList();
          List<CardItemModel> need2List =
              _cardList.where((model) => model.isDelegated == 1).toList();
          int index = snapshot.data ?? 0;
          return Container(
            width: Screen.width,
            height: index != 1
                ? 20 * Screen.screenRate +
                    187.0 * need1List.length +
                    10 * Screen.screenRate
                : 20 * Screen.screenRate +
                    249.0 * need2List.length +
                    10 * Screen.screenRate,
            padding: EdgeInsets.only(
              left: 16 * Screen.screenRate,
              right: 16 * Screen.screenRate,
            ),
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                CreditCardBottom(),
                CreditCardBottom2(),
              ],
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}

class CreditCardTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreditCardTabBarState();
}

class CreditCardTabBarState extends State<CreditCardTabBar> {
  @override
  Widget build(BuildContext context) {
    final CreditCardBloc creditCardBloc =
        BlocProvider.of<CreditCardBloc>(context);
    return Container(
      height: 50,
      child: StreamBuilder(
        stream: creditCardBloc.cardInfoStream,
        builder: (BuildContext context, AsyncSnapshot<CardInfoModel> snapshot) {
          int delnum =
              snapshot.hasData ? snapshot.data.delegateCount.toInt() : 0;
          int undelnum =
              snapshot.hasData ? snapshot.data.undelegateCount.toInt() : 0;
          return TabBar(
            labelStyle: TextStyles.text15MediumLabel,
            labelColor: Colours.blue_color,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colours.text_lable,
            indicatorColor: Colours.blue_color,
            indicatorWeight: 2,
            onTap: (index) {
              creditCardBloc.currentTabIndex = index;
              creditCardBloc.changeTabSink.add(index);
            },
            tabs: <Widget>[
              Tab(
                child: Text("未托管($undelnum)"),
              ),
              Tab(
                child: Text("已托管($delnum)"),
              ),
            ],
          );
        },
      ),
    );
  }
}
