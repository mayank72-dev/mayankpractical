import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mayankptactical/src/Constants/appImages.dart';
import 'package:mayankptactical/src/Constants/appString/AppString.dart';
import 'package:mayankptactical/src/Controller/custiomButton.dart';
import 'package:mayankptactical/src/Controller/customtextfied.dart';
import 'package:mayankptactical/src/Element/textfield_contoller.dart';
import 'package:mayankptactical/src/Model/data_model.dart';

import 'package:mayankptactical/src/Style/colors.dart';
import 'package:mayankptactical/src/validation.dart';
import 'package:provider/provider.dart';
import '../../Utils/Add_notifier.dart';

AddScreen( {/*int? todoId,  String? todotitle,  String? catagory,  String? date,*/   bool? update,  DataModel? dataModel}) => ChangeNotifierProvider<AddNotifier>(create: (_) => AddNotifier(), child: Builder(builder: (context) =>AddScreenProvider(context:context,/*catagory:catagory,todotitle:todotitle,todate:date*/update:update,dataModel:dataModel??DataModel())),);
class AddScreenProvider extends StatelessWidget {


  bool? update;
  DataModel dataModel;

   AddScreenProvider({Key? key, required BuildContext context, this.update, required this.dataModel}) : super(key: key){

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var state = Provider.of<AddNotifier>(context, listen: false);
      state.initState(update);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(update==true) {
      title.text = dataModel.title.toString();
      date.text = dataModel.dueDate.toString();
      categorytext.text = dataModel.categories.toString();
    }

    return  Consumer<AddNotifier>(builder: (context, state, child)=>Scaffold(appBar: AppBar(title: Text(update== false?AppString.addTask:AppString.updateTask)),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Form(autovalidateMode:AutovalidateMode.onUserInteraction,
          key: state.fromKey,
          child: Column(children: [
            customTextField(double.infinity,  title, (value) => emptyValidation(value), state.focusNode[0], "title"),
            Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(10))),
            InkWell(onTap: (){
              // state.showdate(context);
            },
             child: customTextField(double.infinity, date,(value) => emptyValidation(value), state.focusNode[1], "due Date",readOnly: false),
            ),

            Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(10))),
            customTextField(double.infinity, categorytext,(value) => emptyValidation(value), state.focusNode[2], "select catogory",suffixIcon: AppImages.down,onTap: (){state.show();}),
            Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(10))),
     state.showList==false?   SizedBox(

           child: ListView.builder(
             shrinkWrap: true,
               itemCount: state.catagories.length,
                  itemBuilder: (context,index){

                return InkWell( onTap: (){
                  Card(child: Text(
                   categorytext.text = state.catagories[index].toString()));


                },child: Text(state.catagories[index]));

              }),
     ):Container(),
            Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(10))),
            customButton(() {state.Checkvalidation(context , update);}, AppColors.deepOrenge,  update== false?AppString.add:AppString.update)

          ]),
        ),
        ),
      ),

    ));
  }
}
