import 'package:counter_app/Helper/firebase_util.dart';
import 'package:counter_app/Model/model_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = ChangeNotifierProvider.family<CounterProvider,String>((ref, id) {
  return CounterProvider(id);
});

class CounterProvider extends ChangeNotifier{
  String pageIndex;
  var counter =0;
  late FirebaseDatabaseUtil databaseUtil;

  CounterProvider(this.pageIndex){
    databaseUtil = FirebaseDatabaseUtil();
    databaseUtil.addListener(pageIndex,updateCounter);
  }
  updateCounter(int counter){
    this.counter= counter;
    notifyListeners();
  }

  void increment(){
    databaseUtil.updateCounter(ModelCount(pageIndex: pageIndex,totalCounter: counter+1));
  }

}