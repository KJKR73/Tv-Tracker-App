import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CreatePie extends StatelessWidget {
  final bool animate;
  final dynamic data;
  CreatePie({this.animate, this.data});

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      _createSampleData(this.data),
      animate: this.animate,
      animationDuration: Duration(milliseconds: 500),
      // behaviors: [
      //   new charts.DatumLegend(
      //     entryTextStyle: charts.TextStyleSpec(
      //       color: charts.ColorUtil.fromDartColor(Colors.white),
      //     ),
      //   ),
      // ],
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 100,
        arcRendererDecorators: [
          new charts.ArcLabelDecorator(
            leaderLineColor: charts.ColorUtil.fromDartColor(Colors.black),
          )
        ],
      ),
    );
  }

  static List<charts.Series<Tracker, String>> _createSampleData(
      dynamic dataPie) {
    final data = [
      new Tracker(dataPie[0]["name"], dataPie[0]["percent"], Colors.white),
      new Tracker(dataPie[1]["name"], dataPie[1]["percent"], Colors.green),
      new Tracker(dataPie[2]["name"], dataPie[2]["percent"], Colors.blue[400]),
    ];

    return [
      new charts.Series<Tracker, String>(
        id: 'Sales',
        domainFn: (Tracker data, _) => data.name.toString(),
        measureFn: (Tracker data, _) => data.percent,
        colorFn: (Tracker data, index) =>
            charts.ColorUtil.fromDartColor(data.color),
        data: data,
        labelAccessorFn: (Tracker data, index) {
          return data.percent.toStringAsFixed(2);
        },
        insideLabelStyleAccessorFn: (Tracker data, index) =>
            charts.TextStyleSpec(
          color: charts.ColorUtil.fromDartColor(
            Colors.black,
          ),
          fontSize: 16,
        ),
      )
    ];
  }
}

class Tracker {
  final String name;
  final dynamic percent;
  final Color color;

  Tracker(this.name, this.percent, this.color);
}
