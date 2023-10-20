import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ecurie_app/user_profile.dart';
import 'package:image_picker/image_picker.dart';

class CreateShowPage extends StatefulWidget {
  const CreateShowPage({Key? key}) : super(key: key);

  @override
  State<CreateShowPage> createState() => _CreateShowPageState();
}

class _CreateShowPageState extends State<CreateShowPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _name;
  String? _address;
  DateTime? _dateAndTime;
  File? _image;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the show';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the address of the show';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _address = value;
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
                      if (_formKey.currentState!.validate() && _image != null) {
                        // Insert the data in the database here
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
                      } else if (_image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Please fill in all fields',
                                style: TextStyle(fontSize: 20)),
                          ),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateAndTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateAndTime = DateTime(picked.year, picked.month, picked.day,
            _dateAndTime?.hour ?? 0, _dateAndTime?.minute ?? 0);
        _dateController.text = _dateAndTime!.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dateAndTime ?? DateTime.now()),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateAndTime = DateTime(
          _dateAndTime?.year ?? DateTime.now().year,
          _dateAndTime?.month ?? DateTime.now().month,
          _dateAndTime?.day ?? DateTime.now().day,
          picked.hour,
          picked.minute,
        );
        final formattedTime =
            '${_dateAndTime!.hour.toString().padLeft(2, '0')}:${_dateAndTime!.minute.toString().padLeft(2, '0')}';
        _timeController.text = formattedTime;
      });
    }
  }

  Future _pickImageFromGallery() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
}
