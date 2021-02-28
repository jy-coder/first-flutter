import 'package:flutter/material.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:provider/provider.dart';

class CustomizeThemeButton extends StatefulWidget {
  @override
  _CustomizeThemeButtonState createState() => _CustomizeThemeButtonState();
}

class _CustomizeThemeButtonState extends State<CustomizeThemeButton> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);
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
                                inactiveColor: Colors.grey,
                                activeColor: tProvider.theme == "light"
                                    ? Colors.blue
                                    : Colors.green,
                                value: _currentSliderValue,
                                min: 10,
                                max: 30,
                                divisions: 1,
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
                                onPressed: () {
                                  tProvider.setSelectedTheme("light");
                                },
                                color: Colors.white,
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: MaterialButton(
                                onPressed: () {
                                  tProvider.setSelectedTheme("dark");
                                },
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
