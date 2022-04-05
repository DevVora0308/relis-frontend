import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:relis/arguments/pagearguments.dart';
import 'package:relis/arguments/photoArguments.dart';
import 'package:relis/authentication/user.dart';
import 'package:relis/authentication/user.dart';
import 'package:relis/globals.dart';
import 'package:relis/profile/showPhoto.dart';
import 'package:relis/view/pageView.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static const routeName = '/ProfilePage';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {

  Map<String, bool> profileVisibility = {
    "admin" : false,
    "normal" : true,
  };
  ScrollController wrapController = new ScrollController();
  int ijk = 0;
  double column1Width = 0.0;
  double column2Width = 0.0;
  Map<String, dynamic> searchUserList = {};
  Map<String, dynamic> searchBookList = {};
  bool _isSearching = false;
  List searchUserResult = [];
  List searchBookResult = [];
  // final TextEditingController searchTextController = new TextEditingController();
  final TextEditingController searchUserTextController = new TextEditingController();
  final TextEditingController searchBookTextController = new TextEditingController();
  List finalSearchUserResult = [];
  List finalSearchBookResult = [];
  late TabController adminTabController;
  int adminTabIndex = 0;
  ScrollController userScrollController = new ScrollController();
  ScrollController bookScrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    isLoggedIn(context);
    print("Loading Data");
    loadData();
    if(user?["userType"] == "normal"){
      profileVisibility["userType"] = true;
    }
    adminTabController = new TabController(length: 2, vsync: this);

    adminTabController.addListener(() {
      setState(() {
        adminTabIndex = adminTabController.index;
      });
      print("Selected Index: " + adminTabController.index.toString());
    });
    setState(() {});
    print("Done");
    // WidgetsBinding.instance!.addPostFrameCallback((_){
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    column1Width = MediaQuery.of(context).size.width/3;
    column2Width = MediaQuery.of(context).size.width/3*1.92;
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: appBarBackgroundColor,
        shadowColor: appBarShadowColor,
        elevation: 2.0,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 700) {
            return desktopView();
          } else {
            return mobileView();
          }
        },
      ),
    );
  }

  Widget desktopView() {
    String newStatus = "";
    return Container(
      padding: EdgeInsets.all(10.00),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: !profileVisibility["admin"]!,
            child: Container(
            width: column1Width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  overflow: Overflow.visible,
                  children: [
                    CircleAvatar(
                      radius: 180,
                      backgroundColor: Color(0xFF032f4b),
                      child: Hero(
                        tag: "profilePhoto",
                        child: CircleAvatar(
                          radius: 180,
                          backgroundColor: Color(0xFF032f4b),
                          backgroundImage: user?["imageURL"] != null ? NetworkImage(user?["imageURL"]) : Image.asset("ReLis.gif").image,
                          child: Material(
                            elevation: 0.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Colors.transparent,
                            shadowColor: Colors.white,
                            borderRadius: BorderRadius.circular(210),
                            child: InkWell(
                              splashColor: Colors.teal.withOpacity(0.5),
                              onTap: () {
                                Navigator.of(context).pushNamed(ShowPhoto.routeName, arguments: PhotoArguments("Profile Photo", user?["imageURL"] == null ? "" : user?["imageURL"]));
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      bottom: 20.0,
                      child: CircleAvatar(
                        radius: 45.00,
                        backgroundColor: appBackgroundColor,
                        child: Material(
                          elevation: 5.0,
                          color: Color(0xFF032f4b),
                          shadowColor: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          borderOnForeground: true,
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context, );
                              cameraSource(context) ? chooseImage(context, false) : uploadMenu();
                              setState(() {});
                            },
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            splashColor: Color(0xFF032f4b),
                            hoverColor: Colors.teal.withOpacity(0.8),
                            enableFeedback: true,
                            radius: 100.00,
                            child: Container(
                              padding: EdgeInsets.all(20.00),
                              child: Icon(
                                cameraSource(context) ? Icons.image_rounded : Icons.camera_alt_rounded,
                                color: Color(0xFFdbb018),
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            style: TextStyle(color: mainAppBlue, fontWeight: FontWeight.bold),
                            readOnly: true,
                            initialValue: user?["firstName"] + " " + user?["lastName"],
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            cursorColor: Color(0xff164040),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                color: mainAppBlue,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainAppBlue),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainAppBlue),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            style: TextStyle(color: mainAppBlue, fontWeight: FontWeight.bold),
                            readOnly: true,
                            initialValue: user?["emailId"],
                            autofocus: false,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Color(0xff164040),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              labelText: 'Email ID',
                              labelStyle: TextStyle(
                                color: mainAppBlue,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainAppBlue),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainAppBlue),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 30.00),
                          child: TextFormField(
                            onChanged: (text) {
                              newStatus = text;
                            },
                            style: TextStyle(color: mainAppAmber, fontWeight: FontWeight.bold,),
                            maxLines: 1,
                            maxLength: 100,
                            initialValue: user?["userStatus"]!.toString(),
                            keyboardType: TextInputType.text,
                            cursorColor: mainAppAmber,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              labelText: 'Status',
                              counterText: "",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              fillColor: mainAppBlue,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/8,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Material(
                            elevation: 5.0,
                            color: Colors.tealAccent,
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            child: InkWell(
                              onTap: (){
                                updateStatus(newStatus);
                              },
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              splashColor: Colors.teal,
                              child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Update Status",
                                          style: TextStyle(
                                            color: mainAppBlue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.00,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Icon(Icons.upload_rounded, color: mainAppBlue, size: 25,),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          ),
          Expanded(
            // height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                controller: wrapController,
                child: Container(
                  padding: EdgeInsets.all(10.00),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10,),
                      viewButton("User", "normal", normalUser()),
                      // user?["userType"] == "normal" ? SizedBox(width: 0,) : viewButton("Admin", "admin", adminUser()),
                      // SizedBox(height: 50,),
                      user?["isAdmin"] ? viewButton("Admin", "admin", adminUser()) : SizedBox(width: 0,),
                      SizedBox(height: 50,),
                    ],
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget mobileView() {
    return Container();
  }

  Future<void> removeImage() async {
    // await uploadImage(null);
  }

  void uploadMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xff112b2b),
          height: MediaQuery.of(context).size.width/2,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Material(
              //   color: Color(0xff164040),
              //   borderRadius: BorderRadius.all(Radius.circular(50.0)),
              //   child: InkWell(
              //     onTap: removeImage,
              //     borderRadius: BorderRadius.all(Radius.circular(50.0)),
              //     splashColor: Colors.teal,
              //     child: Padding(
              //       padding: EdgeInsets.all(12.0),
              //       child: Icon(Icons.delete_rounded, color: Colors.red,size: 40,),
              //     ),
              //   ),
              // ),
              Material(
                color: Color(0xff164040),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                child: InkWell(
                  onTap: (){
                    chooseImage(context, true);
                    setState(() {});
                  },
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  splashColor: Colors.teal,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.camera_alt_rounded, color: Colors.tealAccent,size: 40,),
                  ),
                ),
              ),
              Material(
                color: Color(0xff164040),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                child: InkWell(
                  onTap: (){
                    chooseImage(context, false);
                    setState(() {});
                  },
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  splashColor: Colors.teal,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.image_rounded, color: Colors.tealAccent, size: 40,),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> updateStatus(String status) async {
    // Map<String, dynamic> statusMsg = Map<String, dynamic>();
    // statusMsg['status'] = user_status;
    // Response response = await dio.put(
    //     updateUserStatusURL,
    //     data: statusMsg,
    //     options: Options(headers: {"token": widget.jwt_token}));
    user?["userStatus"] = status;
    setState(() {});
  }

  Widget viewCard(dynamic? cardData, String cardName, pageType type,Widget leadingIcon, Color color) {
    print("\t Building ${cardName}");
    return Container(
      width: MediaQuery.of(context).size.width/8,
      height: MediaQuery.of(context).size.width/10,
      decoration: BoxDecoration(
        color: mainAppBlue,
        borderRadius: BorderRadius.circular(20.00),
        border: Border.all(width: 2.0, color: Colors.white)
      ),
      child: ListTile(
        focusColor: color.withOpacity(0.6),
        title: Text(
          cardData !=null  ? cardData.toString() : "0",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        subtitle: Text(
          cardName,
          style: TextStyle(
            fontSize: 15,
            decoration: TextDecoration.underline,
            color: color,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: true,
        leading: leadingIcon,
        minVerticalPadding: 30.00,
        contentPadding: EdgeInsets.all(10.0),
        enableFeedback: true,
        onTap: (){
          gotToRoute(context, type);
        },
      ),
    );
  }

  Widget viewButton(String containerName, String visibilityName, Widget containerChild) {
    // print("viewButton - ${containerName}");
    // print("     userType - ${user?["userType"]}");
    // print("     visibilityName - ${visibilityName}");
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          splashColor: user?["userType"] == "normal" ? null : Color(0xff014b76),
          onPressed: user?["userType"] == "normal" ? null : (){
            profileVisibility[visibilityName] = !profileVisibility[visibilityName]!;
            setState(() {});
          },
          child: Container(
            alignment: Alignment.centerLeft,
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 40.00),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                user?["userType"] == "normal" ? SizedBox(width: 0,) : Icon(
                  profileVisibility[visibilityName]! ? Icons.keyboard_arrow_down_rounded : Icons.play_arrow_rounded,
                  size: 30,
                  color: mainAppBlue,
                ),
                user?["userType"] == "normal" ? SizedBox(width: 0,) : SizedBox(width: 20.00,),
                Text(
                  containerName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: mainAppBlue,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: profileVisibility[visibilityName]!,
          child: containerChild,
        ),
      ],
    );
  }

  Widget normalUser() {
    print("\t\t In normalUser");
    return Container(
      padding: EdgeInsets.all(10.00),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        spacing: 15.0,
        runSpacing: 15.0,
        children: [
          viewCard(
              user?["booksBought"]!= null ? user!["booksBought"]!.length : 0,
              "Books Bought",
              pageType.bought,
              Icon(
                Icons.book_outlined,
                size: 30,
                color: Color(0xFF00ff00),
              ),
              Color(0xFF00ff00)
          ),
          viewCard(
              user?["booksRented"]!= null ? user!["booksRented"]!.length : 0,
              "Books Rented",
              pageType.rented,
              Icon(
                Icons.timelapse_rounded,
                size: 30,
                color: Colors.white,
              ),
              Colors.white
          ),
          viewCard(
              user?["favouriteBook"]!= null ? user!["favouriteBook"]!.length : 0,
              "Favourite Books",
              pageType.favourite,
              Icon(
                Icons.favorite_rounded,
                size: 30,
                color: Color(0xFFff0000),
              ),
              Color(0xFFff0000)
          ),
          viewCard(
              user?["wishListBook"]!= null ? user!["wishListBook"]!.length : 0,
              "Books in Wish-List",
              pageType.wishList,
              Icon(
                Icons.bookmark_rounded,
                size: 30,
                color: Color(0xFFffff00),
              ),
              Color(0xFFffff00)
          ),
          viewCard(
              user?["booksRead"]!= null ? user!["booksRead"]!.length : 0,
              "Books Read",
              pageType.wishList,
              Icon(
                Icons.menu_book_rounded,
                size: 30,
                color: Colors.cyanAccent,
              ),
              Colors.cyanAccent
          ),
          viewCard(
              user?["personalBooks"]!= null ? user!["personalBooks"]!.length : 0,
              "My Books",
              pageType.personalBooks,
              Icon(
                Icons.my_library_books_rounded,
                size: 30,
                color: Color(0xFFff10f0),
              ),
              Color(0xFFff10f0)
          ),
        ],
      ),
    );
  }

  Widget adminUser() {
    print("\t\t In adminUser");
    // adminTabController.addListener(() {
    //   adminTabIndex = adminTabController.index;
    // });
    return Container(
      padding: EdgeInsets.all(10.00),
      child: Container(
        decoration: new BoxDecoration(
          color: mainAppBlue,
          borderRadius: BorderRadius.circular(30.00),
        ),
        height: MediaQuery.of(context).size.height*0.7,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 0.8)),
              ),
              child: TabBar(
                isScrollable: true,
                enableFeedback: true,
                automaticIndicatorColorAdjustment: true,
                controller: adminTabController,
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                labelColor: Colors.white,
                tabs: [
                  Tab(
                    icon: const Icon(Icons.groups),
                    text: 'Users',
                  ),
                  Tab(
                    icon: const Icon(Icons.menu_book_rounded),
                    text: 'Books',
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.6,
              padding: EdgeInsets.all(20.00),
              child: TabBarView(
                controller: adminTabController,
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 8,
                      ),
                      borderRadius: BorderRadius.circular(20.00),
                    ),
                    child: userTable(),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 8,
                      ),
                      borderRadius: BorderRadius.circular(20.00),
                    ),
                    child: bookTable(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getData(var data) {
    String value = "";
    if(data == null)
      return "-";
    if(data.runtimeType == value.runtimeType) {
      return data;
    }
    if (data.length>0) {
      for(int i=0; i<data.length; ++i) {
        value = value + data[i].toString();
        if(i!=data.length)
          value += ", ";
      }
      return value;
    }
    return "-";
  }

  String getRatings(var data) {
    String value = "";
    if(data == null)
      return "-";
    int i = data.length;
    for(var key in data.keys){
      value += key.toString()+"*: "+data[key].toString();
      if(--i!=0){
        value+="\n";
      }
    }
    return value;
  }

  Widget textHeading(String heading) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Text(
        heading,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget textCell(String data, {Color color = Colors.black, isButton = false}) {
    return Tooltip(
      message: data,
      child: Text(
        data,
        style: TextStyle(
          color: isButton ? Colors.blue[700]! : color,
          fontSize: 16.0,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget bookCell(String bookType, var data, String personName) {
    return TextButton(
      child: textCell("$bookType (${data.length})", isButton: true),
      onPressed: () {
        Navigator.of(context).pushNamed(
          PageTypeView.routeName,
          arguments: PageArguments(pageType.adminBookView, currentCategory: data, type: bookType, personName: personName),
        );
      },
    );
  }

  Widget imageCell(String data, String personName) {
    return TextButton(
      child: textCell(data == "-" ? "ReLis Logo" : data, isButton: true),
      onPressed: () {
        Navigator.of(context).pushNamed(
          ShowPhoto.routeName,
          arguments: PhotoArguments("Profile Photo of $personName", data == "-" ? "" : data),
        );
      },
    );
  }

  Widget tp(String value) {
    print("in TP - ${value} ${ijk++}");
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      spacing: 15.0,
      runSpacing: 15.0,
      children: [
        viewCard(
            user?["booksBought"]!.keys.length,
            "Books Bought",
            pageType.bought,
            Icon(
              Icons.book_outlined,
              size: 30,
              color: Color(0xFF00ff00),
            ),
            Color(0xFF00ff00)
        ),
        viewCard(
            user?["booksRented"]!.keys.length,
            "Books Rented",
            pageType.rented,
            Icon(
              Icons.timelapse_rounded,
              size: 30,
              color: Colors.white,
            ),
            Colors.white
        ),
        viewCard(
            user?["favouriteBook"]!.length,
            "Favourite Books",
            pageType.favourite,
            Icon(
              Icons.favorite_rounded,
              size: 30,
              color: Color(0xFFff0000),
            ),
            Color(0xFFff0000)
        ),
        viewCard(
            user?["wishListBook"]!.length,
            "Books in Wish-List",
            pageType.wishList,
            Icon(
              Icons.bookmark_rounded,
              size: 30,
              color: Color(0xFFffff00),
            ),
            Color(0xFFffff00)
        ),
        viewCard(
            user?["booksRead"]!.length,
            "Books Read",
            pageType.wishList,
            Icon(
              Icons.menu_book_rounded,
              size: 30,
              color: Colors.cyanAccent,
            ),
            Colors.cyanAccent
        ),
        viewCard(
            user?["personalBooks"]!.length,
            "My Books",
            pageType.personalBooks,
            Icon(
              Icons.my_library_books_rounded,
              size: 30,
              color: Color(0xFFff10f0),
            ),
            Color(0xFFff10f0)
        ),
      ],
    );
  }

  Widget userTable() {
    String hintText = "Search user by user name, email Id, etc ...";
    String message = "Search User by UserId, EmailId, Name, Book-Id of purchased, rented and personal Books";
    print("Loaded hintText");
    startSearching();
    loadUserSearchingData();
    return Column(
      children: [
        searchUserBar(hintText, message, searchUserTextController),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height*0.5,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 2
                ),
              ),
            ),
            child: ListView.builder(
              key: new PageStorageKey('userTable'),
              controller: userScrollController,
              itemCount: searchUserTextController.text.isNotEmpty ? finalSearchUserResult.length : globalUser.length,
              itemBuilder: (context, index) {
                String userType, name, emailId, imageURL;
                var booksBought, booksRented, personalBooks;
                if(searchUserTextController.text.isNotEmpty && finalSearchUserResult.length > 0) {
                  // String userId = getData(globaluser?[index]["id"]);
                  userType = getData(finalSearchUserResult[index]["userType"]);
                  name = getData(finalSearchUserResult[index]["firstName"]) + " " +
                      getData(finalSearchUserResult[index]["lastName"]);
                  emailId = getData(finalSearchUserResult[index]["emailId"]);
                  imageURL = getData(finalSearchUserResult[index]["imageURL"]);
                  booksBought = finalSearchUserResult[index]["booksBought"];
                  booksRented = finalSearchUserResult[index]["booksRented"];
                  personalBooks = finalSearchUserResult[index]["personalBooks"];
                } else {
                  // String userId = getData(globaluser?[index]["id"]);
                  userType = getData(globalUser[index]["userType"]);
                  name = getData(globalUser[index]["firstName"]) + " " +
                      getData(globalUser[index]["lastName"]);
                  emailId = getData(globalUser[index]["emailId"]);
                  imageURL = getData(globalUser[index]["imageURL"]);
                  booksBought = globalUser[index]["booksBought"];
                  booksRented = globalUser[index]["booksRented"];
                  personalBooks = globalUser[index]["personalBooks"];
                }
                if(finalSearchUserResult.length > 0 || globalUser.length>0) {
                  return Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder(
                      verticalInside: BorderSide(width: 1),
                      horizontalInside: BorderSide(width: 1),
                      top: BorderSide(width: 1),
                      bottom: BorderSide(width: 1),
                    ),
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      // 1: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1.5),
                      3: FlexColumnWidth(2),
                      4: FlexColumnWidth(3),
                      5: FlexColumnWidth(2.5),
                      6: FlexColumnWidth(2.5),
                      7: FlexColumnWidth(2.5),
                    },
                    children: [
                      if(index == 0)
                        TableRow(
                          children: [
                            textHeading("Sr. No."),
                            // textHeading("User Id."),
                            textHeading("Status"),
                            textHeading("Name"),
                            textHeading("Email Id."),
                            textHeading("Profile Image URL"),
                            textHeading("Books Bought"),
                            textHeading("Books Rented"),
                            textHeading("Personal Books"),
                          ],
                        ),
                      TableRow(
                        children: [
                          textCell("${index + 1}."),
                          // textCell(userId),
                          textCell(userType),
                          textCell(name),
                          textCell(emailId),
                          imageCell(imageURL, name),
                          bookCell("Books Bought", booksBought, name),
                          bookCell("Books Rented", booksRented, name),
                          bookCell("Personal Books", personalBooks, name),
                        ],
                      ),
                    ],
                  );
                } else {
                  return searchNotFound("User Not Found!!");
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bookTable() {
    String hintText = "Search Book by Book name, Book Id, etc ...";
    String message = "Search Book by BookId, Name, Author Name, Category, Keywords.";
    print("Loaded hintText");
    startSearching();
    loadBookSearchingData();
    return Column(
      children: [
        searchBookBar(hintText, message, searchBookTextController),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height*0.5,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                    width: 2
                ),
              ),
            ),
            child: ListView.builder(
              key: new PageStorageKey('bookTable'),
              controller: bookScrollController,
              itemCount: searchBookTextController.text.isNotEmpty ? finalSearchBookResult.length : bookList.length,
              itemBuilder: (context, index) {
                String bookId, bookName, category, author, price, imageURL, description, publication, ratings;
                if(searchBookTextController.text.isNotEmpty && finalSearchBookResult.length > 0) {
                  bookId = getData(finalSearchBookResult[index]["id"]);
                  bookName = getData(finalSearchBookResult[index]["bookName"]);
                  category = getCategoryName(getData(finalSearchBookResult[index]["category"]));
                  author = getData(finalSearchBookResult[index]["authorName"]);
                  price = getData(finalSearchBookResult[index]["price"]);
                  imageURL = getData(finalSearchBookResult[index]["image"]);
                  description = getData(finalSearchBookResult[index]["description"]);
                  publication = getData(finalSearchBookResult[index]["publication"]);
                  ratings = getRatings(finalSearchBookResult[index]["ratings"]);
                } else {
                  bookId = getData(bookList[index]["id"]);
                  bookName = getData(bookList[index]["bookName"]);
                  category = getCategoryName(getData(bookList[index]["category"]));
                  author = getData(bookList[index]["authorName"]);
                  price = getData(bookList[index]["price"]);
                  imageURL = getData(bookList[index]["image"]);
                  description = getData(bookList[index]["description"]);
                  publication = getData(bookList[index]["publication"]);
                  ratings = getRatings(bookList[index]["ratings"]);
                }
                return Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder(
                    verticalInside: BorderSide(width: 1),
                    horizontalInside: BorderSide(width: 1),
                    bottom: BorderSide(width: 1),
                    top: BorderSide(width: 1),
                  ),
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(3),
                    3: FlexColumnWidth(1.5),
                    4: FlexColumnWidth(2),
                    5: FlexColumnWidth(1),
                    6: FlexColumnWidth(2),
                    7: FlexColumnWidth(2.5),
                    8: FlexColumnWidth(1.5),
                    9: FlexColumnWidth(1),
                    10: FlexColumnWidth(1),
                  },
                  children: [
                    if(index == 0)
                      TableRow(
                        children: [
                          textHeading("Sr. No."),
                          textHeading("Book Id."),
                          textHeading("Book Name"),
                          textHeading("Category"),
                          textHeading("Author"),
                          textHeading("Price"),
                          textHeading("Book Cover Image"),
                          textHeading("Description"),
                          textHeading("Publication"),
                          textHeading("Ratings"),
                          textHeading("Editable"),
                        ],
                      ),
                    TableRow(
                      children: [
                        textCell("${index+1}."),
                        textCell(bookId),
                        textCell(bookName),
                        textCell(category),
                        textCell(author),
                        textCell("\u{20B9} $price/-"),
                        imageCell(imageURL, bookName),
                        textCell(description),
                        textCell(publication),
                        textCell(ratings),
                        editCell(index),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget editCell(var index) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          textCell("Edit", color: Colors.red),
          Icon(Icons.edit_outlined, color: Colors.red,),
        ],
      ),
      onPressed: (){
        print("index: $index --- ${index.runtimeType}");
        // addBook(index);
      },
    );
  }

  Widget dataUserTable() {
    int row = 0;
    return DataTable(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
        ),
      ),
      columns: [
        DataColumn(
          label: textHeading("Sr. No."),
        ),
        DataColumn(
          label: textHeading("Status"),
        ),
        DataColumn(
          label: textHeading("Name"),
        ),
        DataColumn(
          label: textHeading("Email Id."),
        ),
        DataColumn(
          label: textHeading("Profile Image URL"),
        ),
        DataColumn(
          label: textHeading("Books Bought"),
        ),
        DataColumn(
          label: textHeading("Books Rented"),
        ),
        DataColumn(
          label: textHeading("Personal Books"),
        ),
      ],
      rows:
        globalUser.toList() // Loops through dataColumnText, each iteration assigning the value to element
            .map(
          ((element) => DataRow(
            cells: <DataCell>[
              DataCell(textCell("${++row}.")),
              DataCell(textCell(getData(element["userType"]))),
              DataCell(textCell(getData(element["firstName"]) + " " + getData(element["lastName"]))),
              DataCell(textCell(getData(element["emailId"]))),
              DataCell(textCell(getData(element["imageURL"]))),
              DataCell(textCell(getData(element["booksBought"]))),
              DataCell(textCell(getData(element["booksRented"]))),
              DataCell(textCell(getData(element["personalBooks"]))),
            ],
          )),
        ).toList(),
        // DataRow(
        //   cells: [
        //     DataCell(textCell("${index+1}.")),
        //     DataCell(textCell(userType)),
        //     DataCell(textCell(name)),
        //     DataCell(textCell(emailId)),
        //     DataCell(textCell(imageURL)),
        //     DataCell(textCell(booksBought)),
        //     DataCell(textCell(booksRented)),
        //     DataCell(textCell(personalBooks)),
        //   ],
        // ),
    );
  }

  Widget searchUserBar(String hintText, String message, TextEditingController searchTextController) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: searchTextController.text.isNotEmpty ? 10.00 : 30.00, vertical: 10.00),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: TextField(
              controller: searchTextController,
              style: new TextStyle(
                color: mainAppBlue,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: mainAppBlue,
              maxLines: 1,
              decoration: new InputDecoration(
                fillColor: mainAppAmber,
                filled: searchTextController.text.isNotEmpty,
                prefixIcon: new Icon(Icons.search, color: mainAppBlue),
                hintText: hintText, // by keywords, too
                hintStyle: new TextStyle(color: mainAppBlue),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainAppBlue),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainAppBlue),
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              onChanged: (value) {
                searchUserOperation(value, searchTextController);
              }
            ),
          ),
          SizedBox(width: 5,),
          searchTextController.text.isNotEmpty ? ClipRRect(
            borderRadius: BorderRadius.circular(50.00),
            child: MaterialButton(
              hoverElevation: 5.0,
              focusElevation: 10.00,
              height: 50,
              minWidth: 25,
              hoverColor: Color(0xFFff0000).withOpacity(0.3),
              splashColor: Color(0xFFff0000).withOpacity(0.6),
              onPressed: (){
                searchTextController.clear();
              },
              child: Icon(Icons.clear, color: mainAppBlue,),
            ),
          ) : Tooltip(
            message: message,
            child: Icon(Icons.info, color: mainAppBlue,),
          ),
        ],
      ),
    );
  }

  Widget searchBookBar(String hintText, String message, TextEditingController searchTextController) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: searchTextController.text.isNotEmpty ? 10.00 : 30.00, vertical: 10.00),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: TextField(
                controller: searchTextController,
                style: new TextStyle(
                  color: mainAppBlue,
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: mainAppBlue,
                maxLines: 1,
                decoration: new InputDecoration(
                  fillColor: mainAppAmber,
                  filled: searchTextController.text.isNotEmpty,
                  prefixIcon: new Icon(Icons.search, color: mainAppBlue),
                  hintText: hintText, // by keywords, too
                  hintStyle: new TextStyle(color: mainAppBlue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainAppBlue),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainAppBlue),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onChanged: (value) {
                  searchBookOperation(value, searchTextController);
                }
            ),
          ),
          SizedBox(width: 5,),
          searchTextController.text.isNotEmpty ? ClipRRect(
            borderRadius: BorderRadius.circular(50.00),
            child: MaterialButton(
              hoverElevation: 5.0,
              focusElevation: 10.00,
              height: 50,
              minWidth: 25,
              hoverColor: Color(0xFFff0000).withOpacity(0.3),
              splashColor: Color(0xFFff0000).withOpacity(0.6),
              onPressed: (){
                searchTextController.clear();
              },
              child: Icon(Icons.clear, color: mainAppBlue,),
            ),
          ) : Tooltip(
            message: message,
            child: Icon(Icons.info, color: mainAppBlue,),
          ),
        ],
      ),
    );
  }

  Widget searchNotFound(String messageText) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
        decoration: categoryDecoration,
        width: MediaQuery.of(context).size.width/2,
        height: MediaQuery.of(context).size.height/3,
        child: Text(messageText, style: TextStyle(color: Colors.white, fontSize: 30),),
      ),
    );
  }

  void searchUserOperation(String searchText, TextEditingController searchTextController) {
    startSearching();
    searchUserResult.clear();
    finalSearchUserResult.clear();
    if (_isSearching) {
      print("...adminTabController.index: ${adminTabController.index}");
      print("...adminTabIndex: $adminTabIndex");
      if(adminTabController.index == 0) {
        for(var id in searchUserList.keys) {
          for(var value in searchUserList[id]) {
            if(value.contains(searchText.toLowerCase())) {
              print("\n\n value: \t\t$value\n\n");
              searchUserResult.add(globalUserMap[id]);
              break;
            }
          }
        }
      }
      if(searchUserResult.length>0) {
        finalSearchUserResult = searchUserResult;
        setState(() {});
      }
    }
    if(searchUserResult.length == 0 && searchUserTextController.text.isEmpty) {
      _isSearching = false;
      searchUserResult.clear();
      finalSearchUserResult.clear();
      setState(() {});
    }
    if(searchTextController.text.isEmpty && adminTabController.index == 0) {
      searchUserResult.clear();
      finalSearchUserResult.clear();
      setState(() {});
    }
  }

  void searchBookOperation(String searchText, TextEditingController searchTextController) {
    startSearching();
    searchBookResult.clear();
    finalSearchBookResult.clear();
    if (_isSearching) {
      print("...adminTabController.index: ${adminTabController.index}");
      print("...adminTabIndex: $adminTabIndex");
      if(adminTabController.index == 1) {
        for(var id in searchBookList.keys) {
          for(var value in searchBookList[id]) {
            print("searchText: $searchText .... value: $value");
            if(value.contains(searchText.toLowerCase())) {
              print("searchBookResult: $searchBookResult");
              searchBookResult.add(bookMap[id]);
              break;
            }
          }
        }
      }
      if(searchBookResult.length>0) {
        finalSearchBookResult = searchBookResult;
        print("finalSearchBookResult: $finalSearchBookResult");
        setState(() {});
      }
    }
    if(searchBookResult.length == 0 && searchBookTextController.text.isNotEmpty) {
      searchBookResult.clear();
      finalSearchBookResult.clear();
      setState(() {});
    }
    if(searchTextController.text.isEmpty && adminTabController.index == 1) {
      searchBookResult.clear();
      finalSearchBookResult.clear();
      setState(() {});
    }
  }

  void loadUserSearchingData() {
    searchUserList = {};
    loadGlobalUserMap();
    for(var key in globalUserMap.keys) {
      var userDetailsList = [];
      userDetailsList.add(globalUserMap[key]["emailId"].toLowerCase());
      userDetailsList.add(globalUserMap[key]["firstName"].toLowerCase());
      userDetailsList.add(globalUserMap[key]["lastName"].toLowerCase());
      if(userType!=null && userType.length > 0) {
        for(var type in userType){
          userDetailsList.add(type.toLowerCase());
        }
      }
      if(globalUserMap[key]["booksBought"]!.keys.length > 0) {
        for(var id in globalUserMap[key]["booksBought"].keys) {
          userDetailsList.add(id.toLowerCase());
        }
      }
      if(globalUserMap[key]["booksRented"]!.keys.length > 0) {
        for(var id in globalUserMap[key]["booksRented"].keys) {
          userDetailsList.add(id.toLowerCase());
        }
      }
      if(globalUserMap[key]["personalBooks"]!.length > 0) {
        for(var id in globalUserMap[key]["personalBooks"]) {
          userDetailsList.add(id.toLowerCase());
        }
      }
      searchUserList[globalUserMap[key]["emailId"]] = userDetailsList;
    }
  }

  void loadBookSearchingData() {
    searchBookList = {};
    for(var book in bookList) {
      var bookDetailsList = [];
      bookDetailsList.add(book["id"].toLowerCase());
      bookDetailsList.add(book["bookName"].toLowerCase());
      bookDetailsList.add(book["authorName"].toLowerCase());
      String categoryName = getCategoryName(book["category"]);
      if(categoryName != "-")
        bookDetailsList.add(categoryName.toLowerCase());
      if(book.keys.contains("keywords")) {
        for(String bookKey in book["keywords"])
          bookDetailsList.add(bookKey.toLowerCase());
      }
      searchBookList[book["id"]] = bookDetailsList;
    }
    // print("\n\n searchList: \t\t$searchList\n\n");
  }

  void startSearching() {
    _isSearching = true;
    // WidgetsBinding.instance!.addPostFrameCallback((_){
    //   setState(() {});
    // });
  }

  void stopSearching(TextEditingController searchTextController) {
    _isSearching = false;
    searchTextController.clear();
    Navigator.of(context).pop();
    setState(() {});
  }

}
