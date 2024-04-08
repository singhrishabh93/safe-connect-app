import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MedicalInformationPage extends StatefulWidget {
  @override
  _MedicalInformationPageState createState() => _MedicalInformationPageState();
}

class _MedicalInformationPageState extends State<MedicalInformationPage> {
  String? _bloodType;
  String? _bloodPressure;
  String? _allergies;
  String? _medications;
  bool _isOrganDonor = false;
  String? _medicalNotes;
  String? _disease;
  String? _immunizations;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bloodPressureController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloodPressureController.addListener(_formatBloodPressure);
  }

  @override
  void dispose() {
    _bloodPressureController.removeListener(_formatBloodPressure);
    _bloodPressureController.dispose();
    super.dispose();
  }

  void _formatBloodPressure() {
    String text = _bloodPressureController.text;
    if (text.length == 3 && !_bloodPressureController.text.contains('/')) {
      _bloodPressureController.text = '$text/';
      _bloodPressureController.selection = TextSelection.fromPosition(
          TextPosition(offset: _bloodPressureController.text.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _bloodType,
                onChanged: (String? newValue) {
                  setState(() {
                    _bloodType = newValue;
                  });
                },
                items: <String>[
                  'A+',
                  'A-',
                  'B+',
                  'B-',
                  'AB+',
                  'AB-',
                  'O+',
                  'O-'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Blood Type',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select blood type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _bloodPressureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Blood Pressure (mmHg)',
                ),
                onChanged: (value) {
                  _bloodPressure = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter blood pressure';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Allergies',
                ),
                onChanged: (value) {
                  _allergies = value;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Medications',
                ),
                onChanged: (value) {
                  _medications = value;
                },
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Text('Organ Donor:'),
                  Checkbox(
                    value: _isOrganDonor,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          _isOrganDonor = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Medical Notes',
                ),
                onChanged: (value) {
                  _medicalNotes = value;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Disease',
                ),
                onChanged: (value) {
                  _disease = value;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Immunizations',
                ),
                onChanged: (value) {
                  _immunizations = value;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    // Form is validated, you can proceed with submission
                    // You can access the values entered by the user using the variables (_bloodType, _bloodPressure, etc.)
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}