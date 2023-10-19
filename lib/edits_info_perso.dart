import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: EditProfile(),
      ),
    ),
  ));
}

class Myform extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Center(
        child: Container(
          width: 500,
          child: TextFormField(
            maxLength: 12,
            // maxLines: 1,
            initialValue: "+33",
            decoration: const InputDecoration(
              labelText: "Enter number phone",
              hintText: " Enter text",
              border: OutlineInputBorder(),
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value!.isEmpty) {
                return "Invalid phone number";
              }
              if (!isValidText(value)) {
                return "invalid characters entered";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  bool isValidText(String value) {
    final validCharacters = RegExp(r'^[0-9\s\+]+$');
    return validCharacters.hasMatch(value);
  }
}

class MyFormtwo extends StatelessWidget {
  get value => null;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Center(
        child: Container(
          width: 500,
          child: TextFormField(
            maxLength: 3,
            decoration: const InputDecoration(
              labelText: "Enter your Age",
              hintText: "Enter text",
              border: OutlineInputBorder(),
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value!.isEmpty) {
                return "Invalid phone number";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}

class lien_Ffe extends StatelessWidget {

  Widget build(BuildContext context) {
    return Form(
      child: Center(
        child: Container(
          width: 500,
          child: TextFormField(
            initialValue: "Https://",
            decoration: const InputDecoration(
              labelText: "Enter your FFE",
              hintText: "Enter link",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Invalid phone number";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Informations mon/mes chevaux'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,

          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
          Center(
            child: SizedBox(
            width: 100,
            height: 100,
              child: Stack(
                children:<Widget> [
              Container(
                width:100,
                height: 100,
              color: Colors.white,
              ),
              Container(
              decoration: BoxDecoration(
              border: Border.all(width: 4, color: Colors.white),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
             shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "",
                ),
              ),
            ),
              ),
          ],
        ),
      ),
          ),
    ],
    ),
    ),
      ),
    );
  }
}
