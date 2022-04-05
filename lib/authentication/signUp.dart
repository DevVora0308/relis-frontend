import 'package:flutter/material.dart';
import 'package:relis/authentication/otp.dart';
import 'package:relis/authentication/signIn.dart';
import 'package:relis/globals.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const routeName = '/SignUpPage';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailId = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _mobileNo = TextEditingController();
  final GlobalKey scaffoldKey = new GlobalKey<ScaffoldState>();
  String firstName = "",
      lastName = "",
      emailId = "",
      password = "",
      confirmPassword = "";
  bool _passwordVisible = false, _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    changePage("SignUp");
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
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(10.00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Create your ',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        // width: 250, //double.infinity,
                        // height: 50,
                        // margin: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          onChanged: (text) {
                            firstName = text;
                          },
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: validateName,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: '',
                            hintStyle: TextStyle(
                              height: 0.7,
                              color: Colors.white,
                            ),
                            labelText: 'First Name',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              height: 1,
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
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        // width: 250, //double.infinity,
                        // height: 50,
                        // margin: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          onChanged: (text) {
                            lastName = text;
                          },
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: validateName,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: '',
                            hintStyle: TextStyle(
                              height: 0.7,
                              color: Colors.white,
                            ),
                            labelText: 'Last Name',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              height: 1,
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      emailId = text;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: validatePwd,
                          controller: _password,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon:
                                Icon(Icons.lock_outline, color: Colors.white),
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
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: validateConfirmPwd,
                          controller: _confirmPassword,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon:
                                Icon(Icons.lock_outline, color: Colors.white),
                            suffixIcon: IconButton(
                              tooltip: _confirmPasswordVisible
                                  ? "Hide Password"
                                  : " Show Password",
                              color: Colors.white,
                              icon: Icon(
                                _confirmPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              onPressed: () {
                                setState(() {
                                  _confirmPasswordVisible =
                                      !_confirmPasswordVisible;
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
                          obscureText: !_confirmPasswordVisible,
                          keyboardType: TextInputType.text,
                          // validator: (String value) {
                          //   Pattern pattern =
                          //       r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                          //   RegExp regex = new RegExp(pattern);
                          //   if (!regex.hasMatch(value)) {
                          //     return "Invalid Passsword";
                          //   } else
                          //     return null;
                          // },
                          onChanged: (value) {
                            confirmPassword = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 2,
                        child: goToSignInPageButton(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: signUpButton(),
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'By creating an account, you agree to our ',
                      style: TextStyle(
                        color: Colors.black,
                        height: 2,
                        fontSize: 15,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            color: Colors.black,
                            height: 2,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                          // style: TextStyle(color: Colors.blueAccent,),
                          // recognizer: TapGestureRecognizer()..onTap = () {
                          //   // navigate to desired screen
                          // }
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            height: 2,
                          ),
                        ),
                        TextSpan(
                          text: 'Policies',
                          style: TextStyle(
                            color: Colors.black,
                            height: 2,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: '.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            height: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 2,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 1,
            child: signUpImage(),
          ),
        ],
      ),
    );
  }

  Widget mobileView() {
    return Container(
      margin: EdgeInsets.all(10),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          signUpImage(),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 2,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.all(10.00),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Create your ',
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
                  onChanged: (text) {
                    firstName = text;
                  },
                  textInputAction: TextInputAction.done,
                  autofocus: false,
                  maxLines: 1,
                  keyboardType: TextInputType.name,
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
                    labelText: 'First Name',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      height: 1,
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
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (text) {
                    lastName = text;
                  },
                  textInputAction: TextInputAction.done,
                  autofocus: false,
                  maxLines: 1,
                  keyboardType: TextInputType.name,
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
                    labelText: 'Last Name',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      height: 1,
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
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (text) {
                    emailId = text;
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
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.white),
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
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
                    suffixIcon: IconButton(
                      tooltip:
                          _passwordVisible ? "Hide Password" : " Show Password",
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
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
                    suffixIcon: IconButton(
                      tooltip: _confirmPasswordVisible
                          ? "Hide Password"
                          : " Show Password",
                      color: Colors.white,
                      icon: Icon(
                        _confirmPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      onPressed: () {
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
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
                  obscureText: !_confirmPasswordVisible,
                  keyboardType: TextInputType.text,
                  // validator: (String value) {
                  //   Pattern pattern =
                  //       r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                  //   RegExp regex = new RegExp(pattern);
                  //   if (!regex.hasMatch(value)) {
                  //     return "Invalid Passsword";
                  //   } else
                  //     return null;
                  // },
                ),
                SizedBox(
                  height: 20,
                ),
                goToSignInPageButton(),
                SizedBox(
                  height: 20,
                ),
                signUpButton(),
                RichText(
                  text: TextSpan(
                    text: 'By creating an account, you agree to our ',
                    style: TextStyle(
                      color: Colors.black,
                      height: 2,
                      fontSize: 15,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          color: Colors.black,
                          height: 2,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                        // style: TextStyle(color: Colors.blueAccent,),
                        // recognizer: TapGestureRecognizer()..onTap = () {
                        //   // navigate to desired screen
                        // }
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          height: 2,
                        ),
                      ),
                      TextSpan(
                        text: 'Policies',
                        style: TextStyle(
                          color: Colors.black,
                          height: 2,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "* Required";
    } else if (RegExp(r'[!@#<>?":_`~;[\]/\\|=+){}(*&^%0-9-]').hasMatch(value)) {
      return "Name must have Alphabetic characters.";
    }
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

  String? validateConfirmPwd(String? value) {
    // ignore: unrelated_type_equality_checks
    if (value == null) {
      return "Required";
    } else if (value != _password.text) {
      return "Passwords don't match!";
    } else {
      return null;
    }
  }

  void showMessageSnackBar(String message) {
    final snackBar = new SnackBar(content: new Text('$message'));
    // ignore: deprecated_member_use
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget goToSignInPageButton() {
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
        "Already have an account?",
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
        overflow: TextOverflow.ellipsis,
      ),
      onPressed: () async {
        Navigator.of(context).popAndPushNamed(SignInPage.routeName);
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

  Widget signUpButton() {
    return MaterialButton(
      elevation: 0.0,
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 60,
          horizontal: MediaQuery.of(context).size.width / 30 + 10),
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
        "SignUp",
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          Registeration['firstName'] = firstName;
          Registeration['lastName'] = lastName;
          Registeration['emailId'] = emailId;
          Registeration['password'] = password;
          Navigator.of(context).pushNamed(OTPPage.routeName);
        } else {
          showMessageSnackBar("Please fill the valid Details!!");
        }
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

  Widget signUpImage() {
    return Image.asset(
      "images/signup.jpg",
      fit: BoxFit.contain,
    );
  }
}
