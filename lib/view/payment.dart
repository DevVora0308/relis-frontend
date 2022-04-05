import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relis/authentication/user.dart';
import 'package:relis/globals.dart';
import 'package:relis/widget/bookWrapList.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key? key}) : super(key: key);
  static const routeName = '/PaymentPage';

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  int cartLength = 0, newCartLength = 0;
  double cost = 0;
  
  @override
  void initState() {
    super.initState();
    isLoggedIn(context);
    changePage("Cart");
    print("toRent: ");
    print("${user!["cart"]["toRent"]}");
    print("${(user!["cart"]["toRent"]).runtimeType}");
    print("toBuy: ");
    print("${user!["cart"]["toBuy"]}");
    print("${(user!["cart"]["toBuy"]).runtimeType}");
    cartLength = user!["cart"]["toRent"].length + user!["cart"]["toBuy"].length;
    newCartLength = cartLength;
    getCost();
    Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        newCartLength = user!["cart"]["toRent"].length + user!["cart"]["toBuy"].length;
        if(cartLength != newCartLength) {
          cartLength = newCartLength;
          getCost();
          WidgetsBinding.instance!.addPostFrameCallback((_){
            setState(() {});
          });
        }
      }
    );
  }

  getCost() {
    cost = 0;
    for(var bk in user!["cart"]["toBuy"]) {
      cost += double.parse(bookMap[bk]["price"]);
    }
    for(var bk in user!["cart"]["toRent"]) {
      // double x = 0;
      // cost += ((x/100)* double.parse(bookMap[bk]["price"]));
      cost += (double.parse(bookMap[bk]["price"]) * (0.5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: Text("Your Cart"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              child: Row(
                children: [
                  Text(
                    " Payment = ",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "\u{20B9} $cost/- ",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onPressed: () async {
                // showMessageSnackBar(context, "Payment Gateway Comming Soon!!!", Color(0xFFFF0000));
                await addCartToDb();
              },
              hoverColor: Colors.greenAccent[400],
              color: Colors.green[800],
              elevation: 5.0,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.white,
                ),
                Text(
                  " $cartLength ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
        backgroundColor: appBarBackgroundColor,
        shadowColor: appBarShadowColor,
        elevation: 2.0,
      ),
      body:  SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 700) {
              return desktopView();
            } else {
              return mobileView();
            }
          },
        ),
      ),// bottom[currentIndex],
    );
  }

  Widget desktopView() {
    return Column(
      children: [
        Container(
          // alignment: Alignment.topLeft,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 0.00, horizontal: 20.00),
          margin: EdgeInsets.symmetric(vertical: 0.00, horizontal: 20.00),
          child: Column(
            children: [
              cartView("Buy"),
              customDivider(),
              cartView("Rent"),
            ],
          ),
        ),
      ],
    );
  }

  Widget mobileView() {
    return Container();
  }

  Widget cartView(String cartViewName) {
    var currentBook, bookHover;
    switch(cartViewName) {
      case "Buy":
      {
        currentBook = getBooksMap(user!["cart"]["toBuy"], isList: true);
        loadHover(user!["cart"]["toBuy"].length, user!["cart"]["toBuy"], toBuyHover, "toBuy");
        bookHover = toBuyHover;
      }
      break;
      case "Rent":
      {
        currentBook = getBooksMap(user!["cart"]["toRent"], isList: true);
        loadHover(user!["cart"]["toRent"].length, user!["cart"]["toRent"], toRentHover, "toRent");
        bookHover = toRentHover;
      }
      break;
    }
    print("\t to$cartViewName List: ");
    print(user!["cart"]["to$cartViewName"]);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
          child: Row(
            children: [
              Text(
                'Books to $cartViewName',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: mainAppBlue,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              if(cartViewName == "Rent")
                Text(
                  ' For 7 days',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: mainAppBlue,
                    fontWeight: FontWeight.w200,
                  ),
                ),
            ],
          ),
        ),
        if(currentBook == null || currentBook.length == 0 )
          noBooksInCart("No Books in $cartViewName Cart !!"),
        BookWrapList(currentBook: currentBook, controller: scrollController, bookHover: bookHover, isCart: true),
      ],
    );
  }

  Widget noBooksInCart(String messageText) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.00),
      margin: EdgeInsets.symmetric(vertical: 20.00, horizontal: 20.00),
      width: 600,
      height: 200,
      decoration: categoryDecoration,
      child: Text("$messageText", style: TextStyle(color: Colors.white, fontSize: 30),),
    );
  }

}