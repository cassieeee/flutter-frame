import '../../../common/component_index.dart';

class IdAuthPage extends StatefulWidget {
  IdAuthPage(this.fromPageType);
  final int fromPageType;
  @override
  State<StatefulWidget> createState() => IdAuthPageState();
}

class IdAuthPageState extends State<IdAuthPage> {
  bool hideSelPicker = true;
  int selBtn;
  File frontImg;
  File backImg;
  var nameInputCtrl = TextEditingController();
  var idInputCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              '实名认证',
              style: TextStyle(fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              tooltip: '返回',
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 14),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '姓名',
                        style: TextStyles.text16MediumLabel,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colours.text_border, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: TextField(
                      controller: nameInputCtrl,
                      style: TextStyles.text15MediumLabel,
                      decoration: new InputDecoration(
                        hintText: '请输入姓名',
                        hintStyle: TextStyles.text15MediumPLabel,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '身份证号',
                        style: TextStyles.text16MediumLabel,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colours.text_border, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: TextField(
                      controller: idInputCtrl,
                      style: TextStyles.text15MediumLabel,
                      // keyboardType: TextInputType.numberWithOptions(signed: true),
                      decoration: new InputDecoration(
                        hintText: '请输入身份证号码',
                        hintStyle: TextStyles.text15MediumPLabel,
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 200),
              padding: EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 167,
                    height: 126,
                    decoration: BoxDecoration(
                      image: frontImg != null
                          ? DecorationImage(
                              image: FileImage(frontImg),
                              fit: BoxFit.contain,
                            )
                          : null,
                      border: Border(
                        top: BorderSide(color: Color(0xFFE6E6E6), width: 8),
                        left: BorderSide(color: Color(0xFFE6E6E6), width: 8),
                        bottom: BorderSide(color: Color(0xFFE6E6E6), width: 8),
                        right: BorderSide(color: Color(0xFFE6E6E6), width: 4),
                      ),
                    ),
                    child: FlatButton(
                      child: Text(
                        frontImg == null ? '点击上传身份证正面照' : "",
                        style: TextStyle(
                            fontSize: 11, color: Colours.text_placehold),
                      ),
                      onPressed: () {
                        selBtn = 1;
                        setState(() {
                          hideSelPicker = false;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 167,
                    height: 126,
                    decoration: BoxDecoration(
                      image: backImg != null
                          ? DecorationImage(
                              image: FileImage(backImg),
                              fit: BoxFit.contain,
                            )
                          : null,
                      border: Border(
                        top: BorderSide(color: Color(0xFFE6E6E6), width: 8),
                        left: BorderSide(color: Color(0xFFE6E6E6), width: 4),
                        bottom: BorderSide(color: Color(0xFFE6E6E6), width: 8),
                        right: BorderSide(color: Color(0xFFE6E6E6), width: 8),
                      ),
                    ),
                    child: FlatButton(
                      child: Text(
                        backImg == null ? '点击上传身份证反面照' : "",
                        style: TextStyle(
                            fontSize: 11, color: Colours.text_placehold),
                      ),
                      onPressed: () {
                        selBtn = 2;
                        setState(() {
                          hideSelPicker = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 250),
              padding: EdgeInsets.only(top: 100, left: 65, right: 65),
              alignment: Alignment.center,
              child: Container(
                width: 245,
                height: 40,
                child: RaisedButton(
                    textColor: Color(0xFFFFFFFF),
                    //color: Color(0xFF666666),
                    color: Theme.of(context).accentColor,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Text(
                      "提交",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      CertificateBloc certificateBloc = CertificateBloc();
                      certificateBloc.fromType = widget.fromPageType;
                      certificateBloc.bloccontext = context;
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (nameInputCtrl.text.length == 0) {
                        certificateBloc.showToast("请输入真实姓名");
                        return;
                      }
                      if (idInputCtrl.text.length == 0) {
                        certificateBloc.showToast("请输入身份证号码");
                        return;
                      }
                      if (frontImg == null) {
                        certificateBloc.showToast("请上传身份证正面照片");
                        return;
                      }
                      if (backImg == null) {
                        certificateBloc.showToast("请上传身份证反面照片");
                        return;
                      }
                      certificateBloc.userAuthAction(nameInputCtrl.text,
                          idInputCtrl.text, frontImg, backImg);
                    }),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  hideSelPicker = true;
                });
              },
              child: Offstage(
                offstage: hideSelPicker,
                child: Container(
                  width: Screen.width,
                  height: Screen.height,
                  color: Colours.transparent_80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: Screen.width,
                        height: 60,
                        color: Colours.white_color,
                        child: FlatButton(
                          child: Text(
                            "从拍照选择",
                            style: TextStyles.text18MediumLabel,
                          ),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              hideSelPicker = true;
                            });
                            var image = await ImagePicker.pickImage(
                                source: ImageSource.camera);
                            setState(() {
                              if (selBtn == 1) {
                                frontImg = image;
                              } else {
                                backImg = image;
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        width: Screen.width,
                        height: 1,
                        color: Colours.line_color,
                      ),
                      Container(
                        width: Screen.width,
                        height: 60,
                        color: Colours.white_color,
                        child: FlatButton(
                          child: Text(
                            "从相册选择",
                            style: TextStyles.text18MediumLabel,
                          ),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              hideSelPicker = true;
                            });
                            var image = await ImagePicker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              if (selBtn == 1) {
                                frontImg = image;
                              } else {
                                backImg = image;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
