import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:provider/provider.dart';

class SiteFilter extends StatefulWidget {
  static final routeName = '/Site-filter';
  @override
  _SiteFilterState createState() => _SiteFilterState();
}

class _SiteFilterState extends State<SiteFilter> {
  String _selectedValue = "";
  List<String> options = [];

  @override
  void didChangeDependencies() {
    _fetchSites();
    super.didChangeDependencies();
  }

  Future<void> _fetchSites() async {
    Map<String, dynamic> data = {};
    data = await APIService().getOne("$SITE_URL");
    if (data != null)
      setState(() {
        options = data["data"].cast<String>();
      });
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            return RadioListTile(
                activeColor: Colors.blue,
                title: Text(options[index]),
                value: options[index],
                groupValue: aProvider.filter["newssite"],
                onChanged: (String val) async {
                  setState(() {
                    _selectedValue = val;
                  });

                  aProvider.setFilter(
                    "newssite",
                    options[index],
                  );

                  Navigator.pop(context);
                });
          }),
    );
  }
}
