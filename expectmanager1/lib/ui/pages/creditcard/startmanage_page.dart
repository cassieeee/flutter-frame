import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class StartManagePage extends StatefulWidget {
  StartManagePage(this.cardInfo);
  final CardInfoModel cardInfo;
  @override
  State<StatefulWidget> createState() {
    return StartManagePageState(cardInfo);
  }
}

class StartManagePageState extends State<StartManagePage> {
  StartManagePageState(this.cardInfo);
  final CardInfoModel cardInfo;
  bool offStage = false;
  File reportImg;
  String picStr = '添加图片';

  IconData add_photo_alternate1 = IconData(0xe43e, fontFamily: 'MaterialIcons');

  int delegateType = 1;
  List<bool> selCardList = List<bool>();
  List<num> selCardIdList = List<num>();
  double selTotalMoney = 0;
  double selPayTotalMoney = 0;
  List<dynamic> needList = List<dynamic>();
  TextEditingController mangerNumCtl = TextEditingController();
  StartManagerBloc startManagerBloc = StartManagerBloc();

  @override
  Widget build(BuildContext context) {
    startManagerBloc.bloccontext = context;
    needList =
        cardInfo.cardList.where((model) => model.isDelegated == 0).toList();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            '发起托管',
            style: TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                buildHead(),
                buildMiddle(),
                //托管类型下拉列表
                Positioned(
                  child: Offstage(
                    offstage: !offStage,
                    child: Container(
                      width: 323,
                      height: 111,
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
                            height: 20,
                            width: 220,
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
                            height: 20,
                            width: 220,
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
                            height: 20,
                            width: 220,
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
                  top: 120,
                  right: 35,
                ),
                buildBottom(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildHead() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 10,
            color: Color(0xFFF2F2F2),
          ),
          Container(
            height: 118,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '输入管理师账号',
                      style: TextStyles.text16MediumLabel,
                    ),
                    Container(
                      width: 217,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colours.blue_color,
                          width: 1.0,
                        ),
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(5.0),
                        ),
                      ),
                      child: TextField(
                        controller: mangerNumCtl,
                        keyboardType:
                            TextInputType.numberWithOptions(signed: true),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11),
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          hintText: "请输入管理师账号",
                          hintStyle: TextStyles.text15MediumPPLabel,
                          contentPadding: EdgeInsets.all(10.0),
                          // fillColor: Colors.white, filled: true,
                          // 以下属性可用来去除TextField的边框
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: TextStyles.text15MediumLabel,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '请选择托管类型',
                      style: TextStyles.text16MediumLabel,
                    ),
                    Container(
                      width: 217,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colours.blue_color,
                          width: 1.0,
                        ),
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(5.0),
                        ),
                      ),
                      child: FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                delegateType == 1
                                    ? '单次代还'
                                    : delegateType == 2 ? '精养代操' : '提额代操',
                                textAlign: TextAlign.center,
                                style: TextStyles.text15MediumLabel,
                              ),
                            ),
                            Icon(
                              offStage
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 30,
                              color: Colours.text_placehold,
                            ),
                            SizedBox(
                              width: 0,
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
              ],
            ),
          ),
          Container(
            height: 10,
            color: Color(0xFFF2F2F2),
          ),
        ],
      ),
    );
  }

  Widget buildMiddle() {
    return Container(
      margin: EdgeInsets.only(
        top: 138,
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 17,
              ),
              Text(
                '请选择托管卡片',
                style: TextStyles.text16MediumLabel,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                '代管卡数(张)',
                style: TextStyle(
                  color: Colours.blue_color,
                  fontSize: 14,
                  fontWeight: FontWeights.medium,
                ),
              ),
              Text(
                '代管总金额(元)',
                style: TextStyle(
                  color: Colours.blue_color,
                  fontSize: 14,
                  fontWeight: FontWeights.medium,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 83,
                child: Text(
                  '${selCardIdList.length}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colours.text_lable,
                    fontSize: 14,
                    fontWeight: FontWeights.medium,
                  ),
                ),
              ),
              Container(
                width: 98,
                child: Text(
                  selTotalMoney < 0.001
                      ? '0'
                      : '${selTotalMoney.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colours.text_lable,
                    fontSize: 14,
                    fontWeight: FontWeights.medium,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 343,
            height: 1,
            color: Colours.blue_color,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                if (selCardList.length == 0)
                  for (int i = 0; i < needList.length; i++) {
                    selCardList.add(false);
                  }
                CardItemModel cardItemModel = needList[index];
                return Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            if (cardItemModel.isDiagnose == 0) {
                              showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return diagnoseAlert(index);
                                },
                              );
                            } else {
                              selCardList[index] = !selCardList[index];
                              if (selCardList[index]) {
                                selTotalMoney +=
                                    cardItemModel.usableMoney.toDouble();
                                selPayTotalMoney +=
                                    cardItemModel.accLimitRepay.toDouble();
                                selCardIdList.add(cardItemModel.id);
                              } else {
                                selTotalMoney -=
                                    cardItemModel.usableMoney.toDouble();
                                selPayTotalMoney -=
                                    cardItemModel.accLimitRepay.toDouble();
                                selCardIdList.remove(cardItemModel.id);
                              }
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colours.gray_66,
                                width: 1,
                              ),
                            ),
                            child: selCardList[index]
                                ? Image.asset(
                                    'assets/images/user/tickoffblue_icon.png',
                                    width: 15,
                                    height: 10)
                                : null,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage.assetNetwork(
                              placeholder:
                                  "assets/images/user/card_default.jpeg",
                              image: cardItemModel.icon,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 110,
                          child: Row(
                            children: <Widget>[
                              Text(
                                cardItemModel.bankName != null
                                    ? '${cardItemModel.bankName}'
                                    : '',
                                style: TextStyles.text15MediumLabel,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                cardItemModel.cardId != null
                                    ? '${cardItemModel.cardId.toString().substring(cardItemModel.cardId.toString().length - 4)}'
                                    : '',
                                style: TextStyles.text14MediumPLabel,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '代管金额',
                          style: TextStyles.text14MediumPLabel,
                        ),
                        Container(
                          width: 70,
                          child: Text(
                            cardItemModel.usableMoney != null
                                ? '${cardItemModel.usableMoney}'
                                : '',
                            textAlign: TextAlign.center,
                            style: TextStyles.text14MediumPLabel,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 40,
                      ),
                      height: 10,
                    ),
                    cardItemModel.isDiagnose == 1
                        ? Container()
                        : Positioned(
                            top: 32,
                            right: 25,
                            child: Container(
                              width: 60,
                              height: 18,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  color: Colours.orange_color,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                '未诊断',
                                style: TextStyles.text12OrangeMediumLabel,
                              ),
                            ),
                          ),
                  ],
                );
              },
              itemCount: needList.length,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '预计还款总费用(每期)：',
                style: TextStyles.text15MediumLabel,
              ),
              Text(
                selPayTotalMoney < 0.001
                    ? '0'
                    : '${selPayTotalMoney.toStringAsFixed(2)}元',
                style: TextStyle(
                  fontSize: Dimens.font_sp15,
                  color: Colors.red,
                  fontWeight: FontWeights.medium,
                ),
              ),
              SizedBox(
                width: 22,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 10,
            color: Color(0xFFF2F2F2),
          ),
        ],
      ),
    );
  }

  Widget buildBottom() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 455),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Text(
            '备注(可上传征信报告增加通过率)',
            style: TextStyles.text15MediumLabel,
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 150,
            height: 150,
            decoration: reportImg == null
                ? BoxDecoration(
                    color: Colours.background_color,
                    borderRadius: BorderRadius.circular(5),
                  )
                : BoxDecoration(
                    // borderRadius: BorderRadius.all(const Radic),
                    image: DecorationImage(
                      image: FileImage(reportImg),
                      fit: BoxFit.fill,
                    ),
                  ),
            child: FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    add_photo_alternate1,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    picStr,
                    style: TextStyles.text15MediumPLabel,
                  ),
                ],
              ),
              onPressed: () {
                showAlertActionStyle(context, '从拍照选择', '从相册选择', () async {
                  FocusScope.of(context).requestFocus(FocusNode());

                  var image =
                      await ImagePicker.pickImage(source: ImageSource.camera);
                  Navigator.pop(context);
                  setState(() {
                    if (image != null) {
                      picStr = "";
                      add_photo_alternate1 = null;
                      reportImg = image;
                    }
                  });
                }, btn2Action: () async {
                  FocusScope.of(context).requestFocus(FocusNode());

                  var image =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  Navigator.pop(context);
                  setState(() {
                    if (image != null) {
                      picStr = "";
                      add_photo_alternate1 = null;
                      reportImg = image;
                    }
                  });
                });
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 343,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colours.blue_color,
            ),
            child: FlatButton(
              child: Text(
                '提交申请',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeights.medium,
                ),
              ),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());

                if (mangerNumCtl.text.length == 0) {
                  startManagerBloc.showToast('请输入管理师账号');
                  return;
                }
                if (selCardIdList.length == 0) {
                  startManagerBloc.showToast('请选择代管卡片');
                  return;
                }

                startManagerBloc.startMangerAction(mangerNumCtl.text,
                    selCardIdList.join(','), delegateType, reportImg);
              },
            ),
          ),
          SizedBox(
            height: 200,
          ),
        ],
      ),
    );
  }

  Widget diagnoseAlert(int index) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 343,
            height: 153,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/user/carddiagnose_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 293,
                      ),
                      Container(
                        width: 50,
                        height: 40,
                        child: FlatButton(
                          child: Image.asset(
                              'assets/images/user/carddiagnose_close.png',
                              width: 20,
                              height: 20),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  height: 35,
                  margin: EdgeInsets.only(
                    top: 98,
                    left: 95,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.5),
                    color: Colors.white,
                  ),
                  child: FlatButton(
                    child: Text(
                      '立即诊断',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colours.blue_color,
                        fontWeight: FontWeights.medium,
                      ),
                    ),
                    onPressed: () {
                      CardItemModel cardItemModel = needList[index];
                      DiagnoseCardItem dItem = DiagnoseCardItem();
                      dItem.id = cardItemModel.id;
                      dItem.bankName = cardItemModel.bankName;
                      dItem.cardId = cardItemModel.cardId;
                      dItem.icon = cardItemModel.icon;
                      Navigator.pop(context);
                      NavigatorUtil.pushPage(
                          context, OnlineDiagnosePage(dItem, 1));
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
