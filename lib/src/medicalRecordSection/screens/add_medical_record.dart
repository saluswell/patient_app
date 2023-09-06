import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../res.dart';
import '../../apppointmentsSection/models/appointmentModel.dart';
import '../../apppointmentsSection/widgets/dateTimeTileWidget.dart';
import '../providers/medicalRecordProvider.dart';
import '../widgets/dropdown_widget.dart';
import '../widgets/fileTile.dart';

class AddMedicalRecord extends StatefulWidget {
  final AppointmentModel appointmentModel;

  const AddMedicalRecord({Key? key, required this.appointmentModel})
      : super(key: key);

  @override
  State<AddMedicalRecord> createState() => _AddMedicalRecordState();
}

class _AddMedicalRecordState extends State<AddMedicalRecord> {
  var items = [
    'Seats',
    '1',
    '2',
    '3',
    '4',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicalRecordProvider>(
        builder: (context, medicalRecordProvider, __) {
      return LoadingOverlay(
        isLoading: medicalRecordProvider.isLoading,
        progressIndicator: const SpinKitPouringHourGlass(
          size: 30,
          color: AppColors.appcolor,
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.whitecolor,
            elevation: 4,
            centerTitle: true,
            title: Text(
              " Add Medical Record",
              style: fontW5S12(context)!.copyWith(
                  fontSize: 16,
                  color: AppColors.blackcolor,
                  fontWeight: FontWeight.w600),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.maybePop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.blackcolor,
                )),
          ),
          floatingActionButton: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: InkWell(
                    onTap: () async {
                      medicalRecordProvider.createMedicalRecord(
                          widget.appointmentModel.patientId.toString(),
                          widget.appointmentModel.dietitianId.toString(),
                          widget.appointmentModel.appointmentId.toString());
                      //   toNext(context: context, widget: ConfirmAppointment());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.appcolor,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      height: 60,
                      child: Center(
                        child: Text(
                          "Upload Record",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 16,
                              color: AppColors.whitecolor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Record Type",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 14,
                          color: AppColors.blackcolor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: CustomDropDownWidget(
                            value: medicalRecordProvider.recordType == null
                                ? "Record Type"
                                : medicalRecordProvider.recordType.toString(),
                            list: medicalRecordProvider.recordvarList,
                            onChanged: (value) {
                              medicalRecordProvider.updateRecordVarValue(value);
                            },
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Record Date",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 14,
                          color: AppColors.blackcolor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                DateTimeTileWidget(
                  selectedTime: medicalRecordProvider.recordDate == null
                      ? "Please Select Record Date"
                      : medicalRecordProvider.recordDate!
                          .format(DateFormats.american),
                  selectTime: () {
                    medicalRecordProvider.showDatepicker();
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Upload Record Images",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 14,
                          color: AppColors.blackcolor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      IgnorePointer(
                        ignoring:
                            medicalRecordProvider.recordImagesList.length >= 5
                                ? true
                                : false,
                        child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) => SimpleDialog(
                                        title: const Text(
                                          "Select Docs",
                                          style: TextStyle(
                                              color: AppColors.whitecolor),
                                        ),
                                        children: [
                                          Row(
                                            children: [
                                              SimpleDialogOption(
                                                child: Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.image,
                                                      color:
                                                          AppColors.whitecolor,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Gallery",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .whitecolor),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  //
                                                  medicalRecordProvider
                                                      .pickMedicalRecordImages(
                                                          context,
                                                          ImageSource.gallery);
                                                  Navigator.pop(context);
                                                  //
                                                },
                                              ),
                                              SimpleDialogOption(
                                                child: Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.camera_alt,
                                                      color:
                                                          AppColors.whitecolor,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Camera",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .whitecolor),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  medicalRecordProvider
                                                      .pickMedicalRecordImages(
                                                          context,
                                                          ImageSource.camera);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      )));
                              // carProvider.pickCarImages(context);
                            },
                            child: SvgPicture.asset(Res.uploadicon,
                                color: medicalRecordProvider
                                            .recordImagesList.length >=
                                        5
                                    ? Colors.grey
                                    : AppColors.appcolor)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Upload Record Images",
                          style: fontW4S12(context)?.copyWith(fontSize: 10)),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                          medicalRecordProvider.recordImagesList.isEmpty
                              ? "(1 Record image required)"
                              : "",
                          style: fontW4S12(context)
                              ?.copyWith(fontSize: 10, color: Colors.red)),
                    ],
                  ),
                ),
                if (medicalRecordProvider.recordImagesList.isNotEmpty)
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
                              medicalRecordProvider.recordImagesList.length,
                          itemBuilder: (_, i) {
                            return FileTile(
                              onTap: () {
                                medicalRecordProvider
                                    .removefromMedicalRecordImages(i);
                              },
                              path: medicalRecordProvider.recordImagesList[i],
                            );
                          }),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
