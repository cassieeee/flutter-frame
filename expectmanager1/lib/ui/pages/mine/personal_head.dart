import '../../../common/component_index.dart';

class PersonalHead extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonalHeadState();
}

class PersonalHeadState extends State<PersonalHead> {
  File headImg;
  Widget build(BuildContext context) {
    final PersonalBloc personalBloc = BlocProvider.of<PersonalBloc>(context);
    personalBloc.bloccontext = context;
    TextEditingController nameCtl = TextEditingController();
    UserInfoModel userInfoModel;
    return StreamBuilder(
        stream: personalBloc.getUserInfoStream,
        builder: (BuildContext context, AsyncSnapshot<UserInfoModel> snapshot) {
          if (!snapshot.hasData) {
            Future.delayed(new Duration(milliseconds: 10)).then((_) {
              personalBloc.getUserInfoAction();
            });
            return Container();
          }

          if (userInfoModel == null) userInfoModel = snapshot.data;
          return Container(
            height: 131,
            color: Colours.blue_color,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    showAlertActionStyle(context, '从拍照选择', '从相册选择', () async {
                      Navigator.pop(context);
                      var image = await ImagePicker.pickImage(
                          source: ImageSource.camera);
                      if (image != null) {
                        personalBloc.editUserInfoAction(headIcon: image);
                        setState(() {
                          headImg = image;
                        });
                      }
                    }, btn2Action: () async {
                      Navigator.pop(context);
                      var image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (image != null) {
                        personalBloc.editUserInfoAction(headIcon: image);
                        setState(() {
                          headImg = image;
                        });
                      }
                    });
                  },
                  child: Container(
                    width: 68,
                    height: 68,
                    child: headImg != null
                        ? ClipOval(
                            child: Image.file(
                              headImg,
                              fit: BoxFit.cover,
                              width: 68,
                              height: 68,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(34),
                            child: FadeInImage.assetNetwork(
                              placeholder:
                                  "assets/images/user/head_default.jpeg",
                              image: userInfoModel.icon,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      width: 220 * Screen.screenRate,
                      child: Text(
                        '${userInfoModel.name ?? userInfoModel.uid}',
                        textAlign: TextAlign.center,
                        style: TextStyles.text18WhiteMediumLabel,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 5,
                      child: Container(
                        height: 17,
                        child: FlatButton(
                          child: Image.asset('assets/images/user/edit_icon.png',
                              width: 14, height: 14),
                          onPressed: () {
                            Alert(
                              context: context,
                              title: "输入昵称",
                              content: Column(
                                children: <Widget>[
                                  TextField(
                                    controller: nameCtl,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.account_circle),
                                      // labelText: '您的昵称',
                                    ),
                                  ),
                                ],
                              ),
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "确定",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  onPressed: () {
                                    if (nameCtl.text.length > 0) {
                                      Navigator.of(context).pop();
                                      personalBloc.editUserInfoAction(
                                          name: nameCtl.text);
                                      userInfoModel.name = nameCtl.text;
                                      setState(() {});
                                    }
                                  },
                                  width: 120,
                                ),
                              ],
                            ).show();
                          },
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
