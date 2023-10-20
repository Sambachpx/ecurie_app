import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EditInfosPage extends StatefulWidget {
  const EditInfosPage({Key? key}) : super(key: key);

  @override
  _EditInfosPageState createState() => _EditInfosPageState();
}

class _EditInfosPageState extends State<EditInfosPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _ffeLinkController = TextEditingController();

  String? _username;
  String? _email;
  String? _age;
  String? _phoneNumber;
  String? _ffeLink;
  File? _image;

  // Add a global key for the FocusScope
  final FocusScopeNode _focusScope = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Edit Infos'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
                TextFormField(
                  controller: _ffeLinkController,
                  decoration: const InputDecoration(labelText: 'FFE Link'),
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Assign values to variables if the controllers are not empty
                      _username = _usernameController.text.isNotEmpty
                          ? _usernameController.text
                          : null;
                      _email = _emailController.text.isNotEmpty
                          ? _emailController.text
                          : null;
                      _age = _ageController.text.isNotEmpty
                          ? _ageController.text
                          : null;
                      _phoneNumber = _phoneNumberController.text.isNotEmpty
                          ? _phoneNumberController.text
                          : null;
                      _ffeLink = _ffeLinkController.text.isNotEmpty
                          ? _ffeLinkController.text
                          : null;

                      // Close the keyboard
                      _focusScope.unfocus();

                      // Now, you can use the variables _username, _email, _age, _phoneNumber, _ffeLink
                      // to save the updated information or perform any necessary actions
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Profile infos changed',
                              style: TextStyle(fontSize: 20)),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
