import 'package:flutter/material.dart';
import 'package:ecurie_app/user_profile.dart';

class CreateLessonPage extends StatefulWidget {
  const CreateLessonPage({Key? key}) : super(key: key);

  @override
  State<CreateLessonPage> createState() => _CreateLessonPageState();
}

class _CreateLessonPageState extends State<CreateLessonPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _location;
  DateTime? _dateAndTime;
  String? _duration;
  String? _discipline;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Create Lesson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: _location,
                decoration: InputDecoration(labelText: 'Location'),
                items: ['Carrière', 'Manège'].map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _location = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a location';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date'),
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
                decoration: InputDecoration(labelText: 'Time'),
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
              DropdownButtonFormField<String>(
                value: _duration,
                decoration: InputDecoration(labelText: 'Duration'),
                items: ['30min', '1h'].map((duration) {
                  return DropdownMenuItem(
                    value: duration,
                    child: Text(duration),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _duration = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a duration';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _discipline,
                decoration: InputDecoration(labelText: 'Discipline'),
                items: ['Dressage', 'Saut d\'obstacle', 'Endurance']
                    .map((discipline) {
                  return DropdownMenuItem(
                    value: discipline,
                    child: Text(discipline),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _discipline = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a discipline';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
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
                  child: Text('Create Lesson'),
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
}
