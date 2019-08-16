import '../../../common/component_index.dart';
// import '../../../../ui/pages/page_index.dart';

class CreditCardMiddle extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TabBar(
        labelStyle: TextStyles.text15MediumLabel,
        labelColor: Colours.blue_color,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colours.text_lable,
        indicatorColor: Colours.blue_color,
        indicatorWeight: 2,
        tabs: <Widget>[
          Tab(
            child: Text("未托管(1)"),
          ),
          Tab(
            child: Text("已托管(0)"),
          ),
        ],
      ),
    );
  }
}
