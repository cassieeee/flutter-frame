import '../../../../common/component_index.dart';
import '../../../../ui/pages/page_index.dart';

class ImportType2Page extends StatefulWidget {
  ImportType2Page(this.title, this.bankCode, this.titleItems, this.toUid);
  final String title;
  final num bankCode;
  final List<String> titleItems;
  final int toUid;
  @override
  State<StatefulWidget> createState() => ImportType2PageState();
}

class ImportType2PageState extends State<ImportType2Page> {
  bool hideType = true;
  @override
  void initState() {
    eventBus1.on<OpenAnimationEvent>().listen(
      (event) {
        if (mounted) {
          hideType = event.hideType;
          setState(() {});
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            '导入${widget.title}',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocProvider<ImportCardBloc>(
          bloc: ImportCardBloc(),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    buildHead(),
                    buildTabBar(context),
                    buildTabBarView(widget.titleItems),
                  ],
                ),
                Offstage(
                  offstage: hideType,
                  child: ImportAnimationPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHead() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 16 * Screen.screenRate,
            right: 16 * Screen.screenRate,
          ),
          height: 30 * Screen.screenRate,
          width: Screen.width,
          color: Colours.background_color,
          alignment: Alignment.centerLeft,
          child: Text(
            '由信用卡安全险提供保障',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeights.medium,
              color: Color(0xFF209401),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTabBar(context) {
    return Container(
      height: 40 * Screen.screenRate,
      child: TabBar(
        labelStyle: TextStyles.text15MediumLabel,
        labelColor: Theme.of(context).accentColor,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colours.text_lable,
        indicatorColor: Theme.of(context).accentColor,
        indicatorWeight: 2,
        tabs: <Widget>[
          Tab(
            child: Text("${widget.titleItems[0]}"),
          ),
        ],
      ),
    );
  }

  Widget buildTabBarView(titleItems) {
    return Container(
      width: Screen.width,
      height: Screen.height -
          70 * Screen.screenRate -
          Screen.navigationBarHeight -
          12 * Screen.screenRate,
      padding: EdgeInsets.only(
        left: 16 * Screen.screenRate,
        right: 16 * Screen.screenRate,
      ),
      child: TabBarView(
        children: <Widget>[
          CardAccountPage(widget.bankCode, titleItems, widget.toUid),
        ],
      ),
    );
  }
}

class CardAccountPage extends StatefulWidget {
  CardAccountPage(this.bankCode, this.titleItems, this.toUid);
  final num bankCode;
  final List<String> titleItems;
  final int toUid;
  @override
  State<StatefulWidget> createState() =>
      CardAccountPageState(bankCode, titleItems);
}

class CardAccountPageState extends State<CardAccountPage> {
  CardAccountPageState(this.bankCode, this.titleItems);
  bool offStage = false;
  int delegateType = -1;
  final num bankCode;

  final List<String> titleItems;
  bool agreeLicense = true;
  var accountInputCtrl = TextEditingController();
  var pwdInputCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ImportCardBloc importCardBloc =
        BlocProvider.of<ImportCardBloc>(context);
    importCardBloc.bloccontext = context;
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            color: Colours.background_color2,
            height: 1,
          ),
          SizedBox(
            height: 12 * Screen.screenRate,
          ),
          Text(
            '${titleItems[1]}',
            style: TextStyles.text14MediumLabel,
          ),
          SizedBox(
            height: 12 * Screen.screenRate,
          ),
          Container(
            height: 40 * Screen.screenRate,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).accentColor,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: accountInputCtrl,
              style: TextStyles.text14MediumLabel,
              // keyboardType: TextInputType.number,
              // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: '${titleItems[2]}',
                hintStyle: TextStyles.text14MediumPLabel,
                contentPadding: EdgeInsets.all(
                  10 * Screen.screenRate,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 12 * Screen.screenRate,
          ),
          Text(
            '${titleItems[3]}',
            style: TextStyles.text14MediumLabel,
          ),
          SizedBox(
            height: 12 * Screen.screenRate,
          ),
          Container(
            height: 40 * Screen.screenRate,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).accentColor,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: pwdInputCtrl,
              style: TextStyles.text14MediumLabel,
              // keyboardType: TextInputType.numberWithOptions(signed: true),
              obscureText: true,
              decoration: InputDecoration(
                hintText: '${titleItems[4]}',
                hintStyle: TextStyles.text14MediumPLabel,
                contentPadding: EdgeInsets.all(
                  10 * Screen.screenRate,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 16 * Screen.screenRate,
          ),
          int.tryParse(AppInstance.currentUser.roleType) == 2
              ? Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '请选择托管类型',
                            style: TextStyles.text14MediumLabel,
                          ),
                          Container(
                            width: 217 * Screen.screenRate,
                            height: 40 * Screen.screenRate,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Theme.of(context).accentColor,
                                width: 1.0,
                              ),
                              borderRadius: new BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            child: FlatButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      delegateType == -1
                                          ? '请选择托管类型'
                                          : delegateType == 1
                                              ? '单次代还'
                                              : delegateType == 2
                                                  ? '精养代操'
                                                  : '提额代操',
                                      textAlign: TextAlign.center,
                                      style: TextStyles.text14MediumLabel,
                                    ),
                                  ),
                                  Icon(
                                    offStage
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    size: 30,
                                    color: Colours.text_placehold,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                offStage = !offStage;
                                setState(() {});
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16 * Screen.screenRate,
                      ),
                      Offstage(
                        offstage: !offStage,
                        child: Container(
                          width: 323 * Screen.screenRate,
                          height: 111 * Screen.screenRate,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/user/managetype_bg.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(height: 15),
                              Container(
                                height: 20 * Screen.screenRate,
                                width: 220 * Screen.screenRate,
                                child: FlatButton(
                                  child: Text(
                                    '单次代还',
                                    style: TextStyles.text15MediumLabel,
                                  ),
                                  onPressed: () {
                                    offStage = false;
                                    delegateType = 1;
                                    setState(() {});
                                  },
                                ),
                              ),
                              Container(
                                height: 20 * Screen.screenRate,
                                width: 220 * Screen.screenRate,
                                child: FlatButton(
                                  child: Text(
                                    '精养代操',
                                    style: TextStyles.text15MediumLabel,
                                  ),
                                  onPressed: () {
                                    offStage = false;
                                    delegateType = 2;
                                    setState(() {});
                                  },
                                ),
                              ),
                              Container(
                                height: 20 * Screen.screenRate,
                                width: 220 * Screen.screenRate,
                                child: FlatButton(
                                  child: Text(
                                    '提额代操',
                                    style: TextStyles.text15MediumLabel,
                                  ),
                                  onPressed: () {
                                    offStage = false;
                                    delegateType = 3;
                                    setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 18,
                      height: 18,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        child: agreeLicense
                            ? Icon(
                                Icons.check_circle,
                                size: 18,
                                color: Theme.of(context).accentColor,
                              )
                            : Image.asset(
                                'assets/images/user/tickoff_circle_n.png',
                                width: 16,
                                height: 16,
                                fit: BoxFit.fill,
                              ),
                        onPressed: () {
                          agreeLicense = !agreeLicense;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      width: 9 * Screen.screenRate,
                    ),
                    Text(
                      '同意用户授权协议',
                      style: TextStyles.text14MediumPLabel,
                    ),
                  ],
                ),
              ),
              Container(
                width: 65,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    '常见问题',
                    style: TextStyles.text14MediumPLabel,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32 * Screen.screenRate,
          ),
          Container(
            height: 40 * Screen.screenRate,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).accentColor,
            ),
            child: FlatButton(
              child: Text(
                '立即提交',
                style: TextStyles.text18WhiteMediumLabel,
              ),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                if (!agreeLicense) {
                  importCardBloc.showToast('请先同意用户协议');
                  return;
                }
                if (accountInputCtrl.text == '') {
                  importCardBloc.showToast('${titleItems[5]}');
                  return;
                }
                if (pwdInputCtrl.text == '') {
                  importCardBloc.showToast('${titleItems[6]}');
                  return;
                }
                if (int.tryParse(AppInstance.currentUser.roleType) == 2) {
                  if (delegateType == -1) {
                    importCardBloc.showToast('请选择代管类型');
                    return;
                  }
                }

                eventBus1.fire(OpenAnimationEvent(false));
                importCardBloc.importCardInfo(accountInputCtrl.text,
                    pwdInputCtrl.text, bankCode, delegateType, widget.toUid);
              },
            ),
          ),
        ],
      ),
    );
  }
}
