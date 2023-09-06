import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../authenticationsection/Models/userModel.dart';
import '../../authenticationsection/providers/savUserDetailsProvider.dart';
import '../models/message.dart';
import '../models/message_details.dart';
import '../services/chat.dart';
import '../services/farmer.dart';
import '../services/user.dart';
import '../widgets/app_bar.dart';
import '../widgets/chat_tile.dart';
import 'messages.dart';

class RecentChatList extends StatefulWidget {
  const RecentChatList(
      {Key? key,
      menuScreenContext,
      bool? hideStatus,
      Null Function()? onScreenHideButtonPressed})
      : super(key: key);

  @override
  _RecentChatListState createState() => _RecentChatListState();
}

class _RecentChatListState extends State<RecentChatList> {
  ChatServices _chatServices = ChatServices();
  bool initialized = false;
  UserModel userModel = UserModel();
  ExpertServices _userServices = ExpertServices();
  FarmerServices _farmerServices = FarmerServices();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    print(user.getUserDetails());
    return Scaffold(
      body: _buildUI(context, user.getUserDetails()!),
    );
  }

  Widget _buildUI(BuildContext context, UserModel _userModel) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: customAppBar(text: 'Recent Chats', showSearch: true),
      body: _getUI(context, _userModel),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _chatServices.addNewMessage(
      //         receiverID: user.getUserDetails()!.docId.toString(),
      //         myID: '6pRq2nB7DtQyXSlR6jnRIofq7jn2',
      //         detailsModel: ChatDetailsModel(
      //           recentMessage: 'Hi',
      //           date: DateFormat('MM/dd/yyyy').format(Timestamp.now().toDate()),
      //           time: DateFormat('hh:mm a').format(Timestamp.now().toDate()),
      //         ),
      //         messageModel: MessagesModel(
      //             isRead: false,
      //             time: DateFormat('MM/dd/yyyy hh:mm a').format(DateTime.now()),
      //             messageBody: 'Hi'));
      //   },
      // ),
    );
  }

  Widget _getUI(BuildContext context, UserModel _model) {
    var user = Provider.of<UserProvider>(context);

    return Column(
      children: [
        Divider(),
        Expanded(
          child: StreamProvider.value(
            value: _chatServices.streamChatList(myID: _model.userId.toString()),
            initialData: [ChatDetailsModel()],
            builder: (context, child) {
              List<ChatDetailsModel> chatDetailsList =
                  context.watch<List<ChatDetailsModel>>();
              print("User ID" + user.getUserDetails()!.userId.toString());
              return chatDetailsList.isEmpty
                  ? const Center(
                      child: Text(
                        "No chats Found",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    )
                  : chatDetailsList[0].myID == null
                      ? Container(
                          height: MediaQuery.of(context).size.height - 150,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [CircularProgressIndicator()],
                          ),
                        )
                      : chatDetailsList.length != 0
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: chatDetailsList.length,
                              itemBuilder: (context, i) {
                                return StreamProvider.value(
                                  value: _chatServices.getUnreadMessageCounter(
                                      myID: user
                                          .getUserDetails()!
                                          .userId
                                          .toString(),
                                      receiverID: chatDetailsList[i]
                                          .otherID
                                          .toString()),
                                  initialData: [MessagesModel()],
                                  builder: (unReadContext, child) {
                                    List<MessagesModel> unReadMessagesList =
                                        unReadContext
                                            .watch<List<MessagesModel>>();
                                    return StreamProvider.value(
                                      value: _farmerServices.getUserDetails(
                                          chatDetailsList[i]
                                              .otherID
                                              .toString()),
                                      initialData: UserModel(),
                                      builder: (userContext, child) {
                                        UserModel chatUserModel =
                                            userContext.watch<UserModel>();
                                        return chatUserModel.userId == null
                                            ? CircularProgressIndicator()
                                            : InkWell(
                                                onTap: () {
                                                  ChatDetailsModel _model =
                                                      chatDetailsList[i];
                                                  setState(() {});

                                                  toNext(
                                                      context: context,
                                                      widget: MessagesView(
                                                        receiverID: _model
                                                            .otherID
                                                            .toString(),
                                                        name: chatUserModel
                                                            .userName
                                                            .toString(),
                                                        myID: user
                                                            .getUserDetails()!
                                                            .userId
                                                            .toString(),
                                                        image: chatUserModel
                                                            .profilePicture
                                                            .toString(),
                                                      ));
                                                  // return;
                                                },
                                                child: ChatTile(
                                                  image: chatUserModel
                                                      .profilePicture
                                                      .toString(),
                                                  title: chatUserModel.userName
                                                      .toString(),
                                                  description:
                                                      chatDetailsList[i]
                                                              .recentMessage ??
                                                          "",
                                                  time: chatDetailsList[i]
                                                      .time
                                                      .toString(),
                                                  counter: unReadMessagesList
                                                              .length ==
                                                          1
                                                      ? unReadMessagesList[0]
                                                                  .docID ==
                                                              null
                                                          ? 0
                                                          : unReadMessagesList
                                                              .length
                                                      : unReadMessagesList
                                                          .length,
                                                ),
                                              );
                                      },
                                    );
                                  },
                                );
                              })
                          : Text(
                              "No Chats Found",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            );
            },
          ),
        )
      ],
    );
  }
}
