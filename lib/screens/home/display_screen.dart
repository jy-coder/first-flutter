import 'package:flutter/material.dart';
import 'package:newheadline/screens/home/daily_read_screen.dart';
import 'package:newheadline/screens/home/trend_screen.dart';

class DisplayScreen extends StatefulWidget {
  static final routeName = "/display";
  final String displayTabName;

  DisplayScreen({this.displayTabName});
  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.displayTabName == "For You") {
      return Container(
        child: DailyReadScreen(),
      );
    } else if (widget.displayTabName == "Trending") {
      return Container(
        child: TrendScreen(),
      );
    } else {
      return Container();
    }
  }
}
