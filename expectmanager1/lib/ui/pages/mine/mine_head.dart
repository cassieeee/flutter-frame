import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class MineHead extends StatelessWidget {
  Widget build(BuildContext context) {
    final MineBloc mineBloc = BlocProvider.of<MineBloc>(context);
    mineBloc.bloccontext = context;
    return StreamBuilder(
        stream: mineBloc.mineStream,
        builder: (BuildContext context, AsyncSnapshot<UserInfoModel> snapshot) {
          if (!snapshot.hasData) {
            Future.delayed(new Duration(milliseconds: 10)).then((_) {
              mineBloc.getInfos();
            });
            return Container();
          }
          UserInfoModel userInfoModel = snapshot.data;
          return Container(
            height: 248,
            color: Colours.blue_color,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 80,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          // width: 241,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                width: 80,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        "assets/images/user/head_default.jpeg",
                                    image: userInfoModel.icon,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 9,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        '${userInfoModel.name ?? userInfoModel.uid}',
                                        style:
                                            TextStyles.text18WhiteMediumLabel,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 68,
                                        height: 22,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          color: Color.fromARGB(30, 0, 0, 0),
                                        ),
                                        child: Text(
                                          '普通用户',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colours.background_color,
                                            fontWeight: FontWeights.medium,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: 88,
                                    height: 18,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: Color(0xFF28BBFF),
                                    ),
                                    child: Text(
                                      userInfoModel.phone != null
                                          ? '${userInfoModel.phone}'
                                          : '',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFFFFFEFE),
                                        fontWeight: FontWeights.medium,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                  'assets/images/user/arrowmore_wbig.png',
                                  width: 10,
                                  height: 17),
                              SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => PersonalPage(),
                        ),
                      ).then((_) {
                        final ApplicationBloc applicationBloc =
                            BlocProvider.of<ApplicationBloc>(context);
                        if (applicationBloc.personalBackType == 1) {
                          Future.delayed(new Duration(milliseconds: 10))
                              .then((_) {
                            mineBloc.getUserInfoAction();
                            applicationBloc.personalBackType = 0;
                          });
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        '我的余额(元)',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colours.background_color,
                            fontWeight: FontWeights.medium),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${userInfoModel.money ?? 0}',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colours.background_color,
                            fontWeight: FontWeights.medium),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 30,
                  color: Color(0xFF0081DC),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        '当月预估扣费金额',
                        style: TextStyle(
                          color: Colours.background_color,
                          fontSize: 12,
                          fontWeight: FontWeights.medium,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
