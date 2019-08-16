import '../../../common/component_index.dart';

class SetPwdHead extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      color: themeColorMap[(AppInstance.getString(Constant.KEY_THEME_COLOR))],
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/user/head_default.jpeg",
                  // image: icon,
                  image: '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
