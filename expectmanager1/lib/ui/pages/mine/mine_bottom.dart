import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class MineBottom extends StatelessWidget {
  Widget build(BuildContext context) {
    final MineBloc mineBloc = BlocProvider.of<MineBloc>(context);
    mineBloc.bloccontext = context;
    return StreamBuilder(
        stream: mineBloc.myMasterStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          List<Map<String, dynamic>> masterList = snapshot.data;
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 10,
                  color: Colours.background_color,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 17,
                    ),
                    Expanded(
                      child: Text(
                        '我的管理师',
                        style: TextStyles.text16MediumLabel,
                      ),
                    ),
                    Container(
                      width: 25,
                      height: 20,
                      margin: EdgeInsets.only(bottom: 10),
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Icon(Icons.arrow_drop_down),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
                Container(
                  height: Screen.height -
                      Screen.navigationBarHeight -
                      336 -
                      Screen.bottomTabBarHeight,
                  padding: EdgeInsets.only(
                    top: 0,
                  ),
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: masterList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> masterItem = masterList[index];
                      return Container(
                        height: 86,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 359,
                              height: 76,
                              decoration: BoxDecoration(
                                color: Colours.white_color,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colours.background_color2,
                                    offset: Offset(1, 1),
                                    blurRadius: 1,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 13,
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            "assets/images/user/head_default.jpeg",
                                        image: masterItem['icon'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          masterItem['name'] != null
                                              ? '${masterItem['name']}'
                                              : '',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.orange,
                                            fontWeight: FontWeights.medium,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          masterItem['account'] != null
                                              ? '${masterItem['account']}'
                                              : '',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF666666),
                                            fontWeight: FontWeights.medium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    padding: EdgeInsets.all(0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '查看',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF666666),
                                            fontWeight: FontWeights.medium,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Image.asset(
                                            'assets/images/user/arrowmore_small.png',
                                            width: 8,
                                            height: 13),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MyManagerPage(masterItem),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
