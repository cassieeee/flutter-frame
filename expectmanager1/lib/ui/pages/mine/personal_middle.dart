import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class PersonalMiddle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonalMiddleState();
}

class PersonalMiddleState extends State<PersonalMiddle> {
  final List<String> iconItems = <String>[
    'gender_icon.png',
    'birthday_icon.png',
    'location_icon.png',
    'addday_icon.png',
    'auth_icon.png',
    'phonenum_icon.png',
    'uid_icon.png',
    'role_icon.png',
    'changepwd_icon.png',
  ];

  final List<String> titleItems = <String>[
    '性别',
    '出生日期',
    '所在地',
    '加入日期',
    '实名认证',
    '手机号',
    'UID',
    '角色',
    AppInstance.currentUser.isFirstLogin == '1' ? '设置登录密码' : '修改登录密码',
  ];

  List<String> valueItems = <String>[
    '男',
    '1995-06-23',
    '福建福州',
    '2019-03-23',
    '已实名',
    '13454452541',
    '4455',
    '普通用户',
    '                                            ',
  ];

  bool showGenderDel = false;
  List valueLists = List();
  bool isChange = false;

  Widget build(BuildContext context) {
    final PersonalBloc personalBloc = BlocProvider.of<PersonalBloc>(context);
    personalBloc.bloccontext = context;
    UserInfoModel userInfoModel;
    return StreamBuilder(
      stream: personalBloc.getUserInfoStream,
      builder: (BuildContext context, AsyncSnapshot<UserInfoModel> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        if (valueLists.length == 0 || isChange) {
          valueLists = List();
          userInfoModel = snapshot.data;
          valueLists.add(userInfoModel.sex);
          valueLists.add(userInfoModel.birthDay);
          valueLists.add('${userInfoModel.provinces}${userInfoModel.city}');
          valueLists.add(userInfoModel.createTime);
          valueLists.add(userInfoModel.isCertification == 1 ? '已实名' : '未认证');
          valueLists.add('${userInfoModel.phone}');
          valueLists.add('${userInfoModel.uid}');
          valueLists.add(userInfoModel.roleType == 4
              ? '资金方'
              : userInfoModel.roleType == 2 ? '管理师' : '普通用户');
          valueLists.add('                                            ');
        }
        return Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height -
                  195 -
                  90 -
                  Screen.bottomSafeHeight,
              child: ListView.builder(
                physics: new BouncingScrollPhysics(),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height:
                        (index != 3 && index != 6 && index != 7 && index != 8)
                            ? 50
                            : 58,
                    color: Colours.white_color,
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 16,
                            ),
                            Image.asset(
                                'assets/images/user/${iconItems[index]}',
                                width: 17,
                                height: 17),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                titleItems[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colours.text_placehold2,
                                  fontWeight: FontWeights.medium,
                                ),
                              ),
                            ),
                            Container(
                              height: (index != 3 &&
                                      index != 6 &&
                                      index != 7 &&
                                      index != 8)
                                  ? 49
                                  : 48,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                child: Container(
                                  width: 160 * Screen.screenRate,
                                  child: Text(
                                    valueLists[index],
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colours.text_placehold2,
                                      fontWeight: FontWeights.medium,
                                    ),
                                  ),
                                ),
                                onTap: (index != 6)
                                    ? () async {
                                        if (index == 0) {
                                          showGenderDel = !showGenderDel;
                                          setState(() {});
                                        } else if (index == 1) {
                                          showDatePicker(
                                            context: context,
                                            initialDate: new DateTime.now(),
                                            firstDate: new DateTime.utc(1900),
                                            lastDate: new DateTime.now(),
                                          ).then((DateTime val) {
                                            print(val);
                                            if (val != null) {
                                              isChange = true;
                                              personalBloc.editUserInfoAction(
                                                  birthDay: DateUtil
                                                      .getDateStrByDateTime(val,
                                                          format: DateFormat
                                                              .YEAR_MONTH_DAY));
                                            }
                                          }).catchError((err) {
                                            print(err);
                                          });
                                        } else if (index == 2) {
                                          Result result =
                                              await CityPickers.showCityPicker(
                                            height: 250,
                                            locationCode: '350000',
                                            context: context,
                                          );
                                          print(result);
                                          if (result != null) {
                                            isChange = true;
                                            personalBloc.editUserInfoAction(
                                                provinces: result.provinceName,
                                                city: result.cityName);
                                          }
                                        } else if (index == 4 &&
                                            valueLists[index] == "未认证") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  IdAuthPage(2),
                                            ),
                                          );
                                        } else if (index == 5) {
                                          NavigatorUtil.pushPage(
                                              context, ChangePhonePage());
                                        } else if (index == 7) {
                                          NavigatorUtil.pushPage(
                                              context, RoleChangePage());
                                        } else if (index == 8) {
                                          if (AppInstance
                                                  .currentUser.isFirstLogin ==
                                              '1') {
                                            NavigatorUtil.pushPage(
                                                context, SetPwdPage(2));
                                          } else {
                                            NavigatorUtil.pushPage(
                                                context, ChangePwdPage());
                                          }
                                        }
                                      }
                                    : null,
                              ),
                            ),
                            (index != 4 && index != 3 && index != 6) ||
                                    (index == 4 && valueLists[index] == "未认证")
                                ? SizedBox(
                                    width: 5,
                                  )
                                : Container(),
                            (index != 4 && index != 3 && index != 6) ||
                                    (index == 4 && valueLists[index] == "未认证")
                                ? Image.asset(
                                    'assets/images/user/arrow_sdown.png',
                                    width: 6,
                                    height: 3,
                                  )
                                : Container(),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                        (index != 3 && index != 6 && index != 7 && index != 8)
                            ? Container(
                                margin: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                ),
                                height: 1,
                                color: Colours.background_color2,
                              )
                            : Container(
                                height: 10,
                                color: Colours.background_color,
                              ),
                      ],
                    ),
                  );
                },
              ),
            ),
            //性别选择
            showGenderDel
                ? Positioned(
                    top: 41,
                    right: 16,
                    child: AnimatedOpacity(
                      duration: Duration(
                        milliseconds: 300,
                      ),
                      opacity: 1.0,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Container(
                          width: 121,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/user/gendersel_bg.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: valueLists.length > 0
                              ? Text(valueLists[0] == '女' ? '男' : '女',
                                  style: TextStyles.text15MediumLabel)
                              : Container(),
                        ),
                        onPressed: () {
                          showGenderDel = false;
                          setState(() {});
                          // valueLists[0] =
                          //     valueLists[0] == '女' ? '男' : '女';
                          isChange = true;
                          personalBloc.editUserInfoAction(
                              sex: valueLists[0] == '女' ? '男' : '女');
                        },
                      ),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
