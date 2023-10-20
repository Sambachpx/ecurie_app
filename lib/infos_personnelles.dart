import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Myform(),
      ),
    ),
  ));
}

class Myform extends StatelessWidget {
  //get value => null;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Center(
        child: Container(
          width: 400,
      child: TextFormField(
        maxLength: 12,
       // maxLines: 1,
        initialValue: "+33",
        decoration: const InputDecoration(
          labelText: "Enter number phone",
          hintText: " Enter text",
          border: OutlineInputBorder()
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value){
          if (value!.isEmpty){
            return "Invalid phone number";
          }
          if (!isValidText(value)){
            return "invalid charaters entered";
          }
          return null;
        },
      ),
      ),
    ),
    );
  }
  bool isValidText(String value){
    final validCharacters = RegExp(r'^[0-9\s\+]+$');
    return validCharacters.hasMatch(value);
  }
}

class MyFormtwo extends StatelessWidget{
  get value => null;

  @override
  Widget build(BuildContext context){
    return Form(
      child: Center(
        child: Container(
          width: 400,
      child: TextFormField(
        maxLength: 3,
        decoration: const InputDecoration(
          labelText: "Enter your Age",
          hintText: "Enter text",
          border: OutlineInputBorder()
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value){
          if (value!.isEmpty){
            return "Invalid phone number";
          }
          return null;
        }
      )
      ),
      ),
    );
  }
}

class lien_Ffe extends StatelessWidget{
  get value => null;

  Widget build(BuildContext context){
    return Form(
      child: Center(
        child: Container(
            width: 400,
            child: TextFormField(
              initialValue:"Https://",
                decoration: const InputDecoration(
                    labelText: "Enter your FFE",
                    hintText: "Enter lien",
                    border: OutlineInputBorder()
                ),
                validator: (value){
                  if (value!.isEmpty){
                    return "Invalid phone number";
                  }
                  return null;
                }
            ),
            ),
        ),
    );
  }
}


