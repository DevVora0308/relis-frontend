import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:relis/authentication/passwordChange.dart';
import 'package:relis/authentication/signUp.dart';
import 'package:relis/authentication/user.dart';
import 'package:relis/globals.dart';
import 'package:relis/view/homePage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const routeName = '/SignInPage';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String emailId = "", password = "";
  bool _passwordVisible = false;
  final TextEditingController _password = TextEditingController();
  var token;

  @override
  void initState() {
    super.initState();
    changePage("SignIn");
    checkStatus(context);
  }

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
        // child: BackdropFilter(
        // filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
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
        ),
        // ),
      ),
    );
  }

  Widget desktopView() {
    return Container(
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
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: signInImage(),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 2,
            color: Colors.white,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Sign-In to your ',
                      style: TextStyle(
                        color: Colors.black,
                        height: 2,
                        fontSize: 20,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'ReLis',
                          style: TextStyle(
                            color: Colors.black,
                            height: 2,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        TextSpan(
                          text: ' account',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            height: 2,
                          ),
                          // style: TextStyle(color: Colors.blueAccent,),
                          // recognizer: TapGestureRecognizer()..onTap = () {
                          //   // navigate to desired screen
                          // }
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (val) {
                      emailId = val;
                    },
                    textInputAction: TextInputAction.done,
                    autofocus: false,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      EmailValidator(errorText: "Invalid Email!"),
                    ]),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Ex.: johndoe@example.com',
                      hintStyle: TextStyle(
                        height: 0.7,
                        color: Colors.white,
                      ),
                      labelText: 'Email Id.',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        height: 1,
                      ),
                      prefixIcon:
                          Icon(Icons.email_outlined, color: Colors.white),
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
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    validator: validatePwd,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
                      suffixIcon: IconButton(
                        tooltip: _passwordVisible
                            ? "Hide Password"
                            : " Show Password",
                        color: Colors.white,
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    obscureText: !_passwordVisible,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ForgotPasswordButton(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: signInButton(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: goToSignUpPageButton(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mobileView() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            signInImage(),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 2,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10.00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Sign in to your ',
                      style: TextStyle(
                        color: Colors.black,
                        height: 0.6,
                        fontSize: 15,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'ReLis',
                          style: TextStyle(
                            color: Colors.black,
                            height: 0.6,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        TextSpan(
                          text: ' account',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            height: 0.6,
                          ),
                          // style: TextStyle(color: Colors.blueAccent,),
                          // recognizer: TapGestureRecognizer()..onTap = () {
                          //   // navigate to desired screen
                          // }
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (val) {
                      emailId = val;
                    },
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
                      hintText: 'Ex.: johndoe@example.com',
                      hintStyle: TextStyle(
                        height: 0.7,
                        color: Colors.white,
                      ),
                      labelText: 'Email Id.',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        height: 1,
                      ),
                      prefixIcon:
                          Icon(Icons.email_outlined, color: Colors.white),
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
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
                      suffixIcon: IconButton(
                        tooltip: _passwordVisible
                            ? "Hide Password"
                            : " Show Password",
                        color: Colors.white,
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    controller: _password,
                    obscureText: !_passwordVisible,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  signInButton(),
                  SizedBox(
                    height: 10,
                  ),
                  goToSignUpPageButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? validatePwd(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }


  Widget signInImage() {
    return Image.asset(
      "images/signin.png",
      fit: BoxFit.contain,
    );
  }

  Widget signInButton() {
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
      textColor: Color(0xFF1E8BC3),
      color: Colors.white,
      splashColor: Color(0xFF2C3E50).withOpacity(0.3),
      child: Text(
        "SignIn",
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await getLoggedIn(context, emailId, password, "false");
          // if(!loggedIn) {
          //   showMessageSnackBar(context, "Please fill the valid Details!!");
          // }
          // else {
          //   showMessageSnackBar(context, "Fetching Books, Please Wait!!");
          // }
        }
      },
    );
  }


  Widget ForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: MaterialButton(
        elevation: 0.0,
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
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
          "Forgot Password?",
          style: TextStyle(fontSize: 15, color: mainAppAmber),
        ),
        onPressed: () async {
          changingPassword = true;
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PasswordChange(takeEmail: true,)),
          );
        },
      ),
    );
  }

  Widget goToSignUpPageButton() {
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
        "New to ReLis?",
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
      ),
      onPressed: () async {
        Navigator.of(context).popAndPushNamed(SignUpPage.routeName);
      },
    );
  }
}
