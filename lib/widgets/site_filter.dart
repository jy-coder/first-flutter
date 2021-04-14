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
  List<String> _sites = [];
  Map<int, String> options = {};

  @override
  void didChangeDependencies() {
    _displaySites();
    super.didChangeDependencies();
  }

  Future<void> _fetchSites() async {
    Map<String, dynamic> data = {};
    data = await APIService().getOne("$SITE_URL");
    if (data != null)
      setState(() {
        _sites = data["data"].cast<String>();
      });
  }

  void _displaySites() async {
    await _fetchSites();
    for (int i = 0; i < _sites.length; i++) {
      options[i + 1] = _sites[i];
    }
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
                title: Text(options[index + 1]),
                value: index.toString(),
                groupValue: _selectedValue,
                onChanged: (String val) async {
                  setState(() {
                    _selectedValue = val;
                  });

                  aProvider.setFilter(
                    "newssite",
                    options[index + 1],
                  );

                  Navigator.pop(context);
                });
          }),
    );
  }
}
