import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_connect/screens/HomeScreen/homeScreen.dart';

class PetRegistration extends StatefulWidget {
  const PetRegistration({super.key});

  @override
  State<PetRegistration> createState() => _PetRegistrationState();
}

class _PetRegistrationState extends State<PetRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ownernameController = TextEditingController();
  final TextEditingController _petnameController = TextEditingController();
  final TextEditingController _petbreedController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _microchipNumberController =
      TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _emergencyContactNoController =
      TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? _selectedPetType;
  String? _selectedPetGenderType;

  bool _imageUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        title: Text('Registration',
            style: TextStyle(color: Colors.white, fontFamily: 'gilroy')),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Pet Registration',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffFFB13D),
                    fontFamily: 'Gilroy',
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Fill out this registration form & generate the QR',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Gilroy',
                  ),
                ),
                SizedBox(height: 40.0),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _ownernameController,
                  decoration: const InputDecoration(
                    labelText: 'Owner Name',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: (value) {
                    // Remove non-alphabetic characters and allow space
                    _ownernameController.value = _ownernameController.value.copyWith(
                      text: value.replaceAll(RegExp(r'[^a-zA-Z\s]'), ''),
                      selection: TextSelection.collapsed(offset: value.length),
                      composing: TextRange.empty,
                    );
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _petnameController,
                  decoration: const InputDecoration(
                    labelText: 'Pet Name',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: (value) {
                    // Remove non-alphabetic characters and allow space
                    _petnameController.value = _petnameController.value.copyWith(
                      text: value.replaceAll(RegExp(r'[^a-zA-Z\s]'), ''),
                      selection: TextSelection.collapsed(offset: value.length),
                      composing: TextRange.empty,
                    );
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Pet is a ',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    value: _selectedPetType,
                    items: ['Dog', 'Cat', 'Bird', 'Rabbit', 'Others']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    style: TextStyle(color: Colors.white), // Set text color
                    dropdownColor:
                        Colors.black, // Set dropdown background color
                    onChanged: (String? value) {
                      setState(() {
                        _selectedPetType = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Pet Gender',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    value: _selectedPetGenderType,
                    items: ['Male', 'Female'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    style: TextStyle(color: Colors.white), // Set text color
                    dropdownColor:
                        Colors.black, // Set dropdown background color
                    onChanged: (String? value) {
                      setState(() {
                        _selectedPetGenderType = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Textfield for pet height
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Pet Height (in cm)',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Pet Weight (in kg)',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _microchipNumberController,
                  decoration: InputDecoration(
                    labelText: 'Microchip Number',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 15,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty || value.length != 15) {
                      return 'Microchip number must be 15 digits long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _petbreedController,
                  decoration: const InputDecoration(
                    labelText: 'Pet Breed',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: (value) {
                    // Remove non-alphabetic characters and allow space
                    _petbreedController.value = _petbreedController.value.copyWith(
                      text: value.replaceAll(RegExp(r'[^a-zA-Z\s]'), ''),
                      selection: TextSelection.collapsed(offset: value.length),
                      composing: TextRange.empty,
                    );
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _notesController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null, 
                  maxLength: 500, 
                  decoration: InputDecoration(
                    labelText: 'Some distinctive marks in pet',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _contactNoController,
                  decoration: const InputDecoration(
                    labelText: 'Contact No.',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _emergencyContactNoController,
                  decoration: const InputDecoration(
                    labelText: 'Emergency Contact No.',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _uploadImage,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Color(0xffFFB13D),
                  ),
                  child: const Text(
                    'Upload Image',
                    style: TextStyle(
                      fontFamily: 'gilroy',
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                if (_imageUploaded)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Your image has been successfully uploaded', // Display this message
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'gilroy',
                          fontSize: 14),
                      textAlign: TextAlign.start,
                    ),
                  ),
                SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Color(0xffFFB13D),
                  ),
                  onPressed: () {
                    print('the button is pressed');
                  },
                  child: const Text(
                    'Generate QR Code',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _uploadImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageData = await pickedFile.readAsBytes();
      setState(() {
        _imageUploaded = true;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dobController.text = picked.toString().substring(0, 10);
      });
    }
  }

  @override
  void dispose() {
    _ownernameController.dispose();
    _petnameController.dispose();
    _petbreedController.dispose();
    _contactNoController.dispose();
    _emergencyContactNoController.dispose();
    super.dispose();
  }
}
