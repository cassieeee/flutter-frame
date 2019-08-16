import '../../../common/component_index.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class OrdinalComboBarLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  OrdinalComboBarLineChart(this.seriesList, {this.animate});

  factory OrdinalComboBarLineChart.withSampleData() {
    return new OrdinalComboBarLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.OrdinalComboChart(seriesList,
        animate: animate,
        // Configure the default renderer as a bar renderer.
        defaultRenderer: new charts.BarRendererConfig(
            groupingType: charts.BarGroupingType.grouped),
        // Custom renderer configuration for the line series. This will be used for
        // any series that does not define a rendererIdKey.
        customSeriesRenderers: [
          new charts.LineRendererConfig(
              // ID used to link series to this renderer.
              customRendererId: 'customLine')
        ]);
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalData, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalData('7月', 5),
      new OrdinalData('8月', 25),
      new OrdinalData('9月', 100),
      new OrdinalData('10月', 75),
    ];

    final tableSalesData = [
      new OrdinalData('7月', 5),
      new OrdinalData('8月', 25),
      new OrdinalData('9月', 100),
      new OrdinalData('10月', 75),
    ];

    final mobileSalesData = [
      new OrdinalData('7月', 10),
      new OrdinalData('8月', 50),
      new OrdinalData('9月', 200),
      new OrdinalData('10月', 150),
    ];

    return [
      new charts.Series<OrdinalData, String>(
          id: 'Desktop',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (OrdinalData sales, _) => sales.year,
          measureFn: (OrdinalData sales, _) => sales.sales,
          data: desktopSalesData),
      new charts.Series<OrdinalData, String>(
          id: 'Tablet',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (OrdinalData sales, _) => sales.year,
          measureFn: (OrdinalData sales, _) => sales.sales,
          data: tableSalesData),
      new charts.Series<OrdinalData, String>(
          id: 'Mobile ',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (OrdinalData sales, _) => sales.year,
          measureFn: (OrdinalData sales, _) => sales.sales,
          data: mobileSalesData)
        // Configure our custom line renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalData {
  final String year;
  final int sales;

  OrdinalData(this.year, this.sales);
}

class ConsumeDiagnoseMiddle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CardDiagnoseBloc cardDiagnoseBloc =
        BlocProvider.of<CardDiagnoseBloc>(context);
    return StreamBuilder(
        stream: cardDiagnoseBloc.cardDiagnoseStream,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) return Container();
          Map consumption = snapshot.data['consumption'];
          List bill = snapshot.data['bill'];
          return Column(
            children: <Widget>[
              Container(
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 58,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 10,
                      ),
                      color: Color(0x300DAEFF),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '每月支付方式：',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '一般',
                                style: TextStyles.text15RedMediumLabel,
                              ),
                            ],
                          ),
                          Text(
                            '当前可能存在：快进快出套现的消费行为，建议改善此消费方式。',
                            style: TextStyles.text12MediumPPLabel,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 48,
                      color: Colours.white_color,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 10,
                            height: 10,
                            color: Colours.blue_color,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '电子支付(笔)',
                            style: TextStyles.text12MediumLabel,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'POS机支付(笔)',
                            style: TextStyles.text12MediumLabel,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 3,
                            height: 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.5),
                              color: Colors.purple,
                            ),
                          ),
                          Container(
                            width: 10,
                            height: 1,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '其他支付(笔)',
                            style: TextStyles.text12MediumLabel,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 319,
                      height: 198,
                      color: Colours.white_color,
                      child: OrdinalComboBarLineChart.withSampleData(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          '每月详细数据',
                          style: TextStyles.text15MediumLabel,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 12,
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 400,
                            child: ListView.separated(
                              itemCount: bill.length,
                              // physics:
                              //     new NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                Map billItem = bill[index];
                                return ExpansionTile(
                                  initiallyExpanded: index == 0,
                                  leading: Text(
                                    '${billItem['year']}年${billItem['month']}月份',
                                    style: TextStyles.text14MediumLabel,
                                  ),
                                  trailing: Container(
                                    width: 150,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '共计消费：',
                                          style: TextStyles.text14MediumLabel,
                                        ),
                                        Text(
                                          '${billItem['money']}',
                                          style:
                                              TextStyles.text14RedMediumLabel,
                                        ),
                                        Text(
                                          '元',
                                          style: TextStyles.text14MediumLabel,
                                        ),
                                      ],
                                    ),
                                  ),
                                  children: <Widget>[
                                    Container(
                                      height: 101,
                                      padding: EdgeInsets.only(
                                        left: 12,
                                        right: 16,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0x300DAEFF),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            '消费共${billItem['count']}笔，电子支付${billItem['dzpaycount']}笔，POS机支付${billItem['pospaycount']}笔，其他支付${billItem['othercount']}笔',
                                            style: TextStyles.text15MediumLabel,
                                          ),
                                          Text(
                                            '5000元以上消费${billItem['count3']}笔，1000-4999元消费${billItem['count2']}笔，小于1000元消费${billItem['count1']}笔',
                                            style:
                                                TextStyles.text12MediumPPLabel,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  title: null,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Divider(),
                            ),
                          ),
                          Container(
                            height: 36,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '提额建议：显示银行喜欢的消费笔数。',
                              style: TextStyles.text12MediumPPLabel,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 44,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15,
                          ),
                          Image.asset('assets/images/user/dqyhte_icon.png',width: 22,height: 15),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            '交易周期及月均数据',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeights.medium,
                              color: Colours.blue_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 39,
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '统计周期',
                            style: TextStyles.text15MediumLabel,
                          ),
                          Text(
                            '交易金额(元)',
                            style: TextStyles.text15MediumLabel,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 111,
                      color: Color(0x300DAEFF),
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '近1个月',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '近3个月',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '近6个月',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '近12个月',
                                style: TextStyles.text15MediumLabel,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0x700DAEFF),
                                    ),
                                  ),
                                  Container(
                                    width: consumption['paymode']['monthray1']['count']/consumption['paymode']['monthray12']['count']*120,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xFF0DAEFF),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0x700DCFFF),
                                    ),
                                  ),
                                  Container(
                                    width: consumption['paymode']['monthray3']['count']/consumption['paymode']['monthray12']['count']*120,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xFF0DCFFF),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0x70730DFF),
                                    ),
                                  ),
                                  Container(
                                    width: consumption['paymode']['monthray6']['count']/consumption['paymode']['monthray12']['count']*120,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xFF730DFF),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0x70FFCF0D),
                                    ),
                                  ),
                                  Container(
                                    width: consumption['paymode']['monthray12']['count']/consumption['paymode']['monthray12']['count']*120,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xFFFFCF0D),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${consumption['paymode']['monthray1']['count']}笔',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['monthray3']['count']}笔',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['monthray6']['count']}笔',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['monthray12']['count']}笔',
                                style: TextStyles.text15MediumLabel,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                '${consumption['paymode']['monthray1']['money']}',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['monthray3']['money']}',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['monthray6']['money']}',
                                style: TextStyles.text15MediumLabel,
                              ),
                              Text(
                                '${consumption['paymode']['monthray12']['money']}',
                                style: TextStyles.text15MediumLabel,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 15, bottom: 12),
                      height: 106,
                      color: Colours.white_color,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: 166,
                            height: 79,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colours.blue_color,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: 47,
                                  height: 55,
                                  child: Image.asset(
                                      'assets/images/user/consumecount_img.png',width: 47,height: 55),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '每月均消费笔数',
                                      style: TextStyles.text12WihteMediumLabel,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${consumption['paymode']['average12']['count']}笔',
                                      style: TextStyles.text15WhiteMediumLabel,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 166,
                            height: 79,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colours.blue_color,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: 47,
                                  height: 55,
                                  child: Image.asset(
                                      'assets/images/user/consumemoney_img.png',width: 47,height: 55),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '每月均消费金额',
                                      style: TextStyles.text12WihteMediumLabel,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${consumption['paymode']['average12']['money']}元',
                                      style: TextStyles.text15WhiteMediumLabel,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 44,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15,
                          ),
                          Image.asset('assets/images/user/dqyhte_icon.png',width: 22,height: 15),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            '交易地区分析',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeights.medium,
                              color: Colours.blue_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 201,
                      color: Color(0x300DAEFF),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    '消费${consumption['region'][0]['paycount']}笔',
                                    style: TextStyles.text12MediumLabel,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Image.asset(
                                      'assets/images/user/region_no1.png',width: 52,height: 106),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${consumption['region'][0]['title']}',
                                    style: TextStyles.text15MediumLabel,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '消费${consumption['region'][1]['paycount']}笔',
                                    style: TextStyles.text12MediumLabel,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Image.asset(
                                      'assets/images/user/region_no2.png',width: 52,height: 81),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${consumption['region'][1]['title']}',
                                    style: TextStyles.text15MediumLabel,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '消费${consumption['region'][2]['paycount']}笔',
                                    style: TextStyles.text12MediumLabel,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Image.asset(
                                      'assets/images/user/region_no3.png',width: 52,height: 61),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${consumption['region'][2]['title']}',
                                    style: TextStyles.text15MediumLabel,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                '管理师建议：',
                                style: TextStyles.text12MediumPPLabel,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
