import '../../../common/component_index.dart';
// import '../../../ui/pages/page_index.dart';

class AddCardHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 11,left: 15,),
      height: 40,
      width: MediaQuery.of(context).size.width,
      color: Colours.background_color,
      child: Text('网银导入信用卡，安全准确！',style: TextStyles.text14MediumPLabel,),
    );
  }
}
