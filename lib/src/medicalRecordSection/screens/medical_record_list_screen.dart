import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../res.dart';
import '../../apppointmentsSection/models/appointmentModel.dart';
import '../models/medical_record_model.dart';
import '../services/medical_record_services.dart';
import '../widgets/medicalRecordWidget.dart';
import 'add_medical_record.dart';

class MedicalRecordListScreen extends StatefulWidget {
  final AppointmentModel appointmentModel;

  const MedicalRecordListScreen({Key? key, required this.appointmentModel})
      : super(key: key);

  @override
  State<MedicalRecordListScreen> createState() =>
      _MedicalRecordListScreenState();
}

class _MedicalRecordListScreenState extends State<MedicalRecordListScreen> {
  MedicalRecordServices medicalRecordServices = MedicalRecordServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () async {
                  toNext(
                      context: context,
                      widget: AddMedicalRecord(
                        appointmentModel: widget.appointmentModel,
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.appcolor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  height: 60,
                  child: Center(
                    child: Text(
                      "Add Medical Record",
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
      appBar: AppBar(
        backgroundColor: AppColors.whitecolor,
        elevation: 4,
        centerTitle: true,
        title: Text(
          "Medical Records",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            StreamProvider.value(
                value: medicalRecordServices.streamMedicalRecords(
                    widget.appointmentModel.dietitianId.toString(),
                    widget.appointmentModel.appointmentId.toString()),
                initialData: [MedicalRecordModel()],
                builder: (context, child) {
                  List<MedicalRecordModel> medicalRecordList =
                      context.watch<List<MedicalRecordModel>>();
                  return medicalRecordList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 150,
                              ),
                              Image.asset(
                                Res.medicaladd,
                                height: 60,
                                width: 60,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "All your medical Records in one place! ",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Add Records!",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      : medicalRecordList[0].appointmentId == null
                          ? const Center(
                              child: SpinKitPouringHourGlass(
                                size: 30,
                                color: AppColors.appcolor,
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: medicalRecordList.length,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(),
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: MedicalRecordWidget(
                                        medicalRecordModel:
                                            medicalRecordList[index],
                                      ),
                                    );
                                  })),
                            );
                }),
            const SizedBox(
              height: 120,
            )
          ],
        ),
      ),
    );
  }
}
