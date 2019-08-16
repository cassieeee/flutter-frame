import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

class HistoryDetailPage extends StatefulWidget {
  HistoryDetailPage(this.valueId, this.fromType);
  final int valueId;
  final int fromType;
  @override
  State<StatefulWidget> createState() {
    return HistoryDetailPageState();
  }
}

class HistoryDetailPageState extends State<HistoryDetailPage>
    with AutomaticKeepAliveClientMixin {
  final HistoryDetailBloc historyDetailBloc = HistoryDetailBloc();

  final GlobalKey<EasyRefreshState> _historyDetailPageRefreshKey =
      GlobalKey<EasyRefreshState>();
  final GlobalKey<RefreshHeaderState> _historyDetailPageheaderKey =
      GlobalKey<RefreshHeaderState>();
  final GlobalKey<RefreshFooterState> _historyDetailPagefooterKey =
      GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    historyDetailBloc.bloccontext = context;
    historyDetailBloc.valueId = widget.valueId ?? 0;
    historyDetailBloc.fromType = widget.fromType;
    return BlocProvider<HistoryDetailBloc>(
      bloc: historyDetailBloc,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              '历史计划',
              style: TextStyle(fontSize: 18),
            ),
          ),
          backgroundColor: Colours.background_color,
          body: EasyRefresh(
            key: _historyDetailPageRefreshKey,
            refreshHeader: MaterialHeader(
              key: _historyDetailPageheaderKey,
            ),
            refreshFooter: MaterialFooter(
              key: _historyDetailPagefooterKey,
            ),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                HistoryDetailHead(),
                HistoryDetailMiddle(),
              ],
            ),
            onRefresh: () async {
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
                          historyDetailBloc.filterMap['onlyQuestionOrder']);
                });
              } else {
                historyDetailBloc.getPlanLists(
                    historyDetailBloc.currentPage, [-1, 4],
                    cardId: historyDetailBloc.valueId);
              }
            },
            loadMore: () async {
              historyDetailBloc.isChoosePanel = false;
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
                          historyDetailBloc.filterMap['onlyQuestionOrder']);
                });
              } else {
                historyDetailBloc.getPlanLists(
                    historyDetailBloc.currentPage, [-1, 4],
                    cardId: historyDetailBloc.valueId);
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
