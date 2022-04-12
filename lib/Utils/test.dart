// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:csv/csv.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testttttt/UI/Widgets/customfab.dart';
import 'package:testttttt/Utils/responsive.dart';

// class OpenCSV extends StatefulWidget {

//   @override
//   State<OpenCSV> createState() => _OpenCSVState();
// }

// class _OpenCSVState extends State<OpenCSV> {
//   late List<List<dynamic>> employeeData=[];
//   late PlatformFile selectedFile;
//   Future selectCSVFile() async{
//     FilePickerResult? result= await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       withData: true,
//       type: FileType.custom,
//       allowedExtensions: ['csv']
//     );
//     if(result!=null){
//       selectedFile=result.files.first;
//     }
  
//   List csvList=[];
//   List csvFileContentList=[];
//   List CsvModuleList=[];

   
//     String csvFileHeaderRowColumnTitles="Field1,Field2";
    
//       String s= String.fromCharCodes(selectedFile.bytes!);
//       var outputAsUint8List= Uint8List.fromList(s.codeUnits);
//       csvFileContentList=utf8.decode(outputAsUint8List).split(" ");
      
      
//       //  if (csvFileContentList.length == 0 ||
//       //       csvFileContentList[1].length == 0) {
//       //     // CSV file does not have content
//       //     print('CSV file has no content');
//       //     return 'Error: The CSV file has no content.';
        
    
//   }

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   List<PlatformFile>? _paths;
//   String? _extension="csv";
//   FileType _pickingType = FileType.custom;
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Container(
//         width: width,
//         child: Column(
//           children: [
//             InkWell(
//                                 onTap: () async{
//                                   selectCSVFile();
//                                 },
//                                 child: customfab(
//                                             width: width,
//                                             text: "Import CSV File",
//                                             height: height,
//                                           ),
//                               ),
//                               SizedBox(
//                                 height: height*0.03,
//                               ),
//                               ListView.builder(
//     shrinkWrap: true,
//     itemCount: employeeData.length,
//     itemBuilder: (context,index){
//       return Card(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(employeeData[index][0]),
//               Text(employeeData[index][1]),
//               Text(employeeData[index][2]),
//             ],
//           ),
//         ),
//       );
//     }),
//           ],
//         ),
//       ),
//     );
//   }
// }