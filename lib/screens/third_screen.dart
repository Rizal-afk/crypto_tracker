import 'package:crypto_tracker_2/screens/edit_profile_screen.dart';
import 'package:crypto_tracker_2/screens/login_screen.dart';
import 'package:crypto_tracker_2/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThirdScreen extends StatefulWidget {
  final String imagePath;
  final String name;
  final String email;
  const ThirdScreen({
    Key? key,
    this.imagePath = "",
    this.name = "",
    this.email = "",
  }) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 100),
          _profileSection(),
          SizedBox(height: 24),
          Column(
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  widget.email,
                  style: TextStyle(color:Colors.white),
                ),
              ],
          ),
          SizedBox(height:50),
          Center(
            child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  logindata.setBool('login', true);
                  Navigator.pushReplacement(context,
                      new MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              child: Text("Logout"),
            )
          )
        ],
      )
    );
  }
  Widget _profileSection(){
    if(widget.imagePath.isEmpty){
      return ProfileWidget(
          imagePath:  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyoZspK0y6MPSyaxL229SGu7C23C8j-Nm0VQ&usqp=CAU' ,
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EditProfileScreen(imagePath: widget.imagePath, name: widget.name, email: widget.email,)),
            );
          }
      );
    }else{
      return ProfileWidget(
          imagePath:  widget.imagePath ,
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EditProfileScreen(imagePath: widget.imagePath, name: widget.name, email: widget.email,)),
            );
          }
      );
    }
  }
}
