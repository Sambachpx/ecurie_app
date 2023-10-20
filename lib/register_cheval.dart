import 'package:ecurie_app/Notifier/DbManagement.dart';
import 'package:ecurie_app/Notifier/SessionProvider.dart';
import 'package:ecurie_app/db/class/Horses.dart';
import 'package:ecurie_app/db/constants.dart';
import 'package:ecurie_app/db/db.dart';
import 'package:ecurie_app/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:provider/provider.dart';
import 'login.dart';
import 'background.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class RegisterChevalPage extends StatefulWidget {
  @override
  _RegisterChevalState createState() => _RegisterChevalState();
}

class _RegisterChevalState extends State<RegisterChevalPage> {
  final _formKey = GlobalKey<FormState>();
  String? _dress;
  String? _breed;
  String? _sex;
  String? _speciality;
  File? _image;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _robeController = TextEditingController();
  final _raceController = TextEditingController();
  final _sexeController = TextEditingController();
  final _specialiteController = TextEditingController();

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
    SessionProvider session = Provider.of<SessionProvider>(context);

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: const Text(
                    "Register Horse",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 36),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Name of the horse"),
                    controller: _nameController,
                    validator: (value) =>
                        value!.isEmpty ? 'Please select a name' : null,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Age of the horse'),
                    controller: _ageController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (value) =>
                        value!.isEmpty ? 'Please select an age' : null,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: DropdownButtonFormField<String>(
                    value: _dress,
                    decoration: const InputDecoration(labelText: 'Horse dress'),
                    items: [
                      'Mouse',
                      'White',
                      'Gray',
                      'Appolesa',
                      'Pie',
                      'Isabelle'
                    ].map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _dress = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a dress';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: DropdownButtonFormField<String>(
                    value: _breed,
                    decoration: const InputDecoration(labelText: 'Horse breed'),
                    items: [
                      'Mouse',
                      'White',
                      'Gray',
                      'Appolesa',
                      'Pie',
                      'Isabelle'
                    ].map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _breed = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a breed';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: DropdownButtonFormField<String>(
                    value: _sex,
                    decoration:
                        const InputDecoration(labelText: 'Sex of the horse'),
                    items: ['Male', 'Female'].map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _sex = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a sex';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: DropdownButtonFormField<String>(
                    value: _speciality,
                    decoration:
                        const InputDecoration(labelText: 'Horse speciality'),
                    items: ['Dressage', 'Saut d\'obstacle', 'Endurance']
                        .map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _speciality = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a speciality';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.03),
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
                            content: Text('Horse registered',
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
                    child: const Text('Register a horse'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addHorse(
      MongoDatabase mongoDatabase, SessionProvider session) async {
    final name = _nameController.text;
    final age = int.parse(_ageController.text);
    final robe = _robeController.text;
    final race = _raceController.text;
    final sexe = _sexeController.text;
    final specialite = _specialiteController.text;
    String image = "/";
    int idowner = 0;
    String number = "";
    List idhorseman = [];
    String link = "";
    DateTime created_at = DateTime.now();
    Horses horses = Horses(mongo.ObjectId(), idowner, name, age, robe, race,
        sexe, specialite, idhorseman, created_at);
    final collection = await mongoDatabase.getCollection(HORSE_COLLECTION);
    //final existUser = user.getUserByUsername(mongoDatabase, collection, user.getUserName);

    if (_formKey.currentState!.validate()) {
      // if(existUser != null){
      // }
      //await collection.updateOne({"username" : "jeff"},{"age" : 5});
      try {
        await collection.insert(horses.insertHorse(
          mongoDatabase,
          collection,
          horses.getHorseId,
          horses.getIdowner,
          horses.getHorseName,
          horses.getHorseAge,
          horses.getHorseRobe,
          horses.race,
          horses.sexe,
          horses.specialite,
          horses.idhorseman,
          horses.getHorseCreatedAt,
        ) as Map<String, dynamic>);
      } catch (e) {
        print(e);
      }
    }
  }
}
