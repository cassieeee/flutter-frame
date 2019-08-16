import '../../../common/component_index.dart';

class CreditDiagnoseHead extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreditDiagnoseHeadState();
}

class CreditDiagnoseHeadState extends State<CreditDiagnoseHead>
    with AutomaticKeepAliveClientMixin {
  Widget build(BuildContext context) {
    super.build(context);
    final CreditDiagnoseBloc creditDiagnoseBloc =
        BlocProvider.of<CreditDiagnoseBloc>(context);
    return StreamBuilder(
      stream: creditDiagnoseBloc.diagnoseInfoStream,
      builder:
          (BuildContext context, AsyncSnapshot<DiagnoseCardInfo> snapshot) {
        if (!snapshot.hasData) {
          Future.delayed(
            Duration(milliseconds: 10),
          ).then((_) {
            creditDiagnoseBloc.getDiagnoseCardInfo();
          });
          return Container();
        }
        return Container(
          height: 92,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Container(
                width: 45,
                height: 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22.5),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/user/head_default.jpeg",
                    image: snapshot.data.icon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                snapshot.data.account != null ? '${snapshot.data.account}' : '',
                style: TextStyles.text14MediumLabel,
              ),
              SizedBox(width: 45 * Screen.screenRate),
              Container(
                width: 170,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 21,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.5),
                            color: Color(0xFFFF7E00),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '我的卡数(张)',
                          style: TextStyles.text14MediumLabel,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 58,
                          child: Text(
                            snapshot.data.totalCardCount == null
                                ? ''
                                : '${snapshot.data.totalCardCount}',
                            textAlign: TextAlign.center,
                            style: TextStyles.text14MediumLabel,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.5),
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '当前额度(元)',
                          style: TextStyles.text14MediumLabel,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 58,
                          child: Text(
                            snapshot.data.totalAccLimit == null
                                ? ''
                                : '${snapshot.data.totalAccLimit}',
                            textAlign: TextAlign.center,
                            style: TextStyles.text14MediumLabel,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
