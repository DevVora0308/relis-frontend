import 'dart:convert';
import 'dart:html' as webFile;
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:relis/arguments/bookArguments.dart';
import 'package:relis/audioBook/audiobook.dart';
import 'package:relis/authentication/services.dart';
import 'package:relis/authentication/user.dart';
import 'package:relis/drawer.dart';
import 'package:relis/globals.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:relis/view/pdfLoader.dart';
import 'package:relis/view/pdfViewer.dart';
import 'package:translator/translator.dart';

class BookView extends StatefulWidget {
  const BookView({Key? key}) : super(key: key);
  static const routeName = '/BookView';

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  ValueNotifier<bool> favBook = ValueNotifier<bool>(false);
  ValueNotifier<bool> wishBook = ValueNotifier<bool>(false);
  String myComment = "";
  var userCommentInfo = {};
  TextEditingController myCommentController = new TextEditingController();
  var feedbackMap = {};
  bool addedToCart = false;
  late String currentLang = "English (US)";  
  final translator = GoogleTranslator(); 
  List<String> lang = [];
  ValueNotifier<String> bookDescription = ValueNotifier<String>("");
  var fileData, fileTranslatedData;
  bool translated = false, bookDataFetched = false;
  String initialDescription = "";
  var newComment = {};

  Map<String, String> langCodes = {
    "Amharic": "am",
    "Arabic": "ar",
    "Basque": "eu",
    "Bengali": "bn",
    "English (UK)": "en-GB",
    "Portuguese (Brazil)": "pt-BR",
    "Bulgarian": "bg",
    "Catalan": "ca",
    "Cherokee": "chr",
    "Croatian": "hr",
    "Czech": "cs",
    "Danish": "da",
    "Dutch": "nl",
    "English (US)": "en",
    "Estonian": "et",
    "Filipino": "fil",
    "Finnish": "fi",
    "French": "fr",
    "German": "de",
    "Greek": "el",
    "Gujarati": "gu",
    "Hebrew": "iw",
    "Hindi": "hi",
    "Hungarian": "hu",
    "Icelandic": "is",
    "Indonesian": "id",
    "Italian": "it",
    "Japanese": "ja",
    "Kannada": "kn",
    "Korean": "ko",
    "Latvian": "lv",
    "Lithuanian": "lt",
    "Malay": "ms",
    "Malayalam": "ml",
    "Marathi": "mr",
    "Norwegian": "no",
    "Polish": "pl",
    "Portuguese (Portugal)": "pt-PT",
    "Romanian": "ro",
    "Russian": "ru",
    "Serbian": "sr",
    "Chinese (PRC)": "zh-CN",
    "Slovak": "sk",
    "Slovenian": "sl",
    "Spanish": "es",
    "Swahili": "sw",
    "Swedish": "sv",
    "Tamil": "ta",
    "Telugu": "te",
    "Thai": "th",
    "Chinese (Taiwan)": "zh-TW",
    "Turkish": "tr",
    "Urdu": "ur",
    "Ukrainian": "uk",
    "Vietnamese": "vi",
    "Welsh": "cy",
  };

  loadValues(Map<String, dynamic> user, Map<String, dynamic> currentBook) async {
    lang = langCodes.keys.toList()..sort();
    // for(var key in currentBook.keys) {
    //   print("\t ${key}");
    // }
    // print("Received currentBook");
    favBook.value = isFavourite(user, currentBook["id"]);
    // print("\tGot fav.");
    wishBook.value = isWishList(user, currentBook["id"]);
    // print("\tGot wishBook.");
    feedbackMap = currentBook.containsKey("feedback") ? currentBook["feedback"] : {};
    // print("\tGot feedbackMap.");
    if(feedbackMap.length>0)
      for(var userComment in feedbackMap.values) {
        userCommentInfo[userComment["userId"]] = await getUserInfo(userComment["userId"]);
      }
    addedToCart = (user["cart"]["toRent"].contains(currentBook["id"]) || user["cart"]["toBuy"].contains(currentBook["id"])) || (isBookBought(currentBook["id"]) || isBookRented(currentBook["id"]));
    // print("\t rentCart: ${user["cart"]["toRent"].contains(currentBook["id"])}");
    // print("\t buyCart: ${user["cart"]["toBuy"].contains(currentBook["id"])}");
    // print("\t isBookBought: ${isBookBought(currentBook["id"])}");
    // print("\t isBookRented: ${isBookRented(currentBook["id"])}");
    // print("\t addedToCart: $addedToCart");
    // var or1 = (isBookBought(currentBook["id"]) || isBookRented(currentBook["id"]));
    // print("\t or-1: $or1");
    // var not1 = !or1; // && and1;
    // print("\t not1: $not1");
    // var and1 = not1 && addedToCart;
    // print("\t\t and1: $and1");
    bookDescription.value = bookDescription.value == "" ? initialDescription : bookDescription.value;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn(context);
    final book = ModalRoute.of(context)!.settings.arguments as BookArguments;
    print("\tIn Book View");
    // print("\tbookType: ${book.currentBook.runtimeType}");
    initialDescription = book.currentBook["description"];
    Future.delayed(Duration.zero, () async {
      await loadValues(user!, book.currentBook);
    });
    print("Book Values Loaded");
    return Hero(
      tag: "book: ${book.currentBook["id"]}",
      child: Scaffold(
        backgroundColor: appBackgroundColor,
        appBar: AppBar(
          title: Text(book.currentBook["bookName"]),
          backgroundColor: appBarBackgroundColor,
          shadowColor: appBarShadowColor,
          elevation: 2.0,
        ),
        drawer: AppDrawer(), //DrawerPage(),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 700) {
              return desktopView(book.currentBook);
            } else {
              return mobileView(book.currentBook);
            }
          },
        ),
      ),
    );
  }

  Widget desktopView(var currentBook) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
      margin: EdgeInsets.symmetric(vertical: 0.00, horizontal: 20.00),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Transform.scale(
              scale: MediaQuery.of(context).size.width<=1000 ? 0.8 : 1.0,
              child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 300,
                        decoration: boxDecoration,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.00),
                          child: currentBook["image"],
                          // child: Image.asset(
                          //   currentBook["image"],
                          //   fit: BoxFit.fill,
                          //   height: 500,
                          //   width: double.infinity,
                          //   repeat: ImageRepeat.noRepeat,
                          // ),
                        ),
                      ), //Book-Image
                      SizedBox(height: 20,),
                      // For Rent / Buy Button
                      if(!addedToCart)// || (isBookBought(currentBook["id"]) && isBookRented(currentBook["id"])))
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: MaterialButton(
                                elevation: 2.0,
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: new BorderRadius.circular(15.0),
                                ),
                                focusElevation: 20.0,
                                hoverElevation: 10.0,
                                highlightElevation: 5.0,
                                hoverColor: Colors.orangeAccent,
                                autofocus: false,
                                enableFeedback: true,
                                textColor: Colors.white,
                                color: Colors.orange,
                                splashColor: Colors.orange,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Icon(Icons.timelapse_rounded, color: Colors.white,),
                                    ),
                                    SizedBox(width: 10.00,),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Rent",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  await addToCart(context, currentBook["id"], currentBook["bookName"], isRent: true);
                                  addedToCart = true;
                                  await loadValues(user!, currentBook);
                                  setState((){
                                    print("SetState Called");
                                  });
                                },
                              ),
                            ), // For Rent Button
                            SizedBox(width: 20,),
                            Expanded(
                              child: MaterialButton(
                                elevation: 2.0,
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: new BorderRadius.circular(15.0),
                                ),
                                focusElevation: 20.0,
                                hoverElevation: 10.0,
                                highlightElevation: 5.0,
                                hoverColor: Colors.orangeAccent.withOpacity(0.5),
                                autofocus: false,
                                enableFeedback: true,
                                textColor: Colors.white,
                                color: Colors.deepOrange,
                                splashColor: Colors.deepOrange,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Icon(Icons.shopping_cart_rounded, color: Colors.white,),
                                    ),
                                    SizedBox(width: 10.00,),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Buy",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  await addToCart(context, currentBook["id"], currentBook["bookName"], isRent: false);
                                  addedToCart = true;
                                  await loadValues(user!, currentBook);
                                  setState((){
                                    print("SetState Called");
                                  });
                                },
                              ),
                            ), // For Buy Button
                          ],
                        ),
                      // Added To Cart Button
                      if(!(isBookBought(currentBook["id"]) || isBookRented(currentBook["id"])) && addedToCart)
                        MaterialButton(
                          elevation: 2.0,
                          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xFF032f4b),
                            ),
                            borderRadius: new BorderRadius.circular(15.0),
                          ),
                          focusElevation: 20.0,
                          hoverElevation: 10.0,
                          highlightElevation: 5.0,
                          hoverColor: Color(0xff0f4261),
                          autofocus: false,
                          enableFeedback: true,
                          textColor: Colors.white,
                          color: Color(0xFF032f4b),
                          splashColor: Color(0xFF032f4b).withOpacity(0.9),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Icon(Icons.shopping_cart_rounded, color: Colors.white,),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Added to Cart",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            removeFromCart(context, currentBook["id"], currentBook["bookName"]);
                            addedToCart = false;
                            await loadValues(user!, currentBook);
                            setState((){
                              print("SetState Called");
                            });
                          },
                        ), 
                      if(!isBookBought(currentBook["id"]) || !isBookRented(currentBook["id"]))
                        SizedBox(height: 20,),
                      if(isBookBought(currentBook["id"]) || isBookRented(currentBook["id"]))
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 2,
                              child: MaterialButton(
                                elevation: 2.0,
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Color(0xFF032f4b),
                                  ),
                                  borderRadius: new BorderRadius.circular(15.0),
                                ),
                                focusElevation: 20.0,
                                hoverElevation: 10.0,
                                highlightElevation: 5.0,
                                hoverColor: Color(0xff0f4261),
                                autofocus: false,
                                enableFeedback: true,
                                textColor: Colors.white,
                                color: Color(0xFF032f4b),
                                splashColor: Color(0xFF032f4b).withOpacity(0.9),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Icon(Icons.menu_book_rounded, color: Colors.white,),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Read",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  addToHistory(user!, currentBook);
                                  print("url: ${currentBook["url"]}");
                                  WidgetsBinding.instance!.addPostFrameCallback((_) async {
                                    var bookData;
                                    if(!translated) {
                                      fileData = await getBookData(currentBook["id"]);
                                      // printData(fileData);
                                      bookData = fileData;
                                      // bookData = Uint8List.fromList(fileData);
                                    }
                                    else {
                                      bookData = Uint8List.fromList(fileTranslatedData);
                                    }
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PDFViewer(
                                          bookId: currentBook["id"],
                                          fileData: bookData,
                                        ),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),  // Read Now Button
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 2,
                              child: translatorDropdown(currentBook["id"]),
                            ),  // Translation Dropdown Button 
                          ],
                        ), 
                      if(!isBookBought(currentBook["id"]) || !isBookRented(currentBook["id"]))
                        SizedBox(height: 20,),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Tooltip(
                                message: favBook.value ? "Added to Favourite" : "Add to Favourite",
                                padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
                                child: InkResponse(
                                  highlightShape: BoxShape.circle,
                                  autofocus: false,
                                  enableFeedback: true,
                                  splashColor: Colors.red.withOpacity(0.8),
                                  hoverColor: Colors.red.withOpacity(0.5),
                                  child: ValueListenableBuilder(
                                    valueListenable: favBook,
                                    builder: (context, value, child) => favBook.value ? Icon(Icons.favorite_rounded,
                                      color: Color(0xFFff0000), size: 30,) : Icon(Icons.favorite_outline_rounded,
                                      color: Color(0xFFff0000), size: 30,),
                                  ),
                                  onTap: () async {
                                    this.setState(() async {
                                      favouriteBook(context, user!, currentBook);
                                      await loadValues(user!, currentBook);
                                      setState(() {});
                                    });
                                  },
                                ),
                              ),
                            ), //Favourite Button
                            if(isBookBought(currentBook["id"]) || isBookRented(currentBook["id"]))
                              Expanded(
                                child: Tooltip(
                                  message: "Listen to AudioBook",
                                  child: MaterialButton(
                                    elevation: 2.0,
                                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Color(0xFF032f4b),
                                      ),
                                      borderRadius: new BorderRadius.circular(15.0),
                                    ),
                                    focusElevation: 20.0,
                                    hoverElevation: 10.0,
                                    highlightElevation: 5.0,
                                    hoverColor: Color(0xff0f4261),
                                    autofocus: false,
                                    enableFeedback: true,
                                    textColor: Colors.white,
                                    color: Color(0xFF032f4b),
                                    splashColor: Color(0xFF032f4b).withOpacity(0.9),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Icon(Icons.multitrack_audio_rounded, color: Colors.white,),
                                    ),
                                    onPressed: () async {
                                      // Navigator.of(context).pushNamed(AudioBook.routeName);
                                      WidgetsBinding.instance!.addPostFrameCallback((_) async {
                                        print("going in getAudioBook");
                                        var audioBook = await getAudioBook(currentBook["id"]);
                                        print("out of getAudioBook");
                                        print("going in getAudioBookFile");
                                        var index = 0;
                                        var audioBytes = await getAudioBookFile(currentBook["id"], audioBook[index]["id"]);
                                        print("out of getAudioBookFile");
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => AudioBook(
                                              book: currentBook,
                                              audioBook: audioBook,
                                              audioBytes: audioBytes,
                                              index: index,
                                            ),
                                          ),
                                        );
                                      });
                                      
                                    },
                                  ),
                                ),
                              ), // AudioBook Button
                            Expanded(
                              child: Tooltip(
                                message: wishBook.value ? "Added to Wish-List" : "Add to Wish-List",
                                padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
                                child: InkResponse(
                                  highlightShape: BoxShape.circle,
                                  autofocus: false,
                                  enableFeedback: true,
                                  splashColor: Color(0xFF032f4b).withOpacity(0.8),
                                  hoverColor: Color(0xFF032f4b).withOpacity(0.5),
                                  child: ValueListenableBuilder(
                                    valueListenable: wishBook,
                                    builder: (context, value, child) => wishBook.value ? Icon(
                                      Icons.bookmark, color: Color(0xFF0000FF), size: 30,) : Icon(
                                      Icons.bookmark_add_outlined, color: Color(0xFF0000FF), size: 30,),
                                  ),
                                  onTap: () async {
                                    this.setState(() async {
                                      wishListBook(context, user!, currentBook);
                                      await loadValues(user!, currentBook);
                                      setState(() {});
                                    });
                                  },
                                ),
                              ),
                            ), //Wish-List Button
                          ],
                        ),
                      ), // Fav. / Audio-Book / Wish-List Button
                    ],
                  ),
                ),
            ),
          ), // Book-Image and Options to read/listen, buy/rent, fav./wish-list Book
          SingleChildScrollView(
            child: Expanded(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width*0.7,
                padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      currentBook["bookName"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.wavy,
                          decorationThickness: 1.0,
                          fontSize: 45,
                          color: Color(0xFF154360),
                          height: 2),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ), // bookName
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: showBookAuthorName(currentBook["authorName"]),
                        ),
                        Expanded(
                          child: showBookGenre(currentBook["category"]),
                        ),
                        Expanded(
                          child: showBookPrice(currentBook["price"]),
                        ),
                      ],
                    ), // authorName, category, price
                    ValueListenableBuilder(
                      valueListenable: bookDescription,
                      builder: (BuildContext context, String value, Widget? child) {
                        return showBookDescription(bookDescription.value);
                      },
                    ),
                    SizedBox(height: 20,),
                    showCommentBox(context, currentBook),
                  ],
                ),
              ),
            ),
          ), //Book details and feedbacks
        ],
      ),
    );
  }
  
  Widget showBookAuthorName(String authorName) {
    return RichText(
      text: TextSpan(
        text: 'Author: ',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          color: Colors.black,
          height: 2,
          fontSize: 14,
        ),
        children: <TextSpan>[
          TextSpan(
            text: authorName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF154360),
                height: 1),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      maxLines: 1,
    );
  }

  Widget showBookGenre(String genre) {
    return RichText(
      text: TextSpan(
        text: 'Genre:  ',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          color: Colors.black,
          height: 2,
          fontSize: 14,
        ),
        children: <TextSpan>[
          TextSpan(
            text: getCategoryName(genre),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF154360),
                height: 1),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }

  Widget showBookPrice(String price) {
    return RichText(
      text: TextSpan(
        text: 'Price: ',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          color: Colors.black,
          height: 2,
          fontSize: 14,
        ),
        children: <TextSpan>[
          TextSpan(
            text: "\u{20B9} ${price}/-",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF154360),
            ),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }

  Widget mobileView(var currentBook){
    return Container();
  }

  getUserInfo(String userId) async {
    var userInfo = {};
    var feedUser = await getUserDetails(user?["emailId"], userId);
    print("feedUser: ");
    print(feedUser);
    userInfo["userId"] = feedUser?["emailId"];
    userInfo["name"] = feedUser?["firstName"] + " " + feedUser?["lastName"];
    userInfo["imageURL"] = feedUser?["imageURL"] != null ? (feedUser?["imageURL"] == "assets/ReLis.gif" ? null : feedUser?["imageURL"]) : null;
    print("out of getUserInfo");
    return userInfo;
  }

  Widget showBookDescription(String description) {
    return Container(
      decoration: boxDecoration,
      margin: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
      padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
      child: RichText(
        text: TextSpan(
          text: 'Description:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.solid,
            color: Color(0xFF154360),
            height: 2,
            fontSize: 20,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "    "+description,
              style: TextStyle(
                color: Color(0xFF154360),
                height: 2,
                fontSize: 18,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bookRatingBar(double rating, bool isModifiable) {
    return RatingBar.builder(
      initialRating: rating,
      minRating: 1,
      maxRating: 5,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemSize: isModifiable ? 35 : 20,
      itemCount: 5,
      ignoreGestures: !isModifiable,
      updateOnDrag: isModifiable,
      tapOnlyMode: false,
      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        newComment["rating"] = rating;
        print(rating);
      },
    );
  }

  Widget commentUserRating(String rating) {
    return bookRatingBar(double.parse(rating), false);
    // return Text(
    //   "Rating: "+rating+"/5",
    //   style: TextStyle(
    //     color: mainAppAmber,
    //     fontSize: 18,
    //   ),
    //   maxLines: 1,
    //   overflow: TextOverflow.ellipsis,
    // );
  }

  Widget showCommentBox(BuildContext context, var currentBook) {
    print("in scb");
    print("${userCommentInfo}");
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: commentBoxDecoration,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  onChanged: (text) {
                    myComment = text;
                    newComment["comment"] = myComment;
                  },
                  controller: myCommentController,
                  textInputAction: TextInputAction.done,
                  autofocus: false,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    hintText: '',
                    hintStyle: TextStyle(
                      height: 0.7,
                      color: Colors.white,
                    ),
                    labelText: 'Enter your view on this book...',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      height: 1,
                    ),
                    prefixIcon: Icon(Icons.add_reaction_rounded, color: Colors.white),
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
              ), // TextBox
              SizedBox(width: 20,),
              bookRatingBar(0, true), // Rating bar
              SizedBox(width: 20,),
              IconButton(
                onPressed: () async {
                  await sendFeedback(context, currentBook["id"], newComment);
                },
                icon: Icon(Icons.send_rounded, color: Colors.white,),
                alignment: Alignment.center,
                color: Colors.white,
                padding: EdgeInsets.all(10.00),
                splashColor: mainAppAmber,
                tooltip: "Post your Comment!!!",
              ), // Post Comment Button
            ],
          ), // TextBox, RatingBar, Post-button
          SizedBox(height: 20,),
          if(feedbackMap.length>0)
            for(var userComment in feedbackMap.values)
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.00),
                          decoration: BoxDecoration(
                            color: commentBoxColor,
                            borderRadius: BorderRadius.all(Radius.circular(20.00)),
                            border: Border.all(
                              color: mainAppAmber,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: userCommentInfo[userComment["userId"]]["imageURL"] != null ? NetworkImage(userCommentInfo[userComment["userId"]]["imageURL"]) : Image.asset("ReLis.gif").image,
                                    backgroundColor: Color(0xFF032f4b),
                                    radius: 25.00,
                                  ),
                                  SizedBox(width: 10.00,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      commentUserRating(userComment["rating"].toString()),
                                      Text(
                                        userCommentInfo[userComment["userId"]]["name"],
                                        style: TextStyle(
                                          color: mainAppAmber,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10.00,),
                              Text(
                                userComment["comment"],
                                style: TextStyle(
                                  color: mainAppAmber,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                ],
            ),
        ],
      ),
    );
  }

  Widget translatorDropdown(String bookId) {
    return Tooltip(
      message: "Choose Language to Translate Book",
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
        decoration: BoxDecoration(
          color: Color(0xFF032f4b),
          borderRadius: BorderRadius.all(
            Radius.circular(15.00)
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.g_translate_rounded,
              color: Colors.tealAccent,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.00)
                ),
                alignment: Alignment.center,
                value: currentLang,
                style: TextStyle(
                  color: Colors.tealAccent,
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
                dropdownColor: Color(0xFF032f4b),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.tealAccent,
                ),
                items: lang.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) async { 
                  setState(() {
                    currentLang = newValue!;
                  });
                  await startTranslating(bookId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getBookData(String bookId) async {
    print("going in getBookFile");
    fileData = await getBookFile(bookId);
    bookDataFetched = true;
    print("out of getBookFile");
    return fileData;
  }

  startTranslating(String bookId) async {
    if(!bookDataFetched) {
      fileData = await getBookData(bookId);
    }
    print("... going in printData");
    printData(fileData);
    print("... out printData");
    print("currentLang changes to $currentLang");
    // await translator.translate(initialDescription, to: langCodes[currentLang]!)
    //   .then((result) {
    //     print("... in startTranslating");
    //     fileTranslatedData = utf8.encode(result.toString());
    //     print("...lenght: ${fileTranslatedData.length}");
    //     printData(fileTranslatedData);
    //   });
    await translator.translate(initialDescription, to: langCodes[currentLang]!)
      .then((result) {
        print("... in startTranslating for Description");
        print("$result");
        bookDescription.value = "$result";
      });
    translated = true;
    setState(() {});
    // print("... in startTranslating");
    // var file = await PDFLoader.loadAsset("/book/book1.pdf");
  }


  printData(var data) async {
    print("Fuccccccccccck");
    // List<int> bytes = [];
    // for(int i=0; i<100; ++i) {
    //   bytes.add(data[i]);
    // }
    // print(bytes);
    // String bar = String.fromCharCodes(bytes); // utf8.decode(bytes);
    var book = new webFile.File(data, "this");
    final reader = webFile.FileReader();
    // var list = await book.slice(0,5);
    print("\t ... list Length ");
    print("\t ${book.runtimeType} ");
    print("\t ${book.name} ");
    print("\t ${book.size} ");
    reader.readAsArrayBuffer(book);
    var texttt;
    reader.onLoad.listen((data) {
      setState(() {
        print("\t\t data loaded: ");
        print(data.loaded);
        // print(data);
        texttt = reader.result;
      });
    });
    reader.onLoadEnd.listen((data) {
      setState(() {
        print("\t\t data loaded: ");
        print(data);
        print(texttt.toString());
      });
    });
    reader.onError.listen((fileEvent) {
      setState(() {
        texttt = "Some Error occured while reading the file";
      });
    });
    print("Fuuuuuuuccccccccccck");
    // print(bar);
  }

}
