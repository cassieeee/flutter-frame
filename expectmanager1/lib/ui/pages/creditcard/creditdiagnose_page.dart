import 'package:youxinbao/blocs/creditcard/creditdiagnose_bloc.dart';

import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class CreditDiagnosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreditDiagnoseBloc>(
      bloc: CreditDiagnoseBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            '信用诊断',
            style: TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: Colours.background_color,
        body: Stack(
          children: <Widget>[
            CreditDiagnoseHead(),
            CreditDiagnoseMiddle(),
            // CreditDiagnoseBottom(),
          ],
        ),
      ),
    );
  }
}
