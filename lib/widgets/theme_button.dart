import 'package:flutter/material.dart';

class CustomizeThemeButton extends StatefulWidget {
  @override
  _CustomizeThemeButtonState createState() => _CustomizeThemeButtonState();
}

class _CustomizeThemeButtonState extends State<CustomizeThemeButton> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.font_download),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (builder) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Font Size'),
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Slider(
                                value: _currentSliderValue,
                                min: 10,
                                max: 30,
                                divisions: 5,
                                label: _currentSliderValue.round().toString(),
                                onChanged: (double value) {
                                  setState(() {
                                    _currentSliderValue = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Background Color'),
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: MaterialButton(
                                onPressed: () {},
                                color: Colors.white,
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: MaterialButton(
                                onPressed: () {},
                                color: Colors.black,
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(),
                            )
                          ],
                        ),
                      ],
                    ));
              });
            },
          );
        });
  }
}
