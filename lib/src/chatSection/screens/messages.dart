import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/widgets/cacheNetworkImageWidget.dart';
import '../../../res.dart';
import '../../notificationSection/services/notification_handler.dart';
import '../models/message.dart';
import '../models/message_details.dart';
import '../services/chat.dart';

class MessagesView extends StatefulWidget {
  final String myID;
  final String receiverID;
  final String name;
  final String image;

  MessagesView({
    required this.receiverID,
    required this.myID,
    required this.name,
    required this.image,
  });

  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  ChatServices _chatServices = ChatServices();

  TextEditingController messageController = TextEditingController();

  ScrollController _scrollController = new ScrollController();
  int listLength = 0;
  bool callSetLength = true;

  void setLength(int i) {
    listLength = i;
    callSetLength = false;
    setState(() {});
  }

  int get getLength => listLength;

  @override
  initState() {
    markMessageAsRead(uid: getUserID, list: getList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.receiverID);
    print(widget.myID);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 2,
        backgroundColor: AppColors.whitecolor,
        centerTitle: false,

        leading: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: InkWell(
              onTap: () {
                Navigator.maybePop(context);
              },
              child: const SizedBox(
                height: 45,
                width: 45,
                child: Card(
                  color: AppColors.whitecolor,
                  elevation: 4,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                        bottom: 4,
                        top: 4,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.appcolor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        title: Row(
          children: [
            CacheNetworkImageWidget(
              height: 35,
              width: 35,
              imgUrl: widget.image,
              radius: 33,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.name,
              style: const TextStyle(
                  color: AppColors.blackcolor, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        // actions: [
        //   Container(
        //     height: 50,
        //     width: 50,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(7),
        //     ),
        //     child: Center(
        //       child: SvgPicture.asset(Res.audioicon),
        //     ),
        //   ),
        //   Container(
        //     height: 50,
        //     width: 50,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(7),
        //     ),
        //     child: Center(
        //       child: SvgPicture.asset(Res.videoicon),
        //     ),
        //   ),
        //   const SizedBox(
        //     width: 10,
        //   )
        // ],
        //  text: widget.name.toString(), showSearch: false, showBackArrow: true),
      ),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    setUserID(
      widget.myID,
    );
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamProvider.value(
                value: _chatServices.streamMessages(
                    myID: widget.myID, senderID: widget.receiverID),
                initialData: [MessagesModel()],
                builder: (context, child) {
                  Timer(
                      const Duration(milliseconds: 300),
                      () => _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.ease));
                  return context.watch<List<MessagesModel>>() == null
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              context.watch<List<MessagesModel>>().length,
                          itemBuilder: (context, i) {
                            // if (callSetLength)
                            setList(context.watch<List<MessagesModel>>());
                            return context
                                        .watch<List<MessagesModel>>()[0]
                                        .time ==
                                    null
                                ? const CircularProgressIndicator()
                                : MessageTile(
                                    message: context
                                        .watch<List<MessagesModel>>()[i]
                                        .messageBody
                                        .toString(),
                                    sendByMe: context
                                            .watch<List<MessagesModel>>()[i]
                                            .fromID ==
                                        widget.myID,
                                    time: context
                                        .watch<List<MessagesModel>>()[i]
                                        .time,
                                  );
                          });
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            color: AppColors.whitecolor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 4,
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      style: const TextStyle(color: Colors.black, fontSize: 13),
                      controller: messageController,
                      onChanged: (val) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                          hintText: "Type Here...",
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none)),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    IconButton(
                      onPressed: () {
                        if (messageController.text.isEmpty) {
                          return;
                        }
                        String message = messageController.text;
                        setState(() {});
                        Future.delayed(const Duration(microseconds: 20), () {
                          messageController.clear();
                        });
                        Timer(
                            const Duration(milliseconds: 300),
                            () => _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.ease));

                        _chatServices
                            .addNewMessage(
                                receiverID: widget.receiverID,
                                myID: widget.myID,
                                detailsModel: ChatDetailsModel(
                                  recentMessage: messageController.text,
                                  date: DateFormat('MM/dd/yyyy')
                                      .format(Timestamp.now().toDate()),
                                  time: DateFormat('hh:mm a')
                                      .format(Timestamp.now().toDate()),
                                ),
                                messageModel: MessagesModel(
                                    isRead: false,
                                    time: DateFormat('MM/dd/yyyy hh:mm a')
                                        .format(DateTime.now()),
                                    messageBody: messageController.text))
                            .then((value) => {})
                            .whenComplete(() {
                          NotificationHandler().oneToOneNotificationHelper(
                              docID: widget.receiverID,
                              body: messageController.text,
                              title: "You have Recieved message from " +
                                  widget.name);
                        });
                      },
                      icon: Icon(
                        Icons.send,
                        color: messageController.text.isEmpty
                            ? Colors.grey
                            : Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  markMessageAsRead({required List<MessagesModel> list, required String uid}) {
    list
        .map((e) => _chatServices.markMessageAsRead(
            myID: uid,
            receiverID: widget.receiverID,
            messageID: e.docID.toString()))
        .toList();
  }

  List<MessagesModel> list = [];
  String userID = '';

  void setList(List<MessagesModel> _list) {
    list = _list;
  }

  List<MessagesModel> get getList => list;

  void setUserID(String _userID) {
    userID = _userID;
  }

  String get getUserID => userID;

  @override
  void dispose() {
    // var user = Provider.of<User>(context, listen: false);
    // TODO: implement dispose
    markMessageAsRead(uid: getUserID, list: getList);
    super.dispose();
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final String time;

  MessageTile(
      {required this.message, required this.sendByMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          sendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
              top: 2,
              bottom: 1,
              left: sendByMe ? 0 : 14,
              right: sendByMe ? 14 : 0),
          alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
                maxWidth: 0.6 * MediaQuery.of(context).size.width),
            margin: sendByMe
                ? const EdgeInsets.only(left: 30)
                : const EdgeInsets.only(right: 30),
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 10),
            decoration: BoxDecoration(
              color:
                  sendByMe ? AppColors.appcolor : AppColors.lightdarktextcolor,
              borderRadius: sendByMe
                  ? const BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: const Radius.circular(10))
                  : const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(message,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        height: 1.3,
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w300)),
                const SizedBox(
                  height: 15,
                ),
                // Booster.verticalSpace(5),
                Text(
                  time.toString(),
                  style: TextStyle(
                      fontSize: 9, color: Colors.white.withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
