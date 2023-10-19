import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ecurie_app/user_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecurie_app/db/db.dart';
import 'package:ecurie_app/db/class/events.dart';
import 'package:ecurie_app/Notifier/DbManagement.dart';

class CreateShowPage extends StatefulWidget {
  const CreateShowPage({Key? key}) : super(key: key);

  @override
  State<CreateShowPage> createState() => _CreateShowPageState();
}

class _CreateShowPageState extends State<CreateShowPage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateController = TextEditingController();
  final _dateTimeController = TextEditingController();

  Future _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final appState = Provider.of<AppState>(context);
    return Scaffold(
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
                    _selectDate(context);
                  },
                  validator: (value) {
                    if (_dateAndTime == null) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Time'),
                  readOnly: true,
                  controller: _timeController,
                  onTap: () {
                    _selectTime(context);
                  },
                  validator: (value) {
                    if (_dateAndTime == null) {
                      return 'Please select a time';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  child: const Text('Upload Image'),
                ),
                _image == null
                    ? const Text('No image selected.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red))
                    : Image.file(_image!, width: 100, height: 100),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Show created',
                                style: TextStyle(fontSize: 20)),
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
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Please fill in all fields',
                                style: TextStyle(fontSize: 20)),
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

  Future<void>_register(MongoDatabase database) async {
        final name: _nameController.text;
        address: _addressController.text;
        date: _dateAndTime;
        image: _image);
    await database.insertEvent(event);
  }
}
