import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mayankptactical/src/Constants/appString/AppString.dart';
import 'package:mayankptactical/src/Page/AddScreen/add_screen.dart';
import 'package:mayankptactical/src/Style/colors.dart';
import 'package:mayankptactical/src/Utils/Home_notifier.dart';
import 'package:provider/provider.dart';

import '../../Model/data_model.dart';

HomeScreen() => ChangeNotifierProvider<HomeNotifier>(create: (_) => HomeNotifier(), child: Builder(builder: (context) =>HomeScreenProvider(context:context,)),);
class HomeScreenProvider extends StatelessWidget {

   HomeScreenProvider({Key? key, required BuildContext context,}) : super(key: key){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var state = Provider.of<HomeNotifier>(context, listen: false);
      state.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(builder: (context,state, child)=> Scaffold(
      appBar: AppBar(title: Text(AppString.title, style: TextStyle(color: AppColors.white,fontSize: 14),),
        centerTitle: true,

    ),
      body: Column(children: [
       // customTextField(double.infinity,  search, (value) => null, state.focusNode, "title",onChanged: (value){}),

        Expanded(child: FutureBuilder(
          future: state.dataList,
          builder: (context, AsyncSnapshot<List<DataModel>> snapshot){
            if(!snapshot.hasData || snapshot.data == null){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snapshot.data!.length==0){
              return const Center(
                child: Text(AppString.noTask),
              );
            }else{
              return SizedBox(height: 500,
                child: ListView.builder(shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, inddex){
            int todoId = snapshot.data![inddex].id!.toInt();
            String todotitle = snapshot.data![inddex].title.toString();
            String date = snapshot.data![inddex].dueDate.toString();
            String catagory = snapshot.data![inddex].categories.toString();
                return  InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> AddScreen(/*todoId:todoId,todotitle:todotitle,catagory:catagory,date:date*/ dataModel:snapshot.data![inddex] ,update:true)));},
                  child: Container(
                    height: 80,
                    child: Dismissible(key: ValueKey<int>(todoId),
                        direction: DismissDirection.endToStart,
                        background: Container(
                            color: AppColors.deepOrenge,
                      child: Icon(Icons.delete_forever)),
                      onDismissed: (DismissDirection direction){
                      state.delete(todoId);
                      snapshot.data!.remove(snapshot.data![inddex]);
                      },


                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(decoration: BoxDecoration(color: AppColors.deepOrenge,borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Checkbox(
                                  checkColor: AppColors.grey,
                                  activeColor: AppColors.deepOrenge,
                                  value: state.check,
                                  onChanged: ( value) {

                                    state.checkValue(value);
                                  }),
                                Expanded(
                                     child: ListTile(title: Text(todotitle),subtitle: Text(date),
                                 trailing: Text(catagory), ),
                                   )
                                ],
                            ),
                          ),
                        ),
                      ),
                    ),
                );





                }),
              );/*ListView.builder(
                itemCount: ,
                  itemBuilder: (context, index){

              })*/
            }

          },
        ))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AddScreen(update: false)));},

        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nic


    ),

    );
  }
}
