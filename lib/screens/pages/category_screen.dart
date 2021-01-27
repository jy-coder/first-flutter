import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/provider.dart';
import 'package:newheadline/shared/app_drawer.dart';
import 'package:newheadline/utils/auth.dart';
import 'package:newheadline/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/category';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      CategoryProvider cProvider = Provider.of<CategoryProvider>(context);

      cProvider.fetchCategories().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select a category"),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CategoryGrid(),
        drawer: AppDrawer());
  }
}

class CategoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<CategoryProvider>(context);
    final categories = categoriesData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: categories.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          key: Key("item$i"), value: categories[i], child: CategoryItem()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
