import 'package:flutter/material.dart';
import 'package:relis/globals.dart';
import 'package:relis/widget/bookPreview.dart';

class BookWrapList extends StatefulWidget {
  BookWrapList({required this.bookHover, required this.controller, required this.currentBook, this.isCart});
  var currentBook;
  ScrollController controller;
  Map<String, ValueNotifier<bool>> bookHover;
  bool? isCart = false;


  @override
  _BookWrapListState createState() => _BookWrapListState();
}

class _BookWrapListState extends State<BookWrapList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
    controller: widget.controller,
    child: SingleChildScrollView(
      controller: widget.controller,
      scrollDirection: Axis.vertical,
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
                  BookPreview(currentBook: curBook, bookHover: widget.bookHover, isCart: widget.isCart),
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
