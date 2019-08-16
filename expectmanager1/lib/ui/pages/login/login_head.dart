import '../../../common/component_index.dart';

class LoginHead extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: 145 * Screen.screenRate,
      color: Colours.blue_color,
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/images/splash/icon-1024.png',
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
