import 'dart:convert';

import 'package:counter_app/Model/model_count.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FirebaseDatabaseUtil {
  DatabaseReference? _counterRef;
  FirebaseDatabase database =  FirebaseDatabase.instance;

  // creating singleton class for firebase
  static final FirebaseDatabaseUtil instance =
  FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return instance;
  }

  void initState() {
    _counterRef = FirebaseDatabase.instance.ref().child('counter');

    database.ref().child('counter').once().then((snapshot) {
      Get.log('Connected to second database and read ${snapshot.snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef!.keepSynced(true);

    _counterRef!.onValue.listen((event) {
      Get.log('Listener ${event.snapshot.value}');

    }, onError: (Object o) {
      Get.log('error $o');
    });
  }

  void addListener(String pageIndex, Function(int counter) update){
    _counterRef!.child(pageIndex).onValue.listen((event) {
      if(event.snapshot.value!=null) {
        Get.log('Listener of $pageIndex ${event.snapshot.value}');
        var counter = jsonDecode(jsonEncode(event.snapshot.value));
        update(counter['totalCounter']);
      }
      else {
        update(0);
      }

    }, onError: (Object o) {
      Get.log('error $o');
    });
  }

  void resetCounter() async {
    await _counterRef!.remove().then((_) {
      Get.log('Resetting counter');
    });
  }

  void updateCounter(ModelCount modelCount) async {

    DatabaseEvent event = await _counterRef!.once();

    if(event.snapshot.value!=null) {
      await _counterRef!.child(modelCount.pageIndex!).update(modelCount.toJson())
          .then((value) => Get.log('Transaction  Updated.'));
    }
    else{
      await _counterRef!.child(modelCount.pageIndex!).set(modelCount.toJson())
          .then((value) => Get.log('Transaction  added.'));
    }
  }

}