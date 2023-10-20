import 'dart:io';

import 'package:flutter/material.dart';

class Event {
  String? theme;
  DateTime? date;
  String? address;
  String? type;
  bool? ifVerify;
  String? user;
  String? themeImage;
}

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => CreateEventPageState();
}

enum Theme { aperitif, meals }

class CreateEventPageState extends State<CreateEventPage> {
  String theme = 'Aperitif';
  final date = TextEditingController();
  final type = TextEditingController();
  final address = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _eventForm = Event();
  Theme? _theme = Theme.aperitif;
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          onChanged: () {
            setState(() {
              isValid = _formKey.currentState!.validate();
            });
          },
          child: Column(
            children: [
              DropdownButton<Theme>(
                value: _theme,
                items: [
                  DropdownMenuItem(
                    value: Theme.aperitif,
                    child: Text('Aperitif'),

                  ),
                  DropdownMenuItem(
                    value: Theme.meals,
                    child: Text('Meals'),
                  ),
                ],
                onChanged: (Theme? value) {
                  setState(() {
                    _theme = value;
                    theme = (value == Theme.aperitif) ? 'Aperitif' : 'Meals';

                    if (value == Theme.aperitif){
                      _eventForm.themeImage = "assets/images/apero.jpg";
                    }else if (value == Theme.meals){
                      _eventForm.themeImage = 'asset/images/meals.jpg' ;
                    }
                  });
                },
              ),
              Image.asset(_eventForm.themeImage ?? 'assets/images/apero.jpg'),
              TextFormField(
                controller: date,
                decoration: InputDecoration(
                  labelText: 'Event Date',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: type,
                decoration: InputDecoration(
                  labelText: 'Event Type',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Type required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: address,
                decoration: InputDecoration(
                  labelText: 'Event Address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address required';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: isValid ? createEvent : null,
                child: Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createEvent() {
    // Handle event creation logic here
  }
}

void main() {
  runApp(MaterialApp(
    home: CreateEventPage(),
  ));
}
