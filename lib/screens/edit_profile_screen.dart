import 'dart:io';

import 'package:crypto_tracker_2/helper.dart';
import 'package:crypto_tracker_2/screens/home_screen.dart';
import 'package:crypto_tracker_2/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String imagePath;
  final String name;
  final String email;
  const EditProfileScreen({
    Key? key,
    required this.imagePath,
    this.name = "",
    this.email = "",
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController controllername = TextEditingController();
  late TextEditingController controlleremail = TextEditingController();
  String _imagePath = "";
  String _name = "";
  String _email = "";
  @override
  void initState() {
    _imagePath = widget.imagePath;
    _name = widget.name;
    _email = widget.email;
    controllername = TextEditingController(text: _name);
    controlleremail = TextEditingController(text: _email);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Edit Profile')
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 100),
            _profileEdit(),
            SizedBox(height: 24),
            Column(
              children: [
               _textForm("Nama Lengkap", controllername,_valueName),
                SizedBox(height:10),
                _textForm("Email",controlleremail,_valueEmail),
                SizedBox(height:30),
                Center(
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return HomeScreen(imagePath: _imagePath, name: _name,email: _email,);
                        }));
                        },
                      child: Text("Save"),
                    )
                )
              ],
            )
          ]
        )
    );
  }

  Widget _textForm(label,controller,function){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: (value) {
            function(value);
          },
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _profileEdit(){
    if(_imagePath.isEmpty){
      return ProfileWidget(
          imagePath:  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyoZspK0y6MPSyaxL229SGu7C23C8j-Nm0VQ&usqp=CAU',
          isEdit: true,
          onClicked: () {
            _imagePath = "";
            alertButton();
          }
      );
    }else{
      return ProfileWidget(
          imagePath:  _imagePath ,
          isEdit: true,
          onClicked: () {
            _imagePath = "";
            alertButton();
          }
      );
    }
  }
  void alertButton() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      ImagePickerHelper().getImageFromGallery((value) => _processImage(value));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  SizedBox(height:10),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      ImagePickerHelper().getImageFromCamera((value) => _processImage(value));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _valueName(String value){
    if(value!=null){
      setState(() {
        _name = value;
      });
    }
  }

  void _valueEmail(String value){
    if(value!=null){
      setState(() {
        _email = value;
      });
    }
  }

  void _processImage(String? value){
    if(value!=null){
      setState(() {
        _imagePath = value;
      });
    }
  }
}
