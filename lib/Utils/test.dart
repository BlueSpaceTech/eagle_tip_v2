import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testttttt/Services/authentication_helper.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/Utils/responsive.dart';

class OpenCSV extends StatefulWidget {

  @override
  State<OpenCSV> createState() => _OpenCSVState();
}

class _OpenCSVState extends State<OpenCSV> {
  List inviteData=[];
  List<PlatformFile>? _paths;
  String? _extension="csv";
  FileType _pickingType = FileType.custom;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        child: Column(
          children: [
            InkWell(
                                onTap: () async{FilePickerResult? csvFile= await FilePicker.platform.pickFiles(allowedExtensions: ['csv'],           type: FileType.custom,allowMultiple: false);
                                if(csvFile!=null){
 final bytes = utf8.decode(csvFile.files[0].bytes!.toList());                              
           List<List<dynamic>> rowsAsListOfValues  = const  CsvToListConverter().convert(bytes);
                for(int i=1;i<rowsAsListOfValues.length;i++){
                    setState(() {
                      inviteData.add(rowsAsListOfValues.elementAt(i));
                    });
                  
                }
                print(inviteData.length);
                print(inviteData);
                // for(int i=0;i<inviteData.length;i++){
                //   for(int j=0;j<inviteData.elementAt(i).length;j++){
                //     AuthFunctions().addUserTodb(
                //               name: inviteData.elementAt(i)[0],
                //               email: inviteData.elementAt(i)[],
                //               phonenumber: _phone.text,
                //               userRole: widget.role,
                //               phoneisverified: false,
                //               sites: widget.sites,
                //             );
                //   }
                // }

}
                                },
                                child: customfab(
                                            width: width,
                                            text: "Import CSV File",
                                            height: height,
                                          ),
                              ),
                              SizedBox(
                                height: height*0.03,
                              ),
                              ListView.builder(
    shrinkWrap: true,
    itemCount: inviteData.length,
    itemBuilder: (context,index){
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(inviteData[index][0],style: TextStyle(color: Colors.black),),
              Text(inviteData[index][1],style: TextStyle(color: Colors.black),),
              Text(inviteData[index][2],style: TextStyle(color: Colors.black),),
              Text(inviteData[index][3].toString(),style: TextStyle(color: Colors.black),),
            ],
          ),
        ),
      );
    }),
          ],
        ),
      ),
    );
  }
}