import '../../../common/component_index.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData(List<Map<dynamic, dynamic>> list) {
    return new SimpleBarChart(
      _createSampleData(list),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Map, String>> _createSampleData(
      List<Map<dynamic, dynamic>> dataList) {
    return [
      charts.Series<Map, String>(
        id: 'limit',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Map item, _) => '${item['year']}年${item['month']}月',
        measureFn: (Map item, _) => item['limit'],
        data: dataList,
      )
    ];
  }
}

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData(
      List<Map<dynamic, dynamic>> list) {
    return new SimpleTimeSeriesChart(
      _createSampleData(list),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Map, DateTime>> _createSampleData(
      List<Map<dynamic, dynamic>> dataList) {
    return [
      charts.Series<Map, DateTime>(
        id: 'templimit',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Map item, _) => DateTime(item['year'], item['month']),
        measureFn: (Map item, _) => item['limit'],
        data: dataList,
      )
    ];
  }
}

class LimitDiagnoseBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CardDiagnoseBloc cardDiagnoseBloc =
        BlocProvider.of<CardDiagnoseBloc>(context);
    return StreamBuilder(
        stream: cardDiagnoseBloc.cardDiagnoseStream,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) return Container();
          Map quota = snapshot.data['quota'];
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                padding: EdgeInsets.only(
                  top: 15,
                ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset('assets/images/user/dqyhte_icon.png',
                            width: 22, height: 15),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          '额度变动历史',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeights.medium,
                            color: Colours.blue_color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 0.5,
                      width: 343,
                      color: Colours.background_color2,
                    ),
                    Container(
                      width: 343,
                      height: 263,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '固定额度变动历史',
                                style: TextStyles.text15MediumLabel,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 10,
                                height: 10,
                                color: Colours.blue_color,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '提升额度',
                                style: TextStyles.text12MediumLabel,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Container(
                                width: 10,
                                height: 10,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '降低额度',
                                style: TextStyles.text12MediumLabel,
                              ),
                            ],
                          ),
                          Container(
                            width: 343,
                            height: 205,
                            child: SimpleBarChart.withSampleData(
                                quota['limit_history']['lists']
                                    .cast<Map<dynamic, dynamic>>()
                                    .toList()),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          '时间',
                          style: TextStyles.text16MediumLabel,
                        ),
                        Text(
                          '提降额',
                          style: TextStyles.text16MediumLabel,
                        ),
                        Text(
                          '总额度',
                          style: TextStyles.text16MediumLabel,
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
                    Column(
                      children: buildLimitItem(
                          quota['limit_history']['lists']
                              .cast<Map<dynamic, dynamic>>()
                              .toList(),
                          1),
                    ),
                    Container(
                      height: 53,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                              left: 16,
                              right: 22,
                            ),
                            child: Text(
                              '您已达银行的贴间隔周期，但暂未查询到您有提额，建议您咨询专业信用管理师。',
                              style: TextStyles.text12MediumPPLabel,
                            ),
                          ),
                          Positioned(
                            top: 27,
                            right: 10,
                            child: Container(
                              width: 70,
                              height: 20,
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '立即咨询',
                                      style: TextStyles.text12BlueMediumLabel,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colours.blue_color,
                                      size: 14,
                                    ),
                                  ],
                                ),
                                onPressed: () {},
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 234,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '临时额度变动历史',
                            style: TextStyles.text15MediumLabel,
                          ),
                          Container(
                            width: 343,
                            height: 202,
                            child: SimpleTimeSeriesChart.withSampleData(
                                quota['templimit_history']['lists']
                                    .cast<Map<dynamic, dynamic>>()
                                    .toList()),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 48,
                      padding: EdgeInsets.only(left: 17, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '时间',
                            style: TextStyles.text16MediumLabel,
                          ),
                          Text(
                            '临时额度',
                            style: TextStyles.text16MediumLabel,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Column(
                      children: buildLimitItem(
                          quota['templimit_history']['lists']
                              .cast<Map<dynamic, dynamic>>()
                              .toList(),
                          2),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                padding: EdgeInsets.only(
                  top: 15,
                ),
                color: Colours.white_color,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset('assets/images/user/dqyhte_icon.png',
                            width: 22, height: 15),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          '当前卡片影响提额的主要原因有',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeights.medium,
                            color: Colours.blue_color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 0.5,
                      width: 343,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            '逾期影响',
                            style: TextStyles.text16MediumLabel,
                          ),
                          Text(
                            '未影响',
                            style: TextStyles.text16MediumLabel,
                          ),
                          Container(
                            width: 80,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.5),
                              color: Colours.blue_color,
                            ),
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                '查看诊断',
                                style: TextStyles.text15WhiteMediumLabel,
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            '逾期影响',
                            style: TextStyles.text16MediumLabel,
                          ),
                          Text(
                            '未影响',
                            style: TextStyles.text16MediumLabel,
                          ),
                          Container(
                            width: 80,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.5),
                              color: Colours.blue_color,
                            ),
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                '查看诊断',
                                style: TextStyles.text15WhiteMediumLabel,
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            '逾期影响',
                            style: TextStyles.text16MediumLabel,
                          ),
                          Text(
                            '未影响',
                            style: TextStyles.text16MediumLabel,
                          ),
                          Container(
                            width: 80,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.5),
                              color: Colours.blue_color,
                            ),
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                '查看诊断',
                                style: TextStyles.text15WhiteMediumLabel,
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colours.background_color2,
                    ),
                    Container(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            '逾期影响',
                            style: TextStyles.text16MediumLabel,
                          ),
                          Text(
                            '未影响',
                            style: TextStyles.text16MediumLabel,
                          ),
                          Container(
                            width: 80,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.5),
                              color: Colours.blue_color,
                            ),
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                '查看诊断',
                                style: TextStyles.text15WhiteMediumLabel,
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 85,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  top: 10,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/user/kttezs_img.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child: null,
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                height: 45,
                child: Column(
                  children: <Widget>[
                    Text(
                      '数据有误，请参考官网',
                      style: TextStyles.text12MediumPLabel,
                    ),
                    Text(
                      '此报告解释权归期望管家',
                      style: TextStyles.text12MediumPLabel,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  List<Widget> buildLimitItem(List<Map<dynamic, dynamic>> dataList, int type) {
    List<Widget> widgetList = List<Widget>();
    for (int i = 0; i < dataList.length; i++) {
      Map dataItem = dataList[i];
      Widget wd = Column(
        children: <Widget>[
          Container(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '${dataItem['year']}年${dataItem['month']}月',
                  style: TextStyles.text16MediumPPLabel,
                ),
                type == 1
                    ? Text(
                        '+0.00',
                        style: TextStyles.text16BlueMediumLabel,
                      )
                    : Container(),
                Text(
                  '${dataItem['limit']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF00AF2E),
                    fontWeight: FontWeights.medium,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Colours.background_color2,
          ),
        ],
      );
      widgetList.add(wd);
    }
    return widgetList;
  }
}
