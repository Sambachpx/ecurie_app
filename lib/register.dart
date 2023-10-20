import 'package:ecurie_app/Notifier/DbManagement.dart';
import 'package:ecurie_app/Notifier/SessionProvider.dart';
import 'package:ecurie_app/db/class/Users.dart';
import 'package:ecurie_app/db/db.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:provider/provider.dart';
import 'login.dart';
import 'background.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final emailRegex = RegExp(r'^[\w-.]+@([\w-]+.)+[\w-]{2,4}$');

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
                    controller: _usernameController,
                    validator: (value) =>
                        value!.isEmpty ? 'Champ requis' : null,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Email"),
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Champ requis';
                      } else if (!emailRegex.hasMatch(value)) {
                        return 'Adresse email invalide';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Password"),
                    controller: _passwordController,
                    validator: (value) =>
                        value!.isEmpty ? 'Champ requis' : null,
                    obscureText: true,
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
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _register(appState.mongoDatabase, session);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: const Text(
                        "SIGN UP",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()))
                    },
                    child: const Text(
                      "Already Have an Account? Sign in",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2661FA)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _register(
      MongoDatabase mongoDatabase, SessionProvider session) async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final cryptPassword = base64.encode(utf8.encode(password));
    String image = "/";
    String number = "";
    int age = 0;
    String link = "";
    String role = "user";
    DateTime created_at = DateTime.now();
    Users user = Users(mongo.ObjectId(), username, email, password, image,
        number, age, link, role, created_at);
    final collection = await mongoDatabase.getCollection('users');
    //final existUser = user.getUserByUsername(mongoDatabase, collection, user.getUserName);

    if (_formKey.currentState!.validate()) {
      // if(existUser != null){
      // }
      //await collection.updateOne({"username" : "jeff"},{"age" : 5});
      try {
        session.setUser(user);
        await collection.insert(user.insertUser(
          mongoDatabase,
          collection,
          user.getUserId,
          user.getUserName,
          user.getUserEmail,
          cryptPassword,
          user.getUserImage,
          user.getUserNumber,
          user.getUserAge,
          user.getUserLink,
          user.getUserRole,
          user.getUserCreatedAt,
        ) as Map<String, dynamic>);
      } catch (e) {
        print(e);
      }
    }
  }
}
