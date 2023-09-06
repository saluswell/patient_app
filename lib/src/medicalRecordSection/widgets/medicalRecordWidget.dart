import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../models/medical_record_model.dart';
import '../services/medical_record_services.dart';
import 'fileNetworkimageTile.dart';

class MedicalRecordWidget extends StatefulWidget {
  final MedicalRecordModel medicalRecordModel;

  const MedicalRecordWidget({Key? key, required this.medicalRecordModel})
      : super(key: key);

  @override
  State<MedicalRecordWidget> createState() => _MedicalRecordWidgetState();
}

class _MedicalRecordWidgetState extends State<MedicalRecordWidget> {
  MedicalRecordServices medicalRecordServices = MedicalRecordServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      // width: 400,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
            side: BorderSide(width: 1, color: AppColors.appcolor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.medicalRecordModel.recordDate!
                        .toDate()
                        .format(DateFormats.american),
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 14,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w600),
                  ),

                  // IconButton(
                  //     onPressed: () async {
                  //       return await showDialog(
                  //           barrierDismissible: false,
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return AlertDialog(
                  //               backgroundColor: AppColors.whitecolor,
                  //               content: SizedBox(
                  //                 height: 100,
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     const Text(
                  //                       "Are you sure you want to delete this record?",
                  //                       style: TextStyle(
                  //                           color: AppColors.blackcolor,
                  //                           fontWeight: FontWeight.w500),
                  //                     ),
                  //                     const SizedBox(height: 20),
                  //                     Row(
                  //                       children: [
                  //                         Expanded(
                  //                           child: ElevatedButton(
                  //                             onPressed: () {
                  //                               medicalRecordServices
                  //                                   .deleteMedicalRecord(widget
                  //                                       .medicalRecordModel
                  //                                       .recordId
                  //                                       .toString())
                  //                                   .then((value) {
                  //                                 Navigator.pop(context);
                  //                                 showSnackBarMessage(
                  //                                     context: context,
                  //                                     content:
                  //                                         "Medical Record Deleted Successfully");
                  //                               });
                  //
                  //                               pe(msg: "yes selected");
                  //                             },
                  //                             child: const Text("Yes"),
                  //                             style: ElevatedButton.styleFrom(
                  //                                 primary: Colors.red.shade800),
                  //                           ),
                  //                         ),
                  //                         const SizedBox(width: 15),
                  //                         Expanded(
                  //                             child: ElevatedButton(
                  //                           onPressed: () {
                  //                             pe(msg: "no selected");
                  //                             Navigator.of(context).pop();
                  //                           },
                  //                           child: Text("No",
                  //                               style: TextStyle(
                  //                                   color: Colors.white)),
                  //                           style: ElevatedButton.styleFrom(
                  //                             primary: Colors.grey,
                  //                           ),
                  //                         ))
                  //                       ],
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           });
                  //     },
                  //     icon: Icon(
                  //       Icons.delete,
                  //       color: AppColors.redcolor,
                  //     ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Record Type",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 14,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.medicalRecordModel.recordType.toString(),
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 13,
                        color: AppColors.blackcolor.withOpacity(0.6),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Record Images",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 14,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                    padding: const EdgeInsets.only(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        widget.medicalRecordModel.recordImagesList!.length,
                    itemBuilder: (_, i) {
                      return FileNetwokImageTile(
                        onTap: () {
                          // medicalRecordProvider
                          //     .removefromMedicalRecordImages(i);
                        },
                        path: widget.medicalRecordModel.recordImagesList![i],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
