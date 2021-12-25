import 'package:counter_app/Helper/firebase_util.dart';
import 'package:counter_app/Widgets/counter_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBottomNavigation extends StatefulWidget {
  const HomeBottomNavigation({Key? key}) : super(key: key);

  @override
  State<HomeBottomNavigation> createState() => _HomeBottomNavigationState();
}

class _HomeBottomNavigationState extends State<HomeBottomNavigation> {

  final _currentIndex = 0.obs;
  final List<Widget> _children = [
    const CounterWidget(pageIndex: "one"),
    const CounterWidget(pageIndex: "two"),
    const CounterWidget(pageIndex: "three"),
  ];

  @override
  void initState() {
    super.initState();
    FirebaseDatabaseUtil().initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.restart_alt_rounded),
            onPressed: () {
              showWarningDialog();
            },
          )
        ],
      ),
      body: Obx(()=>_children[_currentIndex.value]) ,
      bottomNavigationBar: Obx(()=>
          BottomNavigationBar(
              onTap: onTabTapped,
              currentIndex: _currentIndex.value,
              selectedIconTheme: const IconThemeData(opacity: 0.0, size: 0),
              unselectedIconTheme: const IconThemeData(opacity: 0.0, size: 0),
              items:  [
                BottomNavigationBarItem(
                  icon: Container(),
                  label: "Counter 1",
                ),
                BottomNavigationBarItem(
                  icon: Container(),
                  label: "Counter 2",
                ),
                BottomNavigationBarItem(
                  icon: Container(),
                  label: "Counter 3",
                ),
              ]
          ),
      )
    );
  }

  void onTabTapped(int index) {
    _currentIndex.value = index;
  }

  showWarningDialog(){
    return showDialog(context: context,
        builder: (BuildContext context) =>  CupertinoAlertDialog(
          title:  const Text("Sure to reset counter"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("Yes"),
              onPressed:(){
                FirebaseDatabaseUtil().resetCounter();
                Navigator.pop(context);
              },
            ),
             CupertinoDialogAction(
              child: const Text("No"),
              onPressed:()=> Navigator.pop(context) ,
            )
          ],
        )
    );
  }
}