import 'package:flutter/material.dart';
import 'package:relis/arguments/bookArguments.dart';
import 'package:relis/authentication/user.dart';
import 'package:relis/globals.dart';
import 'package:relis/view/bookView.dart';


class BookPreview extends StatefulWidget {
  BookPreview({required this.currentBook, required this.bookHover, this.isCart});

  final Map<String, dynamic> currentBook;
  final Map<String, ValueNotifier<bool>> bookHover;
  bool? isCart;

  @override
  _BookPreviewState createState() => _BookPreviewState();
}

class _BookPreviewState extends State<BookPreview> {


  @override
  void initState() {
    super.initState();
    isLoggedIn(context);
    loadValues(user!, widget.currentBook);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
                BookView.routeName, arguments: BookArguments(currentBook: widget.currentBook));
          },
          onHover: (hover) {
            if(hover) {
              print("......TRUE - Hovering ${widget.currentBook["bookName"]}");
              widget.bookHover[widget.currentBook["id"]]!.value = true;
            } else {
              print("......FALSE - Hovering ${widget.currentBook["bookName"]}");
              widget.bookHover[widget.currentBook["id"]]!.value = false;
            }

            // print("\t --> ${widget.bookHover}");
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
                  child: widget.currentBook["image"],
                  // child: Image.asset(
                  //   widget.currentBook["image"],
                  //   fit: BoxFit.fill,
                  //   height: 300,
                  //   width: double.infinity,
                  //   repeat: ImageRepeat.noRepeat,
                  // ),
                ),
                ValueListenableBuilder(
                  valueListenable: widget.bookHover[widget.currentBook["id"]]!,
                  builder: (context, value, child) =>
                  widget.bookHover[widget.currentBook["id"]]!.value ? Container(
                    decoration: innerBoxDecoration,
                    constraints: BoxConstraints(
                      maxHeight: (user!["cart"]["toRent"].contains(widget.currentBook["id"])) ? 140 : 120,
                    ),
                    // height: (user!["cart"]["toRent"].contains(widget.currentBook["id"])) ? 160 : 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          widget.currentBook["bookName"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 2,
                              fontSize: 20.00),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                        Text(
                          widget.currentBook["authorName"],
                          style: TextStyle(fontSize: 16.00, height: 1.5),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                        Text(
                          "\u{20B9} ${widget.currentBook["price"]}/-",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16.00,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                        if(user!["cart"]["toRent"].contains(widget.currentBook["id"]))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Rental Price: ",
                                style: TextStyle(
                                  fontSize: 12.00,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                              Text(
                                "\u{20B9} ${(double.parse(widget.currentBook["price"]) * (0.5))}/-",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16.00,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                              Text(
                                " for 7 days.",
                                style: TextStyle(
                                  fontSize: 12.00,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Tooltip(
                                  message: favourite[widget.currentBook["id"]]!.value
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
                                      valueListenable: favourite[widget.currentBook["id"]]!,
                                      builder: (context, value, child) => favourite[widget.currentBook["id"]]!.value ? Icon(Icons.favorite_rounded,
                                        color: Color(0xFFff0000), size: 25,) : Icon(Icons.favorite_outline_rounded,
                                        color: Color(0xFFff0000), size: 25,),
                                    ),
                                    onTap: () async {
                                      favouriteBook(context, user!, widget.currentBook);
                                      // makeAllHoverOff();
                                      this.setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Tooltip(
                                  message:  wishList[widget.currentBook["id"]]!.value ? "Added to Wish-List" : "Add to Wish-List",
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
                                      valueListenable: wishList[widget.currentBook["id"]]!,
                                      builder: (context, value, child) => wishList[widget.currentBook["id"]]!.value ? Icon(
                                        Icons.bookmark, color: Color(0xFF0000FF), size: 25,) : Icon(
                                        Icons.bookmark_add_outlined, color: Color(0xFF0000FF), size: 25,),
                                    ),
                                    onTap: () async {
                                      wishListBook(context, user!, widget.currentBook);
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
                  valueListenable: widget.bookHover[widget.currentBook["id"]]!,
                  builder: (context, value, child) =>
                  widget.bookHover[widget.currentBook["id"]]!.value ? Positioned(
                    top: 5,
                    right: 5,
                    child: Tooltip(
                      textStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                      message: widget.isCart ?? false ? "Remove from Cart" : loadBookTooltip(widget.currentBook["id"]),
                      padding: EdgeInsets.all(10.00),
                      child: Container(
                        width: 50,
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
                          borderRadius: BorderRadius.all(Radius.circular(1000.00)),
                        ),
                        child: widget.isCart ?? false ? Container(
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(1000.00)),
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              await removeFromCart(context, widget.currentBook["id"], widget.currentBook["bookName"]);
                              this.setState(() {});
                            },
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                            ),
                            elevation: 2.0,
                            color: Color(0xFFFF0000),
                          )
                        ) : Icon(
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
      );
  }
}