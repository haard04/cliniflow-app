import 'dart:io';
import 'package:cliniflow/UserModel.dart';
import 'package:cliniflow/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class Pdfprescription{
  static Future<File> generateFile(UserDetails userDetails,String Disease,String Prescription,String Suggestions) async{
    final pdf = Document();
    pdf.addPage(MultiPage(
      maxPages: 1000,
     header: (context) => buildHeader(userDetails),
      pageFormat: PdfPageFormat(
        PdfPageFormat.a4.width,
        PdfPageFormat.a4.height,
      ),
      build: (context) => [
        

        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Prescription',style: TextStyle(font: Font.timesBold(),color: PdfColors.black,fontSize: 24),textAlign: TextAlign.center),
            ]
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Disease:',style: TextStyle(font: Font.timesBold(),color: PdfColors.black,fontSize: 20),textAlign: TextAlign.left),
            Text(Disease,style: TextStyle(color: PdfColors.black,fontSize: 20))
          ]
        ),),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text('Dignose:',style: TextStyle(font: Font.timesBold(),color: PdfColors.black,fontSize: 20),textAlign: TextAlign.left),
            Text(Prescription,style: TextStyle(color: PdfColors.black,fontSize: 20)),

          ]
        ),),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text('Precautions:',style: TextStyle(font: Font.timesBold(),color: PdfColors.black,fontSize: 20),textAlign: TextAlign.left),
            Text(Suggestions,style: TextStyle(color: PdfColors.black,fontSize: 20)),

          ]
        ),),
        Divider(),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Digitally Signed',style: TextStyle(color: PdfColors.black,fontSize: 16),textAlign: TextAlign.center),
            ]
          ),

        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('No Physical Signature Required',style: TextStyle(color: PdfColors.black,fontSize: 12),textAlign: TextAlign.center),
            ]
          ),

        
        
        
        
        
        
        
      ],
      footer: (context) => buildFooter(),
    ));

    return PdfApi.saveDocument(name: '${userDetails.name}.pdf', pdf: pdf);
  }
static int calculateAgeFromTimestamp(int timestamp) {
  DateTime currentDate = DateTime.now();
  DateTime birthDate = DateTime.fromMillisecondsSinceEpoch(timestamp);

  int age = currentDate.year - birthDate.year;

  if (currentDate.month < birthDate.month ||
      (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
    age--;
  }

  return age;
}

  
  static Widget buildHeader(UserDetails userDetails) => Container(
  
      child:Column(
        
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Apollo Hospital',style: TextStyle(fontSize: 20,font: Font.timesBold())),
            
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child:Text(' Plot No, 1A, Gandhinagar - Ahmedabad Rd, GIDC Bhat, estate, Ahmedabad, Gujarat 382428',textAlign: TextAlign.center,style: TextStyle(fontSize: 14,)), )
              
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('079 6670 1800,',style: TextStyle(fontSize: 14,)),
            ]
          ),
           
          Divider(),
          Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //  crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text('Patient Name- ${userDetails.name} ',style: TextStyle(fontSize: 16,font: Font.timesBold())),
                    Text('Age - ${calculateAgeFromTimestamp(userDetails.dobMillis)} ',style: TextStyle(fontSize: 16,font: Font.timesBold()),textAlign: TextAlign.right)
                ]
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text('Aadhar Number- ${userDetails.aadharNumber} ',style: TextStyle(fontSize: 16,font: Font.timesBold())),
                    Text('Contact Number - ${userDetails.contactNumber} ',style: TextStyle(fontSize: 16,font: Font.timesBold()))
                ]
              )
              
            ]
          ),
          ),
          
          
          Divider(),
        ]
      ),
      
  );

  static Widget buildFooter() => Padding(
    padding: const EdgeInsets.all(20.0),
    child:Container(
    
      child: Column(
        children: [
          Divider(),
          Text("*Terms & Condition Apply",style: const TextStyle(fontSize: 12)),
          Text('Apollo Hospitals',style: TextStyle(fontSize: 14,font: Font.timesBold())),
          Text("You will get 15% discount on purchasing from Apollo Pharmacy App",style: const TextStyle(fontSize: 12))
        ]
      )
      //
  ));
}