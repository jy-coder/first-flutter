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

class _AdvertismentState extends State<Advert> {
  int randomNumber = 0;
  int previousNumber = 0;

  @override
  void initState() {
    super.initState();
    getPreviousNumber().then((_) {
      do {
        randomNumber = Random().nextInt(widget.adverts.length);
      } while (randomNumber == previousNumber && widget.adverts.length != 1);
      addPreviousNumber();
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
      child: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.contain,
              alignment: FractionalOffset.center,
              image: NetworkImage(widget.adverts[randomNumber].imgLink),
            )),
          ),
        ),
      ),
    );
  }
}
