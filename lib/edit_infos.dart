import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                    if (_formKey.currentState!.validate()) {
                      // Assign values to variables if the controllers are not empty
                      _username = _usernameController.text.isNotEmpty
                          ? _usernameController.text
                          : null;
                      _email = _emailController.text.isNotEmpty
                          ? _emailController.text
                          : null;
                      _age = _ageController.text.isNotEmpty ? _ageController.text : null;
                      _phoneNumber = _phoneNumberController.text.isNotEmpty
                          ? _phoneNumberController.text
                          : null;
                      _ffeLink = _ffeLinkController.text.isNotEmpty
                          ? _ffeLinkController.text
                          : null;

                      // Now, you can use the variables _username, _email, _age, _phoneNumber, _ffeLink
                      // to save the updated information or perform any necessary actions

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
}
