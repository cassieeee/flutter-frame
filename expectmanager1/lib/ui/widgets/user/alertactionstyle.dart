import '../../../common/component_index.dart';

void showAlertActionStyle(BuildContext context, String btn1Title,
    String btn2Title, VoidCallback btn1Action,
    {VoidCallback btn2Action}) {
  if (btn2Action == null) {
    btn2Action = () {
      Navigator.pop(context);
    };
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 101 + Screen.bottomSafeHeight,
        color: Colours.white_color,
        margin: EdgeInsets.only(
          top: Screen.height -
              Screen.bottomSafeHeight -
              Screen.topSafeHeight -
              101,
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.white,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                child: Text(
                  btn1Title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeights.medium,
                    color: Colors.red,
                  ),
                ),
                onPressed: btn1Action,
              ),
            ),
            Container(
              height: 1,
              color: Colours.background_color2,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.white,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                child: Text(
                  btn2Title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeights.medium,
                    color: Colors.black,
                  ),
                ),
                onPressed: btn2Action,
              ),
            ),
          ],
        ),
      );
    },
  );
}
