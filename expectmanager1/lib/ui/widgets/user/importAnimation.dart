import '../../../common/component_index.dart';

import 'package:flare_flutter/flare_actor.dart';

class OpenAnimationEvent {
  bool hideType;
  OpenAnimationEvent(this.hideType);
}

class ImportAnimationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screen.width,
      height: Screen.height,
      color: Colours.white_color,
      child: Container(
        margin: EdgeInsets.only(
          top: 50,
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: Screen.width,
                  height: Screen.width,
                  child: FlareActor(
                    "assets/animations/importCard.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: 'idle',
                  ),
                ),
                Container(
                  width: Screen.width,
                  height: Screen.width,
                  alignment: Alignment.center,
                  child: Text(
                    // snapshot.hasData ? '${snapshot.data['progressNum']}%' : '',
                    '导入中...',
                    style: TextStyles.text16BlueMediumLabel,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
