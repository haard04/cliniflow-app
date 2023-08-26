import 'package:cliniflow/Doctorpage.dart';
import 'package:cliniflow/UserModel.dart';
import 'package:cliniflow/patientDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class nav extends StatelessWidget {
  const nav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to CliniFlow'),
      ),
      body: Center(
        child: Container(
          width: 320, // Adjust the width as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCardButton1(context, Icons.person, 'Doctor Profile', Colors.blue),
              SizedBox(height: 20),
              _buildCardButton2(context, Icons.people, 'Reception', Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardButton1(BuildContext context, IconData icon, String title, Color color) {
    TextEditingController aadharNumberController = TextEditingController(); // Controller for the input field

    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // Handle button tap here

          showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Enter Aadhar Number'),
              content: TextField(
                controller: aadharNumberController,
                keyboardType: TextInputType.number,
                maxLength: 12,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: ()async {
                    // Navigate to doctorPage with the provided appointment number
                    int aadharNumber = int.tryParse(aadharNumberController.text) ?? 1;
                    UserDetails userDetails = await fetchUserDetails(aadharNumber.toString());
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => doctorPage(
                        userDetails: userDetails,
                      )),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    
    );
  }

  Widget _buildCardButton2(BuildContext context, IconData icon, String title, Color color) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // Handle button tap here
          Navigator.push(context, MaterialPageRoute(builder: (context) => patientDetails(),));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    
    );
  }
Future<UserDetails> fetchUserDetails(String aadharNumber) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('patients')
    .where('aadharNumber', isEqualTo: aadharNumber)
    .get();

    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

      // Assuming appointments is a List of maps
      List<Map<String, dynamic>> appointments = List<Map<String, dynamic>>.from(userData['appointments']);

      // Sort appointments by appointmentId in descending order
      appointments.sort((a, b) => b['appointmentId'].compareTo(a['appointmentId']));

      // Fetch the latest appointment ID
      int latestAppointmentId = appointments.isNotEmpty ? appointments.first['appointmentId'] : -1;

      UserDetails userDetails = UserDetails(
        aadharNumber: userData['aadharNumber'],
        name: userData['name'],
        dobMillis: userData['dobMillis'],
        gender: userData['gender'],
        contactNumber: userData['contactNumber'],
        appointments: [
          Appointment(appointmentId: latestAppointmentId, completed: appointments[0]['completed']),
        ],
      );
      return userDetails;
    } else {
      throw Exception('UserDetails not found for Aadhar number $aadharNumber');
    }
  } catch (error) {
    throw error;
  }
}


}