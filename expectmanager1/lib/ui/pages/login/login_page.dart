import 'package:youxinbao/blocs/bloc_provider.dart';

import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colours.blue_color,
        title: Text(
          '登录',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: BlocProvider<LoginBloc>(
        bloc: LoginBloc(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              LoginHead(),
              LoginMiddle(),
            ],
          ),
        ),
      ),
    );
  }
}
