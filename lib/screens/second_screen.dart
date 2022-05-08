import 'package:crypto_tracker_2/models/boxes.dart';
import 'package:crypto_tracker_2/models/todo.dart';
import 'package:crypto_tracker_2/widgets/designs/data_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 1.3,
                    child:ValueListenableBuilder(
                        valueListenable:
                        Hive.box<Todo>(HiveBoxex.todo).listenable(),
                        builder: (context, Box<Todo> box, _) {
                          if (box.values.isEmpty) {
                            return Center(
                              child: Text(
                                  'Belum Ada Data!!',
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: box.values.length,
                            itemBuilder: (context, index) {
                              Todo? res = box.getAt(index);
                              return Dismissible(
                                  background: Container(
                                    color: Colors.red,
                                  ),
                                  key: UniqueKey(),
                                  onDismissed: (direction) {
                                    res!.delete();
                                    },
                                  child:  DataCard(
                                    name: res!.name,
                                    imageUrl: res!.imageUrl,
                                    valOperation: res!.valOperation,
                                    selectedDate: res!.selectedDate,
                                  )
                              );
                              },
                          );
                        }
                        ),
                  )
              )
            ]
        )
    );
  }
}
