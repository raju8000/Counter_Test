import 'package:counter_app/Notifier/counter_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterWidget extends StatelessWidget {
  final String pageIndex;
  const CounterWidget({Key? key,required this.pageIndex }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer(
        builder: (context, ref,_) {
          var counterNotifier = ref.watch(counterProvider(pageIndex));
          return Column(
            children:  [
              Text("Counter $pageIndex",style: const TextStyle(fontSize: 20)),
              Expanded(
                  child: Center(
                      child:Text("Counter: ${counterNotifier.counter}",style: const TextStyle(fontSize: 20),)
                  )
              ),
              Row(
                children: [
                  const Spacer(),
                  FloatingActionButton(
                    onPressed:()=> counterNotifier.increment(),
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ),
                ],
              )
            ],
          );
        }
      ),
    );
  }
}
