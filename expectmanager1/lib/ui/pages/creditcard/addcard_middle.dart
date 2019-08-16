import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class AddCardMiddle extends StatefulWidget {
  AddCardMiddle({this.toUid});
  final int toUid;
  @override
  State<StatefulWidget> createState() => AddCardMiddleState();
}

class AddCardMiddleState extends State<AddCardMiddle>
    with AutomaticKeepAliveClientMixin {
  List<List<String>> titleItems = <List<String>>[
    [
      '一账通用户名(手机号/身份证/信用卡号)',
      '一账通用户名(手机号/身份证/信用卡号)',
      '请确认已开通网上银行',
      '一账通密码',
      '6位以上数字、字母组合',
      '请输入一账通用户名',
      '请输入一账通密码',
    ],
    [
      '手机号',
      '手机号',
      '请确认已开通网上银行',
      '登录密码',
      '6位以上数字、字母组合/手机银行',
      '请输入手机号',
      '请输入登录密码',
    ],
    [
      '身份证/信用卡号/手机号',
      '身份证/信用卡号/手机号',
      '请确认已开通华夏银行信用卡商城',
      '登录密码',
      '6位以上数字、字母组合',
      '请输入用户名',
      '请输入登录密码',
    ],
    [
      '信用卡号',
      '信用卡号',
      '请输入信用卡卡号',
      '查询密码',
      '请输入6位数查询密码',
      '请输入信用卡卡号',
      '请输入6位数查询密码',
    ],
    [
      '身份证号',
      '身份证号',
      '请输入您的身份证号',
      '查询密码',
      '请输入6位数查询密码',
      '请输入您的身份证号',
      '请输入6位数查询密码',
    ],
    [
      '手机号',
      '手机号',
      '请确认已开通网上银行',
      '登录密码',
      '6位以上数字、字母组合/手机银行',
      '请输入手机号',
      '请输入登录密码',
    ],
  ];

  List<Icon> iconItems = <Icon>[
    new Icon(Icons.keyboard),
    new Icon(Icons.print),
    new Icon(Icons.router),
    new Icon(Icons.pages),
    new Icon(Icons.zoom_out_map),
    new Icon(Icons.zoom_out),
    new Icon(Icons.youtube_searched_for),
    new Icon(Icons.wifi_tethering),
    new Icon(Icons.wifi_lock),
    new Icon(Icons.widgets),
    new Icon(Icons.weekend),
    new Icon(Icons.web),
  ];

  Widget buildListData(
      BuildContext context, String titleItem, String iconItem, num code) {
    return InkWell(
      onTap: () {
        String webUrl =
            '${Constant.SERVER_ADDRESS}Card/addCardHtml?token=${AppInstance.currentUser.token}&banCode=$code';
        var colorStr = AppInstance.currentUser.roleType == '1'
            ? '#0DAEFF'
            : AppInstance.currentUser.roleType == '2' ? '#FF7200' : '#FFFFFF';
        InAppBrowser inAppBrowser = InAppBrowser();
        if (titleItem == '农业银行') {
          if (Platform.isIOS) {
            NavigatorUtil.pushPage(context, ImportWebPage(titleItem, webUrl));
          } else {
            inAppBrowser.open(url: webUrl, options: {
              "useShouldOverrideUrlLoading": true,
              "useOnLoadResource": true,
              'hideUrlBar': true,
              'toolbarTop': true,
              'toolbarTopBackgroundColor': colorStr,
            });
          }
        } else if (titleItem == '平安银行')
          NavigatorUtil.pushPage(context,
              ImportType2Page(titleItem, code, titleItems[0], widget.toUid));
        else if (titleItem == '交通银行') {
          if (Platform.isIOS) {
            NavigatorUtil.pushPage(context, ImportWebPage(titleItem, webUrl));
          } else {
            inAppBrowser.open(url: webUrl, options: {
              "useShouldOverrideUrlLoading": true,
              "useOnLoadResource": true,
              'hideUrlBar': true,
              'toolbarTop': true,
              'toolbarTopBackgroundColor': colorStr,
            });
          }
        } else if (titleItem == '中信银行')
          NavigatorUtil.pushPage(context,
              ImportType2Page(titleItem, code, titleItems[1], widget.toUid));
        else if (titleItem == '广发银行')
          NavigatorUtil.pushPage(context, ImportErrorPage(titleItem));
        else if (titleItem == '工商银行')
          NavigatorUtil.pushPage(context, ImportErrorPage(titleItem));
        else if (titleItem == '中国银行')
          NavigatorUtil.pushPage(context,
              ImportType2Page(titleItem, code, titleItems[1], widget.toUid));
        else if (titleItem == '华夏银行')
          NavigatorUtil.pushPage(context,
              ImportType2Page(titleItem, code, titleItems[2], widget.toUid));
        else if (titleItem == '兴业银行')
          NavigatorUtil.pushPage(context,
              ImportType2Page(titleItem, code, titleItems[3], widget.toUid));
        else if (titleItem == '浦发银行')
          NavigatorUtil.pushPage(context,
              ImportType2Page(titleItem, code, titleItems[4], widget.toUid));
        else if (titleItem == '测试银行')
          NavigatorUtil.pushPage(context,
              ImportType2Page(titleItem, code, titleItems[5], widget.toUid));
        else if (titleItem == '民生银行') {
          if (Platform.isIOS) {
            NavigatorUtil.pushPage(context, ImportWebPage(titleItem, webUrl));
          } else {
            inAppBrowser.open(url: webUrl, options: {
              "useShouldOverrideUrlLoading": true,
              "useOnLoadResource": true,
              'hideUrlBar': true,
              'toolbarTop': true,
              'toolbarTopBackgroundColor': colorStr,
            });
          }
        } else if (titleItem == '光大银行')
          NavigatorUtil.pushPage(
              context, ImportType1Page(titleItem, code, widget.toUid));
        else if (titleItem == '招商银行')
          NavigatorUtil.pushPage(
              context, ImportType1Page(titleItem, code, widget.toUid));
        else if (titleItem == '建设银行')
          NavigatorUtil.pushPage(context,
              ImportType2Page(titleItem, code, titleItems[3], widget.toUid));
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
          bottom: 10,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 28,
              height: 28,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/user/card_default.jpeg",
                  image: iconItem,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // ClipOval(
            //   child: Image.network("http://via.placeholder.com/28x28"),
            // ),
            SizedBox(
              width: 21,
            ),
            Text(
              titleItem,
              style: TextStyles.text15MediumLabel,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final AddCreditCardBloc addCreditCardBloc =
        BlocProvider.of<AddCreditCardBloc>(context);
    addCreditCardBloc.bloccontext = context;
    return StreamBuilder(
      stream: addCreditCardBloc.addCardListStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<AddCardListItem>> snapshot) {
        if (!snapshot.hasData) {
          Future.delayed(
            Duration(milliseconds: 10),
          ).then((_) {
            addCreditCardBloc.getCardListInfo();
          });
          return Container();
        }
        List<AddCardListItem> dataList = snapshot.data;
        return Container(
          height: Screen.height -
              Screen.navigationBarHeight -
              Screen.bottomSafeHeight -
              40,
          padding: EdgeInsets.only(
            top: 13,
            bottom: 20,
          ),
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, item) {
                AddCardListItem dataItem = dataList[item];
                return buildListData(
                    context, dataItem.cn, dataItem.icon, dataItem.code);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(), // 分割线

              itemCount: dataList.length),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
