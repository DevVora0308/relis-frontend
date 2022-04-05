import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:relis/globals.dart';
import 'package:flutter/material.dart';

class Services {
  Dio dio = new Dio();

  var emailid;

  login(emailId, password, redirect) async {
    print('Comes from SignIn');
    print("EmailId: $emailId");
    print("password: $password");
    try {
      return await dio.post('https://relis-nodejs1.herokuapp.com/authenticate', // http://localhost:3000/authenticate
          data: {"emailId": emailId, "password": password, "redirect": redirect},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xFFFF0000),
          webBgColor: "linear-gradient(to right, #FF0000, #FF4800)",
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  signUp(var Mappy) async {
    print('Comes from OTP');
    if (Mappy != null) {
      print('Mappy: ${Mappy.runtimeType}');
      print('Mappy: $Mappy');
      print("FirstName: ${Mappy['firstName']}");
      print("LastName: ${Mappy['lastName']}");
      print("EmailId: ${Mappy['emailId']}");
      print("password: ${Mappy['password']}");

      try {
        return await dio.post('https://relis-nodejs1.herokuapp.com/adduser',
            data: {
              "firstName": Mappy['firstName'],
              "lastName": Mappy['lastName'],
              "emailId": Mappy['emailId'],
              "password": Mappy['password']
            },
            options: Options(contentType: Headers.formUrlEncodedContentType));
      } on DioError catch (e) {
        Fluttertoast.showToast(
            msg: e.response?.data['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: appBackgroundColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      print('Did not receive Reg Data');
    }
  }

  changePassword(emailId, password) async {
    print('Comes from OTP');
    print("EmailId: $emailId");
    print("New password: $password");
    try {
      return await dio.post('https://relis-nodejs1.herokuapp.com/changePassword',
          data: {"emailId": emailId, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getUserDetails(emailId, userId) async {
    try {
      print("...Sending Request");
      var response =  await dio.post('https://relis-nodejs1.herokuapp.com/getUserDetails',
          data: {"emailId": emailId, "userId": userId},
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
          )).whenComplete(() => print("Got Response data ..."));
      print("...Received response");
      return response;
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response?.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  addToFavourites(emailId, bookId) async {
    try {
      return await dio.post('https://relis-nodejs1.herokuapp.com/addToFavourites',
          data: {"emailId": emailId, "bookId": bookId},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  removeFromFavourites(emailId, bookId) async {
    try {
      return await dio.post('https://relis-nodejs1.herokuapp.com/removeFromFavourites',
          data: {"emailId": emailId, "bookId": bookId},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  
  addToWishList(emailId, bookId) async {
    try {
      return await dio.post('https://relis-nodejs1.herokuapp.com/addToWishList',
          data: {"emailId": emailId, "bookId": bookId},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  removeFromWishList(emailId, bookId) async {
    try {
      return await dio.post('https://relis-nodejs1.herokuapp.com/removeFromWishList',
          data: {"emailId": emailId, "bookId": bookId},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getAllBooks(emailId) async {
    try {
      return await dio.post('https://relis-nodejs1.herokuapp.com/getAllBooks',
          data: {"emailId": emailId},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  
  getBookImage(emailId, bookId) async {
    try {
      return await dio.post('https://relis-nodejs1.herokuapp.com/getBookImage',
          data: {"emailId": emailId, "bookId": bookId},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  updateCart(emailId, cartMap) async {
    try {
      return await dio.post(
          'https://relis-nodejs1.herokuapp.com/updateCart',
          data: {"emailId": emailId, "cartMap": jsonEncode(cartMap)},
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  
  buyBooks(emailId, cartMap, booksBoughtMap, booksRentedMap) async {
    try {
      return await dio.post(
          'https://relis-nodejs1.herokuapp.com/buyBooks',
          data: {
            "emailId": emailId,
            "cartMap": jsonEncode(cartMap),
            "booksBoughtMap": jsonEncode(booksBoughtMap),
            "booksRentedMap": jsonEncode(booksRentedMap),
          },
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
          textColor: Colors.white,
          fontSize: 16.0,
        );
    }
  }

  changeLastPageRead(emailId, booksReadMap) async {
    try {
      return await dio.post(
          'https://relis-nodejs1.herokuapp.com/changeLastPageRead',
          data: {
            "emailId": emailId,
            "booksReadMap": jsonEncode(booksReadMap),
          },
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
          textColor: Colors.white,
          fontSize: 16.0,
        );
    }
  }

  addReward(emailId, dailyRecords, credits) async {
    try {
      print("dailyRecords: ");
      print(dailyRecords);
      return await dio.post(
          'https://relis-nodejs1.herokuapp.com/addReward',
          data: {"emailId": emailId, "dailyRecords": jsonEncode(dailyRecords), "credits": credits},
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  addFeedback(emailId, bookId, comment, rating) async {
    try {
      return await dio.post('https://relis-nodejs1.herokuapp.com/addFeedback',
        data: {
          "emailId": emailId,
          "bookId": bookId,
          "comment": comment,
          "rating": rating,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response?.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  
  addPersonalBooks(emailId, personalBook) async {
  print("... in Services addPersonalBooks");
    try {
      return await dio.post('https://relis-nodejs1.herokuapp.com/addPersonalBooks',
        data: {
          "emailId": emailId,
          "personalBook": personalBook,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      ).timeout(Duration(seconds: 30),onTimeout: (){
        print("...returning");
        return Future.value(Response(
          data: {
            "success": false,
            "message": "Timeout error!!"
            },
          requestOptions: RequestOptions(path: "")
          )
        );
      },);
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response?.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  getBookFile(emailId, bookId) async {
    try {
      print("...Sending Request");
      var response =  await dio.post('https://relis-nodejs1.herokuapp.com/getBookFile',
          data: {"emailId": emailId, "bookId": bookId},
          options: Options(contentType: Headers.formUrlEncodedContentType)).whenComplete(() => print("Got Response data ..."));
      print("...Received response");
      return response;
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response?.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  getAudioBook(emailId, bookId) async {
    try {
      print("...Sending Request");
      var response =  await dio.post('https://relis-nodejs1.herokuapp.com/getAudioBook',
          data: {"emailId": emailId, "bookId": bookId},
          options: Options(contentType: Headers.formUrlEncodedContentType)).whenComplete(() => print("Got Response data ..."));
      print("...Received response");
      return response;
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response?.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  getAudioBookFile(emailId, bookId, audioId) async {
    try {
      print("...Sending Request");
      var response =  await dio.post('https://relis-nodejs1.herokuapp.com/getAudioBookFile',
          data: {"emailId": emailId, "bookId": bookId, "audioId": audioId},
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
          )).whenComplete(() => print("Got Response data ..."));
      print("...Received response");
      return response;
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response?.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

}


