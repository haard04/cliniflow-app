import 'package:cliniflow/Doctorpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'UserModel.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class patientDetails extends StatelessWidget {
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String selectedGender = 'Male'; // Default value
  final TextEditingController contactController = TextEditingController();
  int dobMillis = 0;
   int appointmentCounter = 1;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dobController.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
          dobMillis = picked.millisecondsSinceEpoch;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Details')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: aadharController,
              decoration: InputDecoration(labelText: 'Aadhar Number'),
              keyboardType: TextInputType.number,
              maxLength: 12,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: dobController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth (DD/MM/YYYY)',
                  ),
                ),
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedGender,
              onChanged: (newValue) {
                selectedGender = newValue!;
              },
              items: ['Male', 'Female', 'Other']
                  .map<DropdownMenuItem<String>>(
                    (gender) => DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    ),
                  )
                  .toList(),
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: contactController,
              decoration: InputDecoration(labelText: 'Contact Number'),
              keyboardType: TextInputType.phone,
              maxLength: 10,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Handle submit button click
                UserDetails newPatient = UserDetails(
                  aadharNumber: aadharController.text,
                  name: nameController.text,
                  dobMillis: dobMillis, // You need to convert this to milliseconds as required
                  gender: selectedGender,
                  contactNumber: contactController.text,
                  appointments: [
                    Appointment(appointmentId: appointmentCounter, completed: false),
                  ],
                );

                CollectionReference patientCollection = FirebaseFirestore.instance.collection('patients');
                await patientCollection.add(newPatient.toMap());
                appointmentCounter++;
                print("SUCCESS");
                AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.success,
                  title: 'Appointment Booked Successfully',
                  desc:   'Your Appointment Number is ${appointmentCounter-1}',
                  btnOkOnPress: () {},
                ).show();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
