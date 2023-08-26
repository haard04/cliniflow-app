import 'package:cliniflow/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class doctorPage extends StatefulWidget {
  final UserDetails userDetails;
  doctorPage({
    required this.userDetails,
    Key? key,
  }) : super(key: key);
  @override
  _doctorPageState createState() => _doctorPageState();
  
}

class _doctorPageState extends State<doctorPage> {

  
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  TextEditingController diseaseController = TextEditingController();
  TextEditingController prescriptionController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  bool isListening = false;

  int calculateAgeFromTimestamp(int timestamp) {
  DateTime currentDate = DateTime.now();
  DateTime birthDate = DateTime.fromMillisecondsSinceEpoch(timestamp);

  int age = currentDate.year - birthDate.year;

  if (currentDate.month < birthDate.month ||
      (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
    age--;
  }

  return age;
}

  void startListening(TextEditingController controller) async {
    if (!isListening) {
      bool available = await _speechToText.initialize();
      if (available) {
        _speechToText.listen(
          onResult: (result) {
            setState(() {
              controller.text = result.recognizedWords;
            });
          },
        );
        setState(() {
          isListening = true;
        });
      }
    }
  }

  void stopListening() {
    if (isListening) {
      _speechToText.stop();
      setState(() {
        isListening = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Record Form"),
        backgroundColor: Color(0xFF1976D2),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              color: Color(0xFF1976D2),
              child: Column(
                children: [
                  Icon(
                    Icons.local_hospital,
                    size: 50,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Medical Record Form",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Fill in the patient's information and medical details",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildInputField("Name:", widget.userDetails.name),
                  _buildInputField("Age:", calculateAgeFromTimestamp(widget.userDetails.dobMillis).toString()),
                  _buildInputField("Gender:", widget.userDetails.gender),
                  _buildInputArea(
                    "Disease:",
                    diseaseController,
                    "Enter disease details...",
                  ),
                  _buildInputArea(
                    "Prescription:",
                    prescriptionController,
                    "Enter prescription...",
                  ),
                  _buildInputArea(
                    "Notes:",
                    notesController,
                    "Enter notes...",
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    isListening ? "Listening..." : "Not Listening",
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF34495E),
            ),
          ),
          SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildInputArea(
      String label,
      TextEditingController controller,
      String hintText,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF34495E),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Color(0xFFCCC)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () => isListening ? stopListening() : startListening(controller),
                child: Icon(
                  isListening ? Icons.mic : Icons.mic_none,
                  size: 20,
                  color: isListening ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
