import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/utils/common.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:provider/provider.dart';

class SiteFilter extends StatefulWidget {
  static final routeName = '/Site-filter';
  @override
  _SiteFilterState createState() => _SiteFilterState();
}

class _SiteFilterState extends State<SiteFilter> {
  List<String> options = [];
  List<String> isChecked = [];

  @override
  void didChangeDependencies() {
    _fetchSites();
    super.didChangeDependencies();
  }

  Future<void> _fetchSites() async {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    Map<String, dynamic> data = {};
    data = await APIService().getOne("$SITE_URL");
    String siteFilter = aProvider.filter['site'];
    if (data != null)
      setState(() {
        options = data["data"].cast<String>();
        if (siteFilter != "") {
          isChecked = stringToList(siteFilter);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    activeColor: Colors.blue,
                    title: Text(options[index]),
                    value: isChecked.contains(options[index]),
                    onChanged: (bool value) {
                      if (value) {
                        setState(() {
                          isChecked.add(options[index]);
                        });
                      } else {
                        setState(() {
                          isChecked.remove(options[index]);
                        });
                      }
                    },
                  );
                }),
          ),
          RaisedButton(
            child: Text("Filter"),
            onPressed: () {
              aProvider.setFilter(
                "newssite",
                listToString(isChecked),
              );
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
