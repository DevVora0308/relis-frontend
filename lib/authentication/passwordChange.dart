import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:relis/authentication/services.dart';
import 'package:relis/authentication/otp.dart';
import 'package:relis/authentication/signIn.dart';
import 'package:relis/globals.dart';

class PasswordChange extends StatefulWidget {
  static const routeName = '/PasswordChangePage';
  PasswordChange({this.takeEmail = false});

  bool takeEmail;

  @override
  _PasswordChangeState createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  final _formKey = GlobalKey<FormState>();
  String emailId = "", password = "", confirmPassword = "";
  bool _passwordVisible = false, _confirmPasswordVisible = false;
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  
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
                  changingEmailID != "" ? Text("Password Changing for ReLis account: ${changingEmailID}") : SizedBox(),
                  widget.takeEmail ? EmailField() : PasswordFields(),
                  SizedBox(
                    height: 20,
                  ),
                  ActionButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget EmailField() {
    return TextFormField(
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
    );
  }

  Widget PasswordFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        TextFormField(
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
        SizedBox(
          height: 20,
        ),
        TextFormField(
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
      ],
    );
  }

  Widget ActionButton() {
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
        widget.takeEmail? "Next" : "Change Password",
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
      ),
      onPressed: () async {
        if(widget.takeEmail) {
          widget.takeEmail = false;
          changingPassword = true;
          changingEmailID = emailId;
          Navigator.of(context).pushNamed(OTPPage.routeName);
        }
        else {
          widget.takeEmail = false;
          changingPassword = false;
          Services().changePassword(changingEmailID, password).then((val) {
            print('Comes after authService');
            print('$val');
            if (val != null && val.data['success']) {
              // token = val.data['token'];
              showMessageSnackBar(context, 'Password Changed Successfully', Color(0xFF00FF88));
              changingEmailID = "";
              Navigator.of(context).popUntil(ModalRoute.withName(SignInPage.routeName));
            } else {
              showMessageSnackBar(context, 'Error', Color(0xFFFF0000));
            }
          });
        }
      },
    );
  }
  
  Widget signInImage() {
    return Image.asset(
      "images/signin.png",
      fit: BoxFit.contain,
    );
  }

  Widget mobileView() {
    return Container();
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




}