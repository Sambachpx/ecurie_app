import 'package:ecurie_app/Notifier/DbManagement.dart';
import 'package:ecurie_app/Notifier/SessionProvider.dart';
import 'package:ecurie_app/db/class/Horses.dart';
import 'package:ecurie_app/db/constants.dart';
import 'package:ecurie_app/db/db.dart';
import 'package:ecurie_app/user_profile.dart';
import 'package:flutter/material.dart';
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
                    "REGISTER",
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
                    decoration: const InputDecoration(labelText: "Username"),
                    controller: _nameController,
                    validator: (value) =>
                    value!.isEmpty ? 'Champ requis' : null,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Username"),
                    controller: _ageController,
                    validator: (value) =>
                    value!.isEmpty ? 'Champ requis' : null,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Username"),
                    controller: _robeController,
                    validator: (value) =>
                    value!.isEmpty ? 'Champ requis' : null,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Username"),
                    controller: _raceController,
                    validator: (value) =>
                    value!.isEmpty ? 'Champ requis' : null,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Username"),
                    controller: _sexeController,
                    validator: (value) =>
                    value!.isEmpty ? 'Champ requis' : null,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Username"),
                    controller: _specialiteController,
                    validator: (value) =>
                    value!.isEmpty ? 'Champ requis' : null,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                TextButton(
                  child: Text('Select Image'),
                  onPressed: _pickImageFromGallery,
                ),
                _image == null
                    ? const Text('No Image selected')
                    : Image.file(_image!),
                Container(
                  child:FloatingActionButton(
                    onPressed: () {
                      _addHorse(appState.mongoDatabase, session);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserProfilePage()),
                      );
                    }, child: null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addHorse(MongoDatabase mongoDatabase, SessionProvider session) async {
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
    Horses horses = Horses(mongo.ObjectId(),idowner,name, age, robe,race,sexe,specialite, idhorseman, created_at);
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
          horses.getHorseName,
          horses.getHorseAge,
          horses.getHorseRobe,
          horses.race,
          horses.sexe,
          horses.specialite,
          horses.idhorseman,
          horses.getHorseCreatedAt,) as Map<String, dynamic>);
      } catch (e) {
        print(e);
      }
    }
  }
}
