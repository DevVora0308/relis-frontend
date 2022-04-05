import 'package:flutter/material.dart';
import 'package:relis/authentication/user.dart';
import 'package:relis/bookInfo.dart';
import 'package:relis/globals.dart';
import 'package:relis/widget/bookPreview.dart';

class BookScrollList extends StatefulWidget {
  BookScrollList({required this.bookHover, required this.controller, required this.currentBook, required this.type});
  var currentBook;
  ScrollController controller;
  Map<String, ValueNotifier<bool>> bookHover;
  pageType type;


  @override
  _BookScrollListState createState() => _BookScrollListState();
}

class _BookScrollListState extends State<BookScrollList> {

  @override
  void initState() {
    super.initState();
    // getHover(widget.type, widget.bookHover, widget.currentBook);
    print("IN BOOK SCROLL LIST ---> ");
    print("runtimetype: ${widget.currentBook.runtimeType}");
    // print(widget.bookHover);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
    controller: widget.controller,
    child: SingleChildScrollView(
      controller: widget.controller,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(10.00),
      child: Container(
        alignment: Alignment.center,
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
            for(var curBook in widget.currentBook.values)
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
                  BookPreview(currentBook: curBook, bookHover: widget.bookHover,),
                  SizedBox(width: 20,),
                ],
              ),
          ],
        ),
      ),
    ),
  );
  }
}
