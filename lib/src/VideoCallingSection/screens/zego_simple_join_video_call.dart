import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ZegoSimpleJoinVideoCallPage extends StatelessWidget {
  final String callID;
  final String dietitanID;
  final String myUserID;

  const ZegoSimpleJoinVideoCallPage({
    Key? key,
    required this.callID,
    required this.dietitanID,
    required this.myUserID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 1826079009,
        appSign:
            "68819f495caffa0e72e92a1937c0dd614524e077418d51c6d392a3546e8134cd",
        userID: myUserID,
        userName: "user_$myUserID",
        callID: callID,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..onOnlySelfInRoom = (context) {
            Navigator.of(context).pop();
          },
      ),
    );
  }
}
