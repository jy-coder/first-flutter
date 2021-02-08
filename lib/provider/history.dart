// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:newheadline/models/models.dart';
// import 'package:newheadline/utils/response.dart';
// import 'package:newheadline/utils/urls.dart';

// class HistoryProvider with ChangeNotifier {
//   Future<List<Map<String, dynamic>>> fetchReadingHistory([int page]) async {
//     const url = HISTORY_URL;
//     if (page == null) page = 1;

//     List<Map<String, dynamic>> data = await APIService().get(url);

//     List<Article> items = [];

//     return data;
//   }
// }
