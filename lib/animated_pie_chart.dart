import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Pie extends StatefulWidget {
  const Pie({Key? key}) : super(key: key);

  @override
  _PieState createState() => _PieState();
}

class Sales {
  int year;
  int sales;
  charts.Color color;
  Sales(this.year, this.sales, this.color);
}

class _PieState extends State<Pie> {
  List colors = [
    charts.MaterialPalette.red.shadeDefault,
    charts.MaterialPalette.black,
    charts.MaterialPalette.blue.shadeDefault,
    charts.MaterialPalette.yellow.shadeDefault,
    charts.MaterialPalette.green.shadeDefault,
    charts.MaterialPalette.gray.shadeDefault,
  ];
  List<Sales> data = [];
  List<charts.Series<Sales, String>> chartData = [];
  void makeData() {
    final rnd = Random();
    for (int i = 2010; i < 2014; i++) {
      data.add(Sales(i, rnd.nextInt(100), colors[rnd.nextInt(6)]));
    }

    chartData.add(charts.Series(
        id: 'Sale',
        data: data,
        domainFn: (Sales sale, _) => sale.year.toString(),
        measureFn: (Sales sale, _) => sale.sales,
        colorFn: (Sales sale, _) => sale.color));
  }

  @override
  void initState() {
    makeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            const Text('Sales Data'),
            Expanded(
                child: charts.PieChart(
              chartData,
              animationDuration: Duration(milliseconds: 2000),
              animate: true,
            ))
            // vertical: false,
          ],
        ),
      ),
    ));
  }
}
