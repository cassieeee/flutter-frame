import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MinePageState();
}

class MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  MineBloc mineBloc = MineBloc();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<MineBloc>(
      bloc: mineBloc,
      child: Scaffold(
        body: EasyRefresh(
          key: _easyRefreshKey,
          refreshHeader: MaterialHeader(
            key: _headerKey,
          ),
          refreshFooter: MaterialFooter(
            key: _footerKey,
          ),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              top: 0,
            ),
            children: <Widget>[
              MineHead(),
              MineMiddle(),
              MineBottom(),
            ],
          ),
          onRefresh: () async {
            mineBloc.getInfos();
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
