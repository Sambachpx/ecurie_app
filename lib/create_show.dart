import 'dart:io';

import 'package:ecurie_app/Notifier/DbManagement.dart';
import 'package:ecurie_app/db/class/Events.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecurie_app/db/db.dart';
import 'package:ecurie_app/user_profile.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:provider/provider.dart';
import 'background.dart';

class CreateShowPage extends StatefulWidget {
  @override
  _CreateShowPageState createState() => _CreateShowPageState();
}

class _CreateShowPageState extends State<CreateShowPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _dateAndTime;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Create a Show'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the show';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Address'),
                  controller: _addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the address of the show';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Date'),
                  readOnly: true,
                  controller: _dateController,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2022),
                    ).then((date) {
                      setState(() {
                        _dateAndTime = date;
                        _dateController.text =
                            _dateAndTime!.toIso8601String().substring(0, 10);
                      });
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the date of the show';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Upload Image'),
                ),
                _image == null
                    ? const Text(
                        'No image selected.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      )
                    : Image.file(_image!, width: 100, height: 100),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await _insertEvent();
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        const level = null;
                        const duration = null;
                        const discipline = null;
                        const participants = null;

                        final event = Events(
                            name: _nameController.text,
                            address: _addressController.text,
                            date: _dateAndTime,
                            level: level,
                            duration: duration,
                            discipline: discipline,
                            participants: participants,
                            image: _image);

                        await event.insertEvent(
                            MongoDatabase.instance(), DbCollection('events'));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'Show created',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfilePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Please fill in all fields',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Create Show'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _insertEvent() async {
    final name = _nameController.text;
    final address = _addressController.text;
    final date = _dateController.text;

    const level = null;
    const duration = null;
    const discipline = null;
    const participants = "";

    if (_formKey.currentState!.validate()) {
      try {
        await collection.insert(Event.insertEvent(
            MongoDatabase,
            event.getName,
            event.getAddress,
            event.getDate,
            event.getLevel,
            event.getDuration,
            event.getDiscipline,
            event.getParticipants,
            event.getImage) as Map<String, dynamic>);
      } catch (e) {
        print(e);
      }
    }
  }
}
