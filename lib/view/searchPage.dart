import 'package:flutter/material.dart';
import 'package:relis/arguments/bookArguments.dart';
import 'package:relis/arguments/pagearguments.dart';
import 'package:relis/authentication/user.dart';
import 'package:relis/globals.dart';
import 'package:relis/view/bookView.dart';
import 'package:relis/view/pageView.dart';
import 'package:relis/widget/bookPreview.dart';
import 'package:relis/widget/bookWrapList.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);
  static const routeName = '/SearchPage';

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  Widget appBarTitle = SizedBox(width: 0,);
  Icon icon = new Icon(
    Icons.close,
    color: Colors.white,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController searchTextController = new TextEditingController();
  Map<String, dynamic> searchList = {};
  bool _isSearching = false;
  String _searchText = "";
  List searchResult = [];
  Map<String, ValueNotifier<bool>> bookHover = {};
  dynamic currentBook = null;

  @override
  void initState() {
    super.initState();
    isLoggedIn(context);
    _isSearching = false;
    loadSearchingData();
    appBarTitle = new TextField(
      controller: searchTextController,
      style: new TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      maxLines: 1,
      decoration: new InputDecoration(
        prefixIcon: new Icon(Icons.search, color: Colors.white),
        hintText: "Search Books by book name, author name, etc ...", // by keywords, too
        hintStyle: new TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(18.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      onChanged: searchOperation,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: icon,
            onPressed: () {
              stopSearching();
              setState(() {});
            },
          ),
        ],
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
    return Container(
      padding: EdgeInsets.all(10.00),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if((searchResult.length == 0 && searchTextController.text.isEmpty) && currentBook == null)
            searchBook("Type to Search Book in ReLis"),
          if((searchResult.length != 0 && searchTextController.text.isNotEmpty) && currentBook != null)
            searchFound(),
          if(searchTextController.text.isNotEmpty && currentBook == null)
            searchBook("Search Query Not Found"),
        ],
      ),
    );
  }

  Widget searchBook(String messageText) {
    print(".......Not Searched Book");
    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
        decoration: categoryDecoration,
        width: MediaQuery.of(context).size.width/2,
        height: MediaQuery.of(context).size.height/2,
        child: Text(messageText, style: TextStyle(color: Colors.white, fontSize: 30),),
      ),
    );
  }

  Widget searchFound() {
    print(".......Searched Book");
    ScrollController controller = new ScrollController();
    // return BookWrapList(currentBook, scrollController, bookHover);
    return SingleChildScrollView(
      controller: controller,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(10.00),
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
              for(var currBook in currentBook)
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
                  Hero(
                    tag: "book: ${currBook["id"]}",
                    child: Material(
                      shadowColor: Colors.black,
                      elevation: 1.0,
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25.00),
                      type: MaterialType.card,
                      child: InkWell(
                        enableFeedback: true,
                        hoverColor: Colors.tealAccent.withOpacity(0.6),
                        splashColor: Colors.red.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(25.00),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              BookView.routeName, arguments: BookArguments(currentBook: currBook));
                        },
                        onHover: (hover) {
                          if(hover) {
                            print("......TRUE");
                            bookHover[currBook["id"]]!.value = true;
                          } else {
                            print("......FALSE");
                            bookHover[currBook["id"]]!.value = false;
                          }

                          print("\t --> ${bookHover}");
                          // setState(() {});
                        },
                        child: Container(
                          width: 200,
                          height: 300,
                          decoration: boxDecoration,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25.00),
                                child: currBook["image"],
                                // Image.asset(
                                //   currBook["image"],
                                //   fit: BoxFit.fill,
                                //   height: 300,
                                //   width: double.infinity,
                                //   repeat: ImageRepeat.noRepeat,
                                // ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: bookHover[currBook["id"]]!,
                                builder: (context, value, child) =>
                                bookHover[currBook["id"]]!.value ? Container(
                                  decoration: innerBoxDecoration,
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        currBook["bookName"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            height: 2,
                                            fontSize: 20.00),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        currBook["authorName"],
                                        style: TextStyle(fontSize: 16.00, height: 1.5),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        "\u{20B9} ${currBook["price"]}/-",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16.00,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Tooltip(
                                                message: favourite[currBook["id"]]!.value
                                                    ? "Added to Favourite"
                                                    : "Add to Favourite",
                                                padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
                                                child: InkResponse(
                                                  highlightShape: BoxShape.circle,
                                                  autofocus: false,
                                                  enableFeedback: true,
                                                  splashColor: Colors.red.withOpacity(0.8),
                                                  hoverColor: Colors.red.withOpacity(0.5),
                                                  child: ValueListenableBuilder(
                                                    valueListenable: favourite[currBook["id"]]!,
                                                    builder: (context, value, child) => favourite[currBook["id"]]!.value ? Icon(Icons.favorite_rounded,
                                                      color: Color(0xFFff0000), size: 25,) : Icon(Icons.favorite_outline_rounded,
                                                      color: Color(0xFFff0000), size: 25,),
                                                  ),
                                                  onTap: () async {
                                                    favouriteBook(context, user!, currBook);
                                                    // makeAllHoverOff();
                                                    this.setState(() {});
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Tooltip(
                                                message:  wishList[currBook["id"]]!.value ? "Added to Wish-List" : "Add to Wish-List",
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.00,
                                                    horizontal: 20.00
                                                ),
                                                child: InkResponse(
                                                  highlightShape: BoxShape.circle,
                                                  autofocus: false,
                                                  enableFeedback: true,
                                                  splashColor: Color(0xFF032f4b).withOpacity(0.8),
                                                  hoverColor: Color(0xFF032f4b).withOpacity(0.5),
                                                  child: ValueListenableBuilder(
                                                    valueListenable: wishList[currBook["id"]]!,
                                                    builder: (context, value, child) => wishList[currBook["id"]]!.value ? Icon(
                                                      Icons.bookmark, color: Color(0xFF0000FF), size: 25,) : Icon(
                                                      Icons.bookmark_add_outlined, color: Color(0xFF0000FF), size: 25,),
                                                  ),
                                                  onTap: () async {
                                                    wishListBook(context, user!, currBook);
                                                    this.setState(() {});
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ) : SizedBox(),
                              ),
                              ValueListenableBuilder(
                                valueListenable: bookHover[currBook["id"]]!,
                                builder: (context, value, child) =>
                                bookHover[currBook["id"]]!.value ? Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Tooltip(
                                    textStyle: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                    ),
                                    message: loadBookTooltip(currBook["id"]),
                                    padding: EdgeInsets.all(10.00),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.greenAccent,
                                            offset: const Offset(
                                              0.0,
                                              5.0,
                                            ),
                                            blurRadius: 15.0,
                                            spreadRadius: 8.0,
                                          ),
                                          BoxShadow(
                                            color: Colors.black45,
                                            offset: const Offset(
                                              0.0,
                                              5.0,
                                            ),
                                            blurRadius: 10.0,
                                            spreadRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.info_outline_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ) : SizedBox(),
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
            ],
          ),
    );
  }

  void startSearching() {
    _isSearching = true;
    setState(() {});
  }

  void stopSearching() {
    _isSearching = false;
    searchTextController.clear();
    Navigator.of(context).pop();
    setState(() {});
  }

  void searchOperation(String searchText) {
    startSearching();
    searchResult.clear();
    if (_isSearching) {
      for(var bookID in searchList.keys) {
        for(var value in searchList[bookID]) {
          if(value.contains(searchText.toLowerCase())) {
            searchResult.add(bookID);
            break;
          }
        }
      }
      if(searchResult.length>0) {
        loadHover(searchResult.length, searchResult, bookHover, "searchResult");
        print("\t\tbookHover: ${bookHover.runtimeType}");
        currentBook = getBooksList(searchResult);
        setState(() {});
      }
    }
    if(searchResult.length == 0 && searchTextController.text.isEmpty) {
      _isSearching = false;
      searchResult.clear();
      currentBook = null;
      setState(() {});
    }
    if(searchResult.length == 0 && searchTextController.text.isNotEmpty) {
      searchResult.clear();
      currentBook = null;
      setState(() {});
    }
    if(searchTextController.text.isEmpty) {
      searchResult.clear();
      currentBook = null;
      setState(() {});
    }
  }

  void loadSearchingData() {
    searchList = {};
    for(var book in bookList) {
      var bookDetailsList = Set<dynamic>();
      bookDetailsList.add(book["bookName"].toLowerCase());
      bookDetailsList.add(book["authorName"].toLowerCase());
      String categoryName = getCategoryName(book["category"]);
      print("\tCategory found: $categoryName");
      if(categoryName != "-")
        bookDetailsList.add(categoryName.toLowerCase());
      if(book.keys.contains("keywords")) {
        for(String bookKey in book["keywords"])
          bookDetailsList.add(bookKey.toLowerCase());
      }
      searchList[book["id"]] = bookDetailsList;
    }
  }

  Widget mobileView() {
    return Container();
  }

}


