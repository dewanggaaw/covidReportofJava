import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19_report/models/info.model.dart';
import 'package:covid19_report/models/perkembangan.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<ListPerkembangan, int>> _lineChartSource;
  List<charts.Series> _barChartSource;
  Info covidData;

  _setCovidData(Info covidInfo) {
    setState(() {
      covidData = covidInfo;
    });
  }

  _fetchCovidData() async {
    var response = await http.get(Uri.https(
        'data.covid19.go.id', 'public/api/prov_detail_JAWA_TIMUR.json'));
    if (response.statusCode == 304 || response.statusCode == 200) {
      var data = Info.fromJson(json.decode(response.body));
      _setCovidData(data);
      _constructDaySeriesData();
    }
  }

  _constructMonthlySeriesData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }

  _constructDaySeriesData() {
    if (covidData != null) {
      List<ListPerkembangan> datas =
          covidData.listPerkembangan.take(7).toList();
      _lineChartSource.add(
        charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xFF4CAF50)),
          id: 'sembuh',
          data: datas,
          domainFn: (ListPerkembangan p, _) => p.c,
          measureFn: (ListPerkembangan p, _) => p.sEMBUH,
        ),
      );

      _lineChartSource.add(
        charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xFF000000)),
          id: 'kematian',
          data: datas,
          domainFn: (ListPerkembangan p, _) => p.c,
          measureFn: (ListPerkembangan p, _) => p.mENINGGAL,
        ),
      );

      _lineChartSource.add(
        charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xFFF44336)),
          id: 'keseluruhan',
          data: datas,
          domainFn: (ListPerkembangan p, _) => p.c,
          measureFn: (ListPerkembangan p, _) => p.kASUS,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _lineChartSource = <charts.Series<ListPerkembangan, int>>[];
    _barChartSource = _constructMonthlySeriesData();
    _fetchCovidData();
  }

  Widget anotherChart() {
    return charts.BarChart(
      _barChartSource,
      animate: true,
      barGroupingType: charts.BarGroupingType.stacked,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Reports of Java Island'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('Report of COVID-19 this month'),
              Container(
                height: 200,
                child: charts.LineChart(
                  _lineChartSource,
                  defaultRenderer: new charts.LineRendererConfig(
                      includeArea: true, stacked: true),
                  animate: true,
                  animationDuration: Duration(seconds: 2),
                  behaviors: [
                    new charts.ChartTitle('Hari',
                        behaviorPosition: charts.BehaviorPosition.bottom,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea),
                    new charts.ChartTitle('Jumlah',
                        behaviorPosition: charts.BehaviorPosition.start,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea),
                    new charts.ChartTitle('Kasus Covid',
                        behaviorPosition: charts.BehaviorPosition.end,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea),
                  ],
                ),
              ),
              Text('Report of COVID-19 this month'),
              Container(
                  height: 200,
                  //if you want to make 200 responsive, please use mediaquery
                  child: anotherChart())
            ],
          ),
        ),
      ),
    );
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
