import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<Report, int>> _lineChartSource;
// var url = Uri.https(
  //     "https://data.covid19.go.id/public/api/prov_detail_JAWA_TIMUR.json");
  _dataSources() {
    var keseluruhan = [
      new Report(1, 100),
      new Report(2, 30),
      new Report(3, 60),
      new Report(4, 80),
      new Report(5, 50),
    ];
    var kematian = [
      new Report(1, 30),
      new Report(2, 10),
      new Report(3, 30),
      new Report(4, 45),
      new Report(5, 20),
    ];
    var sembuh = [
      new Report(1, 70),
      new Report(2, 20),
      new Report(3, 30),
      new Report(4, 35),
      new Report(5, 30),
    ];
    _lineChartSource.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xFFF44336)),
        id: 'keseluruhan',
        data: keseluruhan,
        domainFn: (Report report, _) => report.hari,
        measureFn: (Report report, _) => report.jumlah,
      ),
    );
    _lineChartSource.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xFF4CAF50)),
        id: 'sembuh',
        data: sembuh,
        domainFn: (Report report, _) => report.hari,
        measureFn: (Report report, _) => report.jumlah,
      ),
    );
    _lineChartSource.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xFF000000)),
        id: 'kematian',
        data: kematian,
        domainFn: (Report report, _) => report.hari,
        measureFn: (Report report, _) => report.jumlah,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _lineChartSource = <charts.Series<Report, int>>[];
    _dataSources;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('COVID-19 Reports of Java Island'),
        ),
        body: Center(
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text('Report of COVID-19 this month'),
                  Expanded(
                    child: charts.LineChart(
                      _lineChartSource,
                      defaultRenderer: new charts.LineRendererConfig(
                          includeArea: true, stacked: true),
                      animate: true,
                      animationDuration: Duration(seconds: 5),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Report {
  int hari;
  int jumlah;

  Report(this.hari, this.jumlah);
}
