import 'package:cliniflow/Doctorpage.dart';
import 'package:cliniflow/patientDetails.dart';
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => doctorPage(),));
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

}