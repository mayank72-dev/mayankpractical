
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mayankptactical/src/Database/database_hendler.dart';
import 'package:mayankptactical/src/Element/textfield_contoller.dart';
import 'package:mayankptactical/src/Model/data_model.dart';


import '../Page/HomeScreen/home_screen.dart';


class AddNotifier extends ChangeNotifier{
  String? catagory;
  DataModel datamodel =DataModel();
DBHelper? dbHelper;
late Future<List<DataModel>>datalist;
List<FocusNode> focusNode = [FocusNode(), FocusNode(),FocusNode(),];
final fromKey = GlobalKey<FormState>();
bool showList = false;

List<String> catagories = ["shop", "work", "personal","office","farm","shopping mall",];

show(){
  showList=! showList;
  notifyListeners();
}
initState( update/*{bool? update}*/) {
  print("update add$update");
  print("update update$update");
  dbHelper= DBHelper();
  show();
  loadData();


}

loadData()async{
  datalist = dbHelper!.getDataList();
}

/// validatio
  void Checkvalidation(context, update ) async {
    if (fromKey.currentState!.validate()) {
      print("update update user$update");

    update == true?
    dbHelper!.update(DataModel(categories: categorytext.text.toString(),dueDate: date.text.toString(),title: title.text.toString(),id:datamodel.id  )):
      dbHelper!.insert(DataModel(title: title.text,
      categories: categorytext.text,
      dueDate: date.text));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen() ));
      title.clear();
      date.clear();
      categorytext.clear();

    } else {
      print("invalid data");
      notifyListeners();
    }
    notifyListeners();
  }


  /// select date
  showdate(context)async{
    DateTime? pickedDate = await showDatePicker(
        context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101)
    );
    if(pickedDate != null ){
      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement


      date.text = formattedDate; //set output date to TextField value.

    }else{
      print("Date is not selected");
    }
    notifyListeners();

  }

  }






