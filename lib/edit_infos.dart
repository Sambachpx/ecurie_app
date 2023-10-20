import 'package:ecurie_app/main.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: AppBar(
            title: Text('Edit Profile Cheval'),
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
                onPressed: () {},
              ),

            ],
          ),
        ),
    Container(
    padding: EdgeInsets.only(left: 15, top: 20, right: 15),
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(width:4, color: Colors.white),
        boxShadow: [
          BoxShadow(
    spreadRadius: 2,
    blurRadius: 10,
    color: Colors.black.withOpacity(0.1)
    )
    ],
        color: Colors.black,
      ),
    )
    ),
        // Add the content of your EditProfile widget here
      ],
    );
  }

}
