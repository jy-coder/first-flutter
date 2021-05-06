import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:url_launcher/url_launcher.dart';
import "dart:math";
import 'package:shared_preferences/shared_preferences.dart';

class Advert extends StatefulWidget {
  final List<Advertisement> adverts;

  Advert({@required this.adverts});

  @override
  _AdvertismentState createState() => _AdvertismentState();
}

class _AdvertismentState extends State<Advert>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int randomNumber = 0;
  int previousNumber;
  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_statements
    getPreviousNumber().then((_) {
      do {
        randomNumber = Random().nextInt(widget.adverts.length);
        addPreviousNumber();
      } while (randomNumber == previousNumber);
    });
  }

  void addPreviousNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('previousNumber', randomNumber);
  }

  getPreviousNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool checkValue = prefs.containsKey('previousNumber');
    setState(() {
      if (checkValue) {
        previousNumber = prefs.getInt('previousNumber');
      } else {
        previousNumber = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          launch(widget.adverts[randomNumber].webLink);
        },
        child: FittedBox(
          child: CachedNetworkImage(
            imageUrl: widget.adverts[randomNumber].imgLink,
          ),
          fit: BoxFit.fill,
        ));
  }
}
