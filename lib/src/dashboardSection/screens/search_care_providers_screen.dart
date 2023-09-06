import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';
import '../services/home_services.dart';
import '../widgets/search_widget.dart';

class SearchCarProviderScreen extends StatefulWidget {
  const SearchCarProviderScreen({Key? key}) : super(key: key);

  @override
  State<SearchCarProviderScreen> createState() =>
      _SearchCarProviderScreenState();
}

class _SearchCarProviderScreenState extends State<SearchCarProviderScreen> {
  HomeServices homeServices = HomeServices();

  List<UserModelDietitian> searchedContact = [];

  List<UserModelDietitian> contactList = [];

  bool isSearchingAllow = false;
  bool isSearched = false;
  List<UserModelDietitian> contactListDB = [];

  void _searchedContacts(String val) async {
    print(contactListDB.length);
    searchedContact.clear();
    for (var i in contactListDB) {
      var lowerCaseString = i.userName.toString().toLowerCase() +
          " " +
          i.userName.toString().toLowerCase() +
          i.userName.toString();

      var defaultCase = i.userName.toString() +
          " " +
          i.userName.toString() +
          i.userName.toString();

      if (lowerCaseString.contains(val) || defaultCase.contains(val)) {
        searchedContact.add(i);
      } else {
        setState(() {
          isSearched = true;
        });
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "All Dietitians",
          style: fontW5S12(context)!.copyWith(
              fontSize: 16,
              color: AppColors.whitecolor,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                child: TextFormField(
                  enabled: true,
                  onChanged: (val) {
                    _searchedContacts(val);
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15, top: 19),
                      border: InputBorder.none,
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Icon(Icons.search)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamProvider.value(
                value: homeServices.streamAllDietitans(),
                initialData: [UserModelDietitian()],
                builder: (context, child) {
                  contactListDB = context.watch<List<UserModelDietitian>>();
                  List<UserModelDietitian> list =
                      context.watch<List<UserModelDietitian>>();
                  return list.isEmpty
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Text("No Data Found!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                        ))
                      : list[0].userId == null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: SpinKitPulse(
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          : list.isEmpty
                              ? Center(child: Text("No Data Found"))
                              : searchedContact.isEmpty
                                  ? isSearched == true
                                      ? Center(child: Text("NO Data Found"))
                                      : Container(
                                          // height: 550,
                                          // width: MediaQuery.of(context).size.width,

                                          child: Expanded(
                                          child: ListView.builder(
                                              itemCount: contactListDB.length,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.only(),
                                              itemBuilder: (context, i) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: SearchDietitiansWidget(
                                                    userModel: list[i],
                                                  ),
                                                );
                                              }),
                                        ))
                                  : Container(
                                      child: Expanded(
                                      child: ListView.builder(
                                          itemCount: searchedContact.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(),
                                          itemBuilder: (context, i) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: SearchDietitiansWidget(
                                                userModel: searchedContact[i],
                                              ),
                                            );
                                          }),
                                    ));
                })
          ],
        ),
      ),
    );
  }
}
