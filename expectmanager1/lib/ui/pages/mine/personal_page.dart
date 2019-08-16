import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class PersonalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonalBloc>(
      bloc: PersonalBloc(),
      child: Scaffold(
        backgroundColor: Colours.background_color,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Color(0xFF0DAEFF),
          title: Text(
            '个人信息',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            PersonalHead(),
            PersonalMiddle(),
            PersonalBottom(),
          ],
        ),
      ),
    );
  }
}
