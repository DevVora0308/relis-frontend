import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;
  String touchedPieChart;

  Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    required this.touchedPieChart,
    this.size = 16,
    //this.textColor = const Color(0xff505050),
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("touchedPieChart: ${touchedPieChart}");
    return Wrap(
      children: <Widget>[
        Container(
          width: touchedPieChart == text ? size + 5 : size,
          height: touchedPieChart == text ? size + 5 : size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: touchedPieChart == text ? 20 : 16,
            fontWeight: touchedPieChart == text ? FontWeight.bold : FontWeight.normal,
            color: textColor,
          ),
        )
      ],
    );
  }
}
