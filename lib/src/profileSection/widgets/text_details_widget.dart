import 'package:flutter/material.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';

class TextDetailsWidget extends StatelessWidget {
  final String staticText;
  final String dynamicText;

  const TextDetailsWidget(
      {Key? key, required this.staticText, required this.dynamicText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          staticText,
          style: fontW5S12(context)!.copyWith(
              fontSize: 13,
              color: AppColors.blackcolor.withOpacity(0.4),
              fontWeight: FontWeight.w700),
        ),
        Text(
          dynamicText,
          // userModel.professionalInformationModel!.professionalIdNumber
          //     .toString(),
          style: fontW5S12(context)!.copyWith(
              fontSize: 13,
              color: AppColors.blackcolor,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
