import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relis/arguments/bookArguments.dart';
import 'package:relis/arguments/photoArguments.dart';
import 'package:relis/authentication/user.dart';
import 'package:relis/arguments/pagearguments.dart';
import 'package:relis/bookInfo.dart';
import 'package:relis/profile/showPhoto.dart';
import 'package:relis/view/bookView.dart';
import 'package:relis/drawer.dart';
import 'package:relis/globals.dart';
import 'package:relis/widget/bookPreview.dart';
import 'package:relis/widget/bookWrapList.dart';

class PageTypeView extends StatefulWidget {
  const PageTypeView({Key? key}) : super(key: key);
  static const routeName = '/PageTypeView';

  @override
  _PageTypeViewState createState() => _PageTypeViewState();
}

class _PageTypeViewState extends State<PageTypeView> {
  String pageTitle = "";
  String pageMessage = "";
  dynamic pageData;
  Map<String, ValueNotifier<bool>> bookHover = {};
  dynamic currentBook;
  var bookTypeList = {};
  var bookData = [];

  @override
  void initState() {
    super.initState();
    isLoggedIn(context);
    loadEachHover();
  }

  @override
  Widget build(BuildContext context) {
    dynamic detail = ModalRoute.of(context);
    if(detail!=null) {
      pageData = detail.settings.arguments as PageArguments;
    }
    print("\t In pageViewBuild:");
    loadPageData(pageData);
    // if(page == pageType.adminBookView) {
    //   return IconButton(
    //     onPressed: () {
    //       Navigator.of(context).pop();
    //     },
    //     icon: Icon(
    //         Icons.arrow_back_rounded
    //     ),
    //   );
    // }
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: Text(pageTitle),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.00),
            child: Tooltip(
              message: "No. of Books ${pageName(pageData.page)}",
              child: CircleAvatar(
                  child: Text(
                    currentBook == null ? "0" : currentBook.length.toString(),
                    style: TextStyle(
                      color: Color(0xFFdbb018),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Color(0xFF032f4b),
                ),
            ),
          ),
        ],
        backgroundColor: appBarBackgroundColor,
        shadowColor: appBarShadowColor,
        elevation: 2.0,
      ),
      drawer: (pageData.page.hashCode == pageType.adminBookView.hashCode) ? null : AppDrawer(),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 700) {
              return desktopView();
            } else {
              return mobileView();
            }
          },
        ),
      ),
    );
  }

  Widget desktopView() {
    if(pageData.page == pageType.personalBooks) {
      bool isHoverFAB = false;
      return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.9255,
        child: Stack(
          children: [
            if(currentBook == null)
              Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
              margin: EdgeInsets.symmetric(vertical: 100.00, horizontal: 20.00),
              decoration: categoryDecoration,
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height/2,
              child: Text(pageMessage, style: TextStyle(color: Colors.white, fontSize: 30),),
            ),
            if(currentBook != null)
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
                margin: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
                child: BookWrapList(currentBook: currentBook, controller: scrollController, bookHover: bookHover),
              ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.00, horizontal: 100.00),
                child: FloatingActionButton(
                  tooltip: "Add Books to your Library",
                  child: Icon(
                    Icons.add,
                    color: mainAppAmber,
                    size: 45,
                  ),
                  onPressed: () {
                    addBook(context);
                  },
                  elevation: 2.0,
                  hoverElevation: 5.0,
                  hoverColor: Colors.transparent.withOpacity(0.6),
                  splashColor: mainAppAmber.withOpacity(0.6),
                  backgroundColor: mainAppBlue,
                ),
              ),
            ),
          ],
        ),
      );
    }
    if(pageData.page == pageType.category && pageData.currentCategory == null) {
      return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
        margin: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
        child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.spaceAround,
          spacing: 10.00,
          runSpacing: 20.00,
          direction: Axis.horizontal,
          verticalDirection: VerticalDirection.down,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            for(var cat in category.values)
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.spaceAround,
                spacing: 10.00,
                runSpacing: 10.00,
                direction: Axis.horizontal,
                verticalDirection: VerticalDirection.down,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: [
                  // Hero(
                  //   tag: "category: ${category[i%(categoryListLength)]["id"]}",
                  //   child:
                  Container(
                    width: 300,
                    height: 100,
                    decoration: categoryDecoration,
                    alignment: Alignment.center,
                    child: Material(
                      shadowColor: Colors.black,
                      elevation: 1.0,
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25.00),
                      type: MaterialType.card,
                      child: InkWell(
                        enableFeedback: true,
                        hoverColor: Colors.white.withOpacity(0.1),
                        splashColor: Colors.tealAccent.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(25.00),
                        onTap: (){
                          Navigator.of(context).pushNamed(
                            PageTypeView.routeName,
                            arguments: PageArguments(
                              pageType.category,
                              currentCategory: cat,
                            ),
                          );
                        },
                        onHover: (hover){
                          categoryHover.update(cat["id"], (value) => categoryHover[cat["id"]]!);
                          hover = categoryHover[cat["id"]]!.value;
                          // setState(() {});
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: Text(cat["categoryName"], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 30), overflow: TextOverflow.ellipsis,),
                        ),
                      ),
                    ),
                  ),
                  // ),
                  SizedBox(width: 20,),
                ],
              ),
          ],
        ),
      );
    }
    if(currentBook == null) {
      return Center(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
          margin: EdgeInsets.symmetric(vertical: 100.00, horizontal: 20.00),
          decoration: categoryDecoration,
          width: MediaQuery.of(context).size.width/2,
          height: MediaQuery.of(context).size.height/2,
          child: Text(pageMessage, style: TextStyle(color: Colors.white, fontSize: 30),),
        ),
      );
    }
    if(pageData.page == pageType.cart) {}
    print("HOVERING: ${bookHover.length}");
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
      margin: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
      child: BookWrapList(currentBook: currentBook, controller: scrollController, bookHover:bookHover),
    );
  }

  Widget mobileView() {
    return Container();
  }

  void loadPageData(dynamic pageData) {
    if(pageData == null){
      pageTitle = "";
      pageMessage = "";
      currentBook = null;
    }
    categoryBookHover = {};
    switch(pageData.page) {
      case pageType.category:
      {
          print("...1 Reached Here... ${pageData.currentCategory}");
          if(pageData.currentCategory == null) {
            pageTitle = "Genre";
            pageMessage = "No Genres";
            currentBook = null;
            print("\t...in if...Reached Here...");
            break;
          }
          pageTitle = "Genre: ${pageData.currentCategory["categoryName"]}";
          pageMessage = "No Books in this Genre";
          currentBook = getBooksMap(pageData.currentCategory["bookList"], isList: true);
          print("...2 Reached Here.....");
          if (pageData.currentCategory["bookList"] != null) {
            print("pageData.currentCategory[bookList]: ");
            print("${pageData.currentCategory["bookList"].length}");
            categoryBookHover = loadCategoryBooks(pageData.currentCategory["bookList"], categoryBookHover);
            // loadHover(pageData.currentCategory["bookList"].length,
            //     pageData.currentCategory["bookList"], categoryBookHover,
            //     "categoryBookList");
            bookHover = categoryBookHover;
            setState(() {});
            // printHover(categoryBookHover);
            // loadCategory();
            // setState(() {});
            break;
          }
          else
            bookHover = {};
      }
      break;
      case pageType.trending:
      {
        pageTitle = "Current Trends";
        pageMessage = "No Trending Book";
        currentBook = getBooksMap(bookInfo["trendingBook"], isList: true);
        // loadHover(bookInfo["trendingBook"].length, bookInfo["trendingBook"], trendingHover, "trendingBook");
        // setState(() {});
        bookHover = trendingHover;
      }
      break;
      case pageType.cart:
      {
        pageTitle = "Your Shopping Cart";
        pageMessage = "No Books in Cart";
        currentBook = getBooksMap(user?["cart"], isList: true);
        // loadHover(user?["favouriteBook"].length, user?["favouriteBook"], favouriteHover, "favouriteBook");
        // setState(() {});
        bookHover = cartHover;
      }
      break;
      case pageType.favourite:
      {
        pageTitle = "Your Favourites";
        pageMessage = "No Favourite Book";
        currentBook = getBooksMap(user?["favouriteBook"], isList: true);
        // loadHover(user?["favouriteBook"].length, user?["favouriteBook"], favouriteHover, "favouriteBook");
        // setState(() {});
        bookHover = favouriteHover;
      }
      break;
      case pageType.wishList:
      {
        pageTitle = "Your Wish-List";
        pageMessage = "No Books in WishList";
        currentBook = getBooksMap(user?["wishListBook"], isList: true);
        // loadHover(user?["wishListBook"].length, user?["wishListBook"], wishListHover, "wishListBook");
        // setState(() {});
        bookHover = wishListHover;
      }
      break;
      case pageType.history:
      {
        pageTitle = "History";
        pageMessage = "No History";
        currentBook = getBooksMap(user?["bookHistory"], isList: true);
        // loadHover(user?["bookHistory"].length, user?["bookHistory"], historyHover, "bookHistory");
        // setState(() {});
        bookHover = historyHover;
      }
      break;
      case pageType.bought:
      {
        pageTitle = "Books Bought";
        pageMessage = "No Books Bought";
        currentBook = getBooksMap(user?["booksBought"].keys, isList: true);
        // loadHover(user?["booksBought"].keys.length, user?["booksBought"], boughtHover, "booksBought");
        // setState(() {});
        bookHover = boughtHover;
      }
      break;
      case pageType.rented:
      {
        pageTitle = "Books Rented";
        pageMessage = "No Books Rented";
        currentBook = getBooksMap(user?["booksRented"].keys, isList: true);
        // loadHover(user?["booksRented"].keys.length, user?["booksRented"], rentedHover, "booksRented");
        // setState(() {});
        bookHover = rentedHover;
      }
      break;
      case pageType.personalBooks:
      {
        pageTitle = "Your Personal Books";
        pageMessage = "No Books in Personal Library";
        currentBook = getBooksMap(user?["personalBooks"], isList: true);
        // loadHover(user?["booksRented"].keys.length, user?["booksRented"], rentedHover, "booksRented");
        // setState(() {});
        bookHover = personalBooksHover;
      }
      break;
      case pageType.adminBookView:
      {
        pageTitle = pageData.type + " by " + pageData.personName;
        pageMessage = "No Books Yet!!";
        // print("pageTitle: ${pageTitle}");
        // print("pageMessage: ${pageMessage}");
        // print("...currentCategory: ${pageData.currentCategory}");
        // print("...getBooksMap: ${getBooksMap(pageData.currentCategory)}");
        // loadHover(user?["booksRented"].keys.length, user?["booksRented"], rentedHover, "booksRented");
        // setState(() {});
        bookHover = {};
        if (pageData.currentCategory != null) {
          print("pageData.currentCategory: ${pageData.currentCategory}");
          currentBook = getBooksMap(pageData.currentCategory, isList: true);
          loadHoverMap(
            currentBook,
            adminBookHover,
          );
          bookHover = adminBookHover;
          setState(() {});
          // printHover(categoryBookHover);
          // loadCategory();
          // setState(() {});
        }
        // print("bookHover: $bookHover");
      }
      break;
      case pageType.none:
      default:
      {
        pageTitle = "";
        pageMessage = "";
        currentBook = null;
      }
      break;
    }
    WidgetsBinding.instance!.addPostFrameCallback((_){
      setState(() {});
    });
  }

  addBook(BuildContext context) {
    Map<String, dynamic> newBook = {
      "id": "",
      "bookName": "",
      "category" : "",
      "authorName": "",
      "price": null,
      "image": "",
      "description": "",
      "publication": null,
      "ratings": null,
    };
    Color dialogBackground = Colors.white;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        elevation: 2.0,
        backgroundColor: dialogBackground,
        contentPadding: EdgeInsets.all(15.00),
        title: Text(
          "Add New Book To Your Personal Library",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: mainAppBlue,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        content: addBookContent(newBook, dialogBackground),
        actions: [
          Container(
            margin: EdgeInsets.all(15.00),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  elevation: 2.0,
                  splashColor: Colors.redAccent.withOpacity(0.8),
                  hoverColor: Colors.transparent.withOpacity(0.2),
                  hoverElevation: 5.0,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFff0000),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 5,),
                MaterialButton(
                  color: Colors.green,
                  elevation: 2.0,
                  splashColor: Color(0xFF00ff00),
                  hoverColor: Colors.transparent.withOpacity(0.2),
                  hoverElevation: 5.0,
                  padding: EdgeInsets.symmetric(horizontal: 20.00, vertical: 10.00),
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    var rng = Random();
                    var randNo = rng.nextInt(1000);
                    newBook["bookFile"] = bookData;
                    newBook["id"] = "pbk-$randNo";
                    newBook["authorName"] = user!["firstName"]+" "+user!["lastName"];
                    newBook["image"] = Image.asset("ReLis.gif");
                    print("id: ");
                    print(newBook["id"]);
                    print("bookFile Length: ");
                    print(newBook["bookFile"].length);
                    setState(() {});
                    print("newBook:");
                    print(newBook);
                    await addPersonalBooks(context, newBook);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget addBookContent(var newBook, Color dialogBackground) {
    List<DropdownMenuItem<dynamic>> categoryDropDownList = [];
    for(var cat in categoryList){
      print('adding ${cat}');
      categoryDropDownList.add(DropdownMenuItem(
        child: Text(
          cat["categoryName"],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: mainAppBlue,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        value: cat,
      ));
    }
    dynamic categoryDropDownValue = categoryList.last;
    return Container(
      width: MediaQuery.of(context).size.width/3 * 2,
      height: MediaQuery.of(context).size.height/3 * 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width/4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    overflow: Overflow.visible,
                    children: [
                      CircleAvatar(
                        radius: 160,
                        backgroundColor: Color(0xFF032f4b),
                        child: Hero(
                          tag: "profilePhoto",
                          child: CircleAvatar(
                            radius: 160,
                            backgroundColor: Color(0xFF032f4b),
                            backgroundImage: newBook["imageURL"] != null ? NetworkImage(newBook["imageURL"]) : Image.asset("ReLis.gif").image,
                            child: Material(
                              elevation: 0.0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Colors.transparent,
                              shadowColor: Colors.white,
                              borderRadius: BorderRadius.circular(210),
                              child: InkWell(
                                splashColor: Colors.teal.withOpacity(0.5),
                                onTap: () {
                                  Navigator.of(context).pushNamed(ShowPhoto.routeName, arguments: PhotoArguments("Book Cover Image", newBook["imageURL"] == null ? "" : newBook["imageURL"]));
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
                          backgroundColor: dialogBackground,
                          child: Material(
                            elevation: 5.0,
                            color: Color(0xFF032f4b),
                            shadowColor: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            borderOnForeground: true,
                            child: InkWell(
                              onTap: (){
                                cameraSource(context) ? chooseImage(context, false) : uploadMenu();
                                setState(() {});
                              },
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              splashColor: Color(0xFF032f4b),
                              hoverColor: Colors.teal.withOpacity(0.8),
                              enableFeedback: true,
                              radius: 100.00,
                              child: Tooltip(
                                message: "Enter Book Cover Image",
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
                      ),
                    ],
                  ),
                  SizedBox(width: 20,),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20.00),
                    decoration: BoxDecoration(
                      color: mainAppAmber,
                      border: Border.all(
                        color: mainAppBlue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(25.00),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Category: ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: mainAppBlue,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              iconEnabledColor: mainAppBlue,
                              iconDisabledColor: Colors.white,
                              iconSize: 35,
                              style: TextStyle(fontSize: 20, color: mainAppBlue),
                              value: categoryDropDownValue,
                              dropdownColor: mainAppAmber,
                              items: categoryDropDownList,
                              onChanged: (dynamic value) async
                              {
                                categoryDropDownValue = value;
                                newBook["category"] = categoryDropDownValue["id"];
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Tooltip(
                    message: "Enter Book PDF",
                    child: Material(
                      elevation: 5.0,
                      color: Color(0xFF032f4b),
                      shadowColor: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      borderOnForeground: true,
                      child: InkWell(
                        onTap: () async {
                          bookData = await chooseFile(context);
                          print("...Received Book Data!!");
                          setState(() {});
                        },
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        splashColor: Color(0xFF032f4b),
                        hoverColor: Colors.teal.withOpacity(0.8),
                        enableFeedback: true,
                        radius: 100.00,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.00),
                          width: MediaQuery.of(context).size.width/4,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  bookData==[] ? "Enter Book PDF" : "${newBook["bookName"]}.pdf",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: mainAppAmber
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.picture_as_pdf_rounded,
                                  color: Color(0xFFdbb018),
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width/4*1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: TextFormField(
                            onChanged: (text) {
                              newBook["bookName"] = text;
                              setState(() {});
                            },
                            style: TextStyle(color: mainAppAmber, fontWeight: FontWeight.bold,),
                            maxLines: 1,
                            maxLength: 100,
                            initialValue: "",
                            keyboardType: TextInputType.text,
                            cursorColor: mainAppAmber,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              labelText: 'Book Name',
                              hintText: "Ex.: A Cup of Tea",
                              counterText: "",
                              labelStyle: TextStyle(
                                color: mainAppAmber,
                              ),
                              hintStyle: TextStyle(
                                color: mainAppAmber,
                              ),
                              fillColor: mainAppBlue,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainAppAmber),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainAppAmber),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: TextFormField(
                            onChanged: (text) {
                              newBook["authorName"] = text;
                              setState(() {});
                            },
                            style: TextStyle(color: mainAppAmber, fontWeight: FontWeight.bold,),
                            maxLines: 1,
                            maxLength: 100,
                            initialValue: "",
                            keyboardType: TextInputType.text,
                            cursorColor: mainAppAmber,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              labelText: 'Author Name',
                              hintText: "Your Name: ${user?["firstName"] + " " + user?["lastName"]}",
                              counterText: "",
                              labelStyle: TextStyle(
                                color: mainAppAmber,
                              ),
                              hintStyle: TextStyle(
                                color: mainAppAmber,
                              ),
                              fillColor: mainAppBlue,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainAppAmber),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainAppAmber),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 30.00),
                    alignment: Alignment.topLeft,
                    child: TextFormField(
                      onChanged: (text) {
                        newBook["description"] = text;
                        setState(() {});
                      },
                      style: TextStyle(color: mainAppBlue, fontWeight: FontWeight.bold,),
                      keyboardType: TextInputType.multiline,
                      minLines: 10,
                      maxLines: 20,
                      maxLength: 1000,
                      initialValue: "",
                      cursorColor: mainAppBlue,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        labelText: 'Description',
                        hintText: "Enter Book Description Here ...",
                        labelStyle: TextStyle(
                          color: mainAppBlue,
                        ),
                        hintStyle: TextStyle(
                          color: mainAppBlue,
                        ),
                        fillColor: mainAppAmber,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainAppBlue),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainAppBlue),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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

}

