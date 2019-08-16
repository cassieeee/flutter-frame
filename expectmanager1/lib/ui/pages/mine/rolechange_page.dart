import '../../../common/component_index.dart';

class RoleChangePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RoleChangePageState();
}

class RoleChangePageState extends State<RoleChangePage> {
  @override
  void initState() {
    // if (AppInstance.currentUser.privilegeList.contains(2)) {
    //   AppInstance.putInt('upgradeM', 2);
    // }
    // if (AppInstance.currentUser.privilegeList.contains(4)) {
    //   AppInstance.putInt('upgradeC', 2);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(AppInstance.getInt('upgradeC'));
    RoleChangeBloc roleChangeBloc = RoleChangeBloc();
    roleChangeBloc.bloccontext = context;
    return StreamBuilder(
        stream: roleChangeBloc.editUserInfoStream,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.data == 1) {
            Navigator.pushReplacementNamed(context, '/splash');
            return Container();
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Theme.of(context).accentColor,
              title: Text(
                '切换角色',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  color: Colours.background_color2,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(0),
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 65,
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 152,
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          width: 70,
                                          child: Text(
                                            index == 2
                                                ? '资金方'
                                                : index == 1 ? '管理师' : '普通用户',
                                            style: TextStyles.text16MediumLabel,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  ((index == 2 &&
                                              AppInstance
                                                  .currentUser.privilegeList
                                                  .contains(4)) ||
                                          AppInstance.currentUser.privilegeList
                                              .contains(index + 1))
                                      ? Container(
                                          width: 100,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: ((index == 2 &&
                                                          int.tryParse(AppInstance
                                                                  .currentUser
                                                                  .roleType) ==
                                                              4) ||
                                                      int.tryParse(AppInstance
                                                              .currentUser
                                                              .roleType) ==
                                                          index + 1)
                                                  ? Colours.gray_cc
                                                  : Theme.of(context)
                                                      .accentColor),
                                          child: FlatButton(
                                            padding: EdgeInsets.all(0),
                                            child: Text(
                                              '切换',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeights.medium),
                                            ),
                                            onPressed: ((index == 2 &&
                                                        int.tryParse(AppInstance
                                                                .currentUser
                                                                .roleType) ==
                                                            4) ||
                                                    int.tryParse(AppInstance
                                                            .currentUser
                                                            .roleType) ==
                                                        index + 1)
                                                ? null
                                                : () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          width: 250,
                                                          height: 154,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 280,
                                                          ),
                                                          child: Column(
                                                            children: <Widget>[
                                                              Container(
                                                                width: 250,
                                                                height: 50,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5),
                                                                  ),
                                                                  color: Theme.of(
                                                                          context)
                                                                      .accentColor,
                                                                ),
                                                                child: Text(
                                                                  '是否切换',
                                                                  style: TextStyles
                                                                      .text18WhiteMediumLabel,
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 250,
                                                                height: 104,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            5),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            5),
                                                                  ),
                                                                  color: Colours
                                                                      .white_color,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      width:
                                                                          115,
                                                                      height:
                                                                          44,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: Colours
                                                                            .background_color2,
                                                                      ),
                                                                      child:
                                                                          FlatButton(
                                                                        padding:
                                                                            EdgeInsets.all(0),
                                                                        child: Text(
                                                                            '取消',
                                                                            style:
                                                                                TextStyles.text16WhiteMediumLabel),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          115,
                                                                      height:
                                                                          44,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      child:
                                                                          FlatButton(
                                                                        padding:
                                                                            EdgeInsets.all(0),
                                                                        child: Text(
                                                                            '确定',
                                                                            style:
                                                                                TextStyles.text16WhiteMediumLabel),
                                                                        onPressed:
                                                                            () {
                                                                          roleChangeBloc.editUserInfoAction(
                                                                              roleType: index == 2 ? 4 : index == 1 ? 2 : 1);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                          ),
                                        )
                                      : Container(
                                          width: 100,
                                          height: 30,
                                          child: FlatButton(
                                            padding: EdgeInsets.all(0),
                                            child: Text(
                                              (index == 1 &&
                                                      AppInstance.getInt(
                                                              'upgradeM') ==
                                                          0)
                                                  ? '升级为管理师'
                                                  : (index == 1 &&
                                                          AppInstance.getInt(
                                                                  'upgradeM') ==
                                                              1)
                                                      ? '申请中'
                                                      : (index == 2 &&
                                                              AppInstance.getInt(
                                                                      'upgradeC') ==
                                                                  0)
                                                          ? '升级为资金方'
                                                          : (index == 2 &&
                                                                  AppInstance.getInt(
                                                                          'upgradeC') ==
                                                                      1)
                                                              ? '申请中'
                                                              : '普通用户',
                                              style: TextStyles
                                                  .text14BlueMediumLabel,
                                            ),
                                            onPressed: () {
                                              roleChangeBloc
                                                  .upgradeUser(index == 1
                                                      ? 2
                                                      : index == 2 ? 4 : 1)
                                                  .then((_) {
                                                setState(() {});
                                              });
                                            },
                                          ),
                                        ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 1,
                                width: 343,
                                color: Colours.background_color2,
                              ),
                            ],
                          ));
                    },
                    itemCount: 3,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
