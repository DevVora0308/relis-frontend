import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:relis/authentication/services.dart';
import 'package:relis/authentication/passwordChange.dart';
import 'package:relis/authentication/signIn.dart';
import 'package:relis/globals.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);
  static const routeName = '/OTPPage';

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _formKey = GlobalKey<FormState>();
  var otpList = ["", "", "", "", "", ""];
  List<FocusNode> focusNode =
      List<FocusNode>.generate(6, (int index) => FocusNode());
  String otpString = "";
  String realOTP = "";
  bool _otpVisible = false;
  bool invalidOTP = false;
  FocusNode verifyOTPnode = FocusNode();
  List<TextEditingController> otpText = List<TextEditingController>.generate(
      6, (int index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    focusNode[0] = FocusNode();
    generateOTP();
  }

  generateOTP() async {
    var rng = new Random();
    realOTP = "";
    for (var i = 0; i < 6; i++) {
      realOTP = realOTP + rng.nextInt(10).toString();
    }
    await sendEmail();
  }

  Future sendEmail() async {
    final service_id = 'service_xd6ttln';
    final template_id = 'template_w7cy5tq';
    final user_id = 'user_ZeaSCRhRLjK9oAEB6moy6';
    String subject = 'ReLis OTP Verification';
    String from_email = 'dev.vora@somaiya.edu';
    String from_name = 'ReLis Team';
    String to_email = !changingPassword ? '${Registeration["emailId"]}': changingEmailID;
    String reply_to = 'dev.vora@somaiya.edu';
    String body;
    if(!changingPassword)
      body =
        '''Hello ${Registeration["firstName"]} ${Registeration["lastName"]};
        This is your registration otp $realOTP.

        Thanks And Regards,\n $from_name.''';
    else
      body =
        '''Hello ${Registeration["firstName"]} ${Registeration["lastName"]};
        This is your otp $realOTP, to change password.

        Thanks And Regards,\n $from_name.''';

    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': service_id,
        'template_id': template_id,
        'user_id': user_id,
        'template_params': {
          'subject': subject,
          'from_email': from_email,
          'to_email': to_email,
          'from_name': from_name,
          'reply_to': reply_to,
          'body': body
        },
      }),
    );
    print('abcd: ${response.body}');
    if (response.body == 'OK') {
      // using a void function because i am using a
      // stateful widget and seting the state from here.
      showMessageSnackBar(context, 'OTP Sent to ${!changingPassword ? '${Registeration["emailId"]}': changingEmailID}', Color(0xFF00FF88));
    } else {
      showMessageSnackBar(context, 'Error', Color(0xFFFF0000));
    }
  }

  // void sendOTP() async {
  //   EmailAuth emailAuth =  new EmailAuth(sessionName: "Verify User");
  //   // var res = await EmailAuth.sendOTP(receiverMail:Registeration['emailId']);
  // void sendOtp() async {
  // if (true) {
  //   // using a void function because i am using a
  //   // stateful widget and seting the state from here.
  //   Fluttertoast.showToast(
  //       msg: 'OTP Sent to ${Registeration['emailId']}',
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: appBackgroundColor,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // } else {
  //   Fluttertoast.showToast(
  //       msg: 'Error',
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: appBackgroundColor,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: Text(appTitle),
        backgroundColor: appBarBackgroundColor,
        shadowColor: appBarShadowColor,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(100),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF1A93EF).withOpacity(0.5),
                shape: BoxShape.rectangle,
                // border: Border.all(width: 2),
                borderRadius: BorderRadius.all(
                  const Radius.circular(8),
                ),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Color(0xFF2C3E50).withOpacity(0.9),
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                    // offset: new Offset(5.0, 5.0),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.00),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: !invalidOTP ? (!changingPassword ? 'Hello ${Registeration["firstName"]}, Please Enter OTP sent to ${Registeration["emailId"]}': "OTP Sent to $changingEmailID") : 'Enter OTP',
                              style: TextStyle(
                                color: Colors.black,
                                height: 2,
                                fontSize: 20,
                              ),
                              children: <TextSpan>[
                                if (invalidOTP)
                                  TextSpan(
                                    text: "  You have entered invalid OTP!!!",
                                    style: TextStyle(
                                      color: Colors.red,
                                      height: 2,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                if (invalidOTP)
                                  TextSpan(
                                    text: " Please Enter valid OTP!",
                                    style: TextStyle(
                                      color: Colors.black,
                                      height: 2,
                                      fontSize: 20,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              for (int i = 0; i < 6; ++i)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 33,
                                      height: 50,
                                      child: TextFormField(
                                        onChanged: (text) {
                                          otpList[i] = text;
                                          if (i < 5)
                                            FocusScope.of(context)
                                                .requestFocus(focusNode[i + 1]);
                                          if (i == 5)
                                            FocusScope.of(context)
                                                .requestFocus(verifyOTPnode);
                                        },
                                        controller: otpText[i],
                                        textInputAction: TextInputAction.done,
                                        autofocus: true,
                                        obscureText: !_otpVisible,
                                        focusNode: focusNode[i],
                                        maxLines: 1,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.white,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        maxLength: 1,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10.5),
                                          hintText: '',
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                          labelText: '',
                                          counterText: "",
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                            height: 1,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              IconButton(
                                tooltip: _otpVisible
                                    ? "Hide Password"
                                    : " Show Password",
                                color: Colors.white,
                                icon: Icon(
                                  _otpVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _otpVisible = !_otpVisible;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: resendOTPButton(),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: verifyButton(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: otpImage(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget resendOTPButton() {
    return MaterialButton(
      elevation: 0.0,
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(15.0),
      ),
      focusElevation: 0.0,
      hoverElevation: 0.0,
      highlightElevation: 0.0,
      hoverColor: Colors.transparent,
      autofocus: false,
      textColor: Colors.white,
      color: Colors.transparent,
      splashColor: Color(0xFF1E8BC3),
      child: Text(
        "Resend OTP",
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
        overflow: TextOverflow.ellipsis,
      ),
      onPressed: () async {
        generateOTP();
        // Center(
        //   child: CircularProgressIndicator(),
        // );
        // if (_key.currentState.validate()) {
        //   _signInWithEmailAndPassword();
        // } else {
        //   showMessageSnackBar("Please fill the valid Details!!");
        // }
      },
    );
  }

  Widget verifyButton() {
    return MaterialButton(
      elevation: 0.0,
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(15.0),
      ),
      focusElevation: 0.0,
      hoverElevation: 0.0,
      highlightElevation: 0.0,
      hoverColor: Colors.transparent,
      autofocus: false,
      focusNode: verifyOTPnode,
      textColor: Color(0xFF1E8BC3),
      color: Colors.white,
      splashColor: Color(0xFF2C3E50).withOpacity(0.3),
      child: Text(
        "Verify",
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        overflow: TextOverflow.ellipsis,
      ),
      onPressed: () async {
        verifyOTP(context, otpList);
      },
    );
  }

  verifyOTP(BuildContext context, var list) {
    print("\n\n In Func!!! \n\n");
    otpString = "";
    for (int i = 0; i < list.length; ++i) {
      otpString = otpString + list[i];
    }
    if (realOTP == otpString) {
      invalidOTP = false;
      print(" Now will enter in if-else");
      if(!changingPassword) {
        print("\t\t in IF");
        Services().signUp(Registeration).then((val) {
          print('Comes after RegService');
          print('$val');
          if (val != null && val.data['success']) {
            // token = val.data['token'];
            showMessageSnackBar(context, 'Account Verified', Color(0xFF00FF88));
            while (Navigator.of(context).canPop()) Navigator.of(context).pop();
            Navigator.of(context).popAndPushNamed(SignInPage.routeName);
          } else {
            invalidOTP = true;
            otpList = ["", "", "", "", "", ""];
            for (int i = 0; i < list.length; ++i) {
              otpText[i].clear();
            }
            showMessageSnackBar(context, 'Error', Color(0xFFFF0000));
          }
        });
      }
      else {
      print("\t\t in else");
        Navigator.of(context).pushNamed(PasswordChange.routeName);
      }
      setState(() {});
    } else {
      invalidOTP = true;
      otpList = ["", "", "", "", "", ""];
      for (int i = 0; i < list.length; ++i) {
        otpText[i].clear();
      }
      showMessageSnackBar(context, 'Invalid OTP', Color(0xFFFF0000));
    }
  }

  Widget otpImage() {
    return Image.asset(
      "images/signin.png",
      fit: BoxFit.contain,
    );
  }
}
