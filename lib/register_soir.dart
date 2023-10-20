import 'package:ecurie_app/Notifier/DbManagement.dart';
import 'package:ecurie_app/Notifier/SessionProvider.dart';
import 'package:ecurie_app/db/constants.dart';
import 'package:ecurie_app/db/db.dart';
import 'package:ecurie_app/user_profile.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ecurie_app/db/class/Events.dart';
import 'package:ecurie_app/db/constants.dart';
import 'package:ecurie_app/db/db.dart';
import 'package:flutter/material.dart';
import 'package:ecurie_app/user_profile.dart';

class CreatePartyPage extends StatefulWidget {
  const CreatePartyPage({Key? key}) : super(key: key);

  @override
  State<CreatePartyPage> createState() => _CreatePartyPageState();
}

class _CreatePartyPageState extends State<CreatePartyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _location;
  DateTime? _dateAndTime;
  String? _duration;
  String? _discipline;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    SessionProvider session = Provider.of<SessionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Create a Party'),
      ),
      body: Padding(
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
                controller: _locationController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the address of the show';
                  }
                  return null;
                },
                onSaved: (value) {
                  _location = value;
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _insertSoiree(appState.mongoDatabase);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Lesson created',
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
                  child: const Text('Create Lesson'),
                ),
              ),
            ],
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

  Future<void> _insertSoiree(MongoDatabase mongoDatabase) async {
    final name = _nameController.text;
    final date = _dateController.text;
    final time = _dateAndTime;
    final location = _location;
    const level = "";
    const duration = "";
    const type = 'Soiree';
    final discipline = _discipline;
    final participants = [];

    final collection = await mongoDatabase.getCollection(EVENTS_COLLECTION);
    final event = Event(type, name, time!, location!, DateTime.now(), level,
        duration, discipline, participants);

    if (_formKey.currentState!.validate()) {
      try {
        await collection.insert(event.insertEvent(
            mongoDatabase,
            collection,
            event.getEventType,
            event.getEventName,
            event.getEventDate,
            event.getEventLocation,
            event.getEventLevel,
            event.getEventDuration,
            event.getEventDiscipline,
            event.getEventParticipants,
            event.getEventCreatedAt) as Map<String, dynamic>);
      } catch (e) {
        print(e);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please fill in all fields',
                style: TextStyle(fontSize: 20)),
          ),
        );
      }
    }
  }
}