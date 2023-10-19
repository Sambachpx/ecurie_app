import 'package:ecurie_app/main.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget{
  const EditProfile({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _EditProfileState createState() => _EditProfileState();
}


class _EditProfileState extends State<EditProfile>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      title: Text('edit'),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.blue,
      ),
        onPressed: () {},
    ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            onPressed: () {  },
          )
        ],

      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
      )
    );
  }
}