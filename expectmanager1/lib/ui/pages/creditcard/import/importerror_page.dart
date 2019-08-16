import '../../../../common/component_index.dart';
import '../../../../ui/pages/page_index.dart';

class ImportErrorPage extends StatelessWidget {
  ImportErrorPage(this.title);
  final String title;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            '导入$title',
            style: TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          child: Text(
            '该银行处于维护中...',
            style: TextStyles.text20MediumLabel,
          ),
        ));
  }
}
