import 'package:flutter/rendering.dart';

import '../../../common/component_index.dart';

import 'package:flare_flutter/flare_actor.dart';

class OnlineDiagnoseHead extends StatelessWidget {
  OnlineDiagnoseHead(this.cardItem, this.backType);
  final DiagnoseCardItem cardItem;
  final int backType;
  @override
  Widget build(BuildContext context) {
    final CardOnlineDiagnoseBloc cardOnlineDiagnoseBloc =
        BlocProvider.of<CardOnlineDiagnoseBloc>(context);
    cardOnlineDiagnoseBloc.bloccontext = context;
    cardOnlineDiagnoseBloc.id = cardItem.id;
    cardOnlineDiagnoseBloc.backType = backType;
    return StreamBuilder(
        stream: cardOnlineDiagnoseBloc.cardDiagnoseStream,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) cardOnlineDiagnoseBloc.startDiagnose();
          return Column(
            children: <Widget>[
              Container(
                height: 238,
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12,
                  bottom: 12,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/user/xyzd_bg1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    FlareActor(
                      "assets/animations/scanning.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: '1',
                    ),
                    Positioned(
                      left: 48,
                      top: 25,
                      child: Text(
                        cardItem.bankName != null ? '${cardItem.bankName}' : '',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colours.white_color,
                          fontWeight: FontWeights.medium,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 24,
                      right: 49,
                      child: Container(
                        width: 64,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colours.white_color,
                        ),
                        child: Container(
                          width: 33,
                          height: 33,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.5),
                            child: FadeInImage.assetNetwork(
                              placeholder:
                                  "assets/images/user/card_default.jpeg",
                              image: cardItem?.icon ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: 82,
                      child: Text(
                        cardItem.cardId != null ? '${cardItem.cardId}' : '',
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.yellow,
                          fontWeight: FontWeights.medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          child: FlareActor(
                            "assets/animations/chrysanthemum.flr",
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: 'loading',
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          child: Text(
                            snapshot.hasData
                                ? '${snapshot.data['progressNum']}%'
                                : '',
                            style: TextStyles.text20BlueMediumLabel,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            '拼命诊断中......',
                            style: TextStyles.text16BlueMediumLabel,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 1,
                            color: Colours.background_color2,
                          ),
                          snapshot.hasData
                              ? Container(
                                  height: Screen.height -
                                      404 -
                                      Screen.navigationBarHeight -
                                      22,
                                  child: ListView(
                                    children: buildDiagnoseInfo(
                                        snapshot.data['noteList']),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  List<Widget> buildDiagnoseInfo(List<String> strList) {
    List<Widget> diagnoseInfo = List<Widget>();
    for (int i = 0; i < strList.length; i++) {
      Widget wd = Column(
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Text(
            '${strList[i]}',
            style: TextStyles.text14MediumLabel,
          ),
        ],
      );
      diagnoseInfo.add(wd);
    }
    return diagnoseInfo;
  }
}
