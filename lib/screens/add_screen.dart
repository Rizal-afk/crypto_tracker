import 'package:crypto_tracker_2/models/boxes.dart';
import 'package:crypto_tracker_2/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddTodoScreen extends StatefulWidget {
  final String name;
  final String imageUrl;

  const AddTodoScreen({Key? key,
  required this.name,
  required this.imageUrl}) : super(key: key);

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final GlobalKey<FormState> _formKey =
  GlobalKey<FormState>();

  void _onFormSubmit() {
    Box<Todo> todoBox = Hive.box<Todo>(HiveBoxex.todo);
    todoBox.add(Todo(name: widget.name, imageUrl: widget.imageUrl,
        valOperation: _valOperation, selectedDate: selectedDate));
    Navigator.of(context).pop();
    print(todoBox);
  }

  validated() {
    if (_formKey.currentState != null &&
        _formKey.currentState!.validate()) {
      _onFormSubmit();
      print("Form Validated");
    } else {
      print("Form not validated");
      return;
    }
  }
  String _valOperation = "Jual" ;
  List<String> _listOperation = ["Jual", "Beli"];
  int? nilaiOperasi;

  DateTime selectedDate = DateTime.now();

  //mengambil input user untuk tanggal
  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(selectedDate.year + 1));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void pilihOperasi(String value){
    setState(() {
      _valOperation = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
        body: SafeArea(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        children: [
                          Text("Operasi : "),
                          SizedBox(width: 20),
                          DropdownButton(
                            hint: Text("Select The Operation"),
                            value: _valOperation,
                            onChanged: (String ? value){
                              pilihOperasi(value??"");
                              nilaiOperasi = _listOperation.indexOf(value??"");
                              },
                            items: _listOperation.map((String value){
                              return DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              );
                            }
                            ).toList(),
                          ),
                        ]
                    ),
                    SizedBox(height:20),
                    Row(
                      children: [
                        Text("Tanggal : "),
                        TextButton(
                          child: Icon( Icons.calendar_today_outlined, ),
                          onPressed: (){
                            _selectedDate(context);
                          },
                        ),
                        //menampilkan tanggal yang diinput user
                        Text(
                          "${selectedDate.toLocal()}".split(' ')[0]
                        ),
                      ],
                    ),
                    SizedBox(height:20),
                    ElevatedButton(
                        onPressed: () {
                          validated();
                          },
                        child: Text('Submit'))
                  ],
                ),
              )
          ),
        ),
    );
  }
}
