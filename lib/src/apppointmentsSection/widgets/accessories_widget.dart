import 'package:flutter/material.dart';

import '../../../common/utils/appcolors.dart';

class AccessoriesWidget extends StatelessWidget {
  const AccessoriesWidget(
      {Key? key, required this.text, required this.onTap, required this.color,  this.textcolor})
      : super(key: key);

  final String text;
  final Function(String) onTap;
  final Color color;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(text);
      },
      child: Container(
        height: 35,
        width: 90,
        margin: const EdgeInsets.only(left: 6, bottom: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: color),
        child: Center(
          child: Text(
            text,
            style:  TextStyle(
                // textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 10,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: textcolor),
          ),
        ),
      ),
    );
  }
}
