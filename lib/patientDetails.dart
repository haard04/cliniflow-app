import 'package:cliniflow/Doctorpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'UserModel.dart';

class patientDetails extends StatelessWidget {
  final TextEditingController dobController = TextEditingController();
  
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    Map<String, dynamic> toMap(newPatient) {
    return {
      'aadharNumber': newPatient.aadharNumber,
      'name': newPatient.name,
      'dobMillis': newPatient.dobMillis,
      'gender': newPatient.gender,
      'contactNumber': newPatient.contactNumber,
      'appointments': Appointment(appointmentId: 2, completed: false),
      
    };
    }
    
    if (picked != null) {
      dobController.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
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
              decoration: InputDecoration(labelText: 'Aadhar Number',),
              keyboardType: TextInputType.number,
              maxLength: 12,
              
            ),
            TextField(
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
              value: 'Male', // Default value
              onChanged: (newValue) {
                // Handle dropdown value change
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
              decoration: InputDecoration(labelText: 'Contact Number'),
              keyboardType: TextInputType.phone,
              maxLength: 10,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()async {
                // Handle submit button click
                UserDetails newPatient = UserDetails(
                aadharNumber: "123456789123"/* Get the Aadhar Number from TextField */,
                name: "Kashish"/* Get the Name from TextField */,
                dobMillis: 0/* Convert and store DOB in milliseconds */,
                gender:"male" /* Get the selected gender from DropdownButtonFormField */,
                contactNumber:"9876543210" /* Get the Contact Number from TextField */,
                appointments: [
                Appointment(appointmentId: 2, completed: false)
                
      ],
    );

    

    // await FirebaseFirestore.instance.collection('patients').add(newPatient.toMap(newPatient));
    print("SUCCESS");
              },
              child: Text('Submit'),
              
            ),
          ],
        ),
      ),
    );
  }
}
