import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../res.dart';

class DropDownWidget extends StatefulWidget {
  final String text;
  final Function(String) onTap;
  final Icon icon;

  const DropDownWidget({
    Key? key,
    required this.text,
    required this.onTap, required this.icon,
  }) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: widget.onTap(widget.text),
          child: widget.icon
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          widget.text,
          style: fontW5S12(context)!.copyWith(
              fontSize: 13,
              color: AppColors.blackcolor,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
