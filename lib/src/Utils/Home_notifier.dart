import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mayankptactical/src/Database/database_hendler.dart';
import 'package:mayankptactical/src/Model/data_model.dart';



class HomeNotifier extends ChangeNotifier {
  DBHelper? dbHelper;
  Future<List<DataModel>>? dataList;
  Future<List<DataModel>>? item;

  bool check = false;
  FocusNode focusNode = FocusNode();

  initState() async {
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    dataList = dbHelper!.getDataList();

    notifyListeners();
  }

  checkValue(value) {
    value = check;
    print("value check$value");
    notifyListeners();
  }

  /// Delete Id
  delete(todoId) {
    dbHelper!.delete(todoId);
    notifyListeners();
  }


/*  void filterSearchResults(String query) {
    item = dataList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
  }*/

}
