import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:staff_management/const_value/palette.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/screens/login/header_decoration.dart';
import 'package:staff_management/services/authentication.dart';
import 'package:staff_management/services/employeeRepo.dart';
import 'package:staff_management/utils/button/button_widget.dart';
import 'package:staff_management/utils/snack_bar/snack_bar_widget.dart';
import 'package:staff_management/utils/textField/name_field_widget.dart';
import 'package:staff_management/utils/textField/password_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  navigateToHome() async {
    Get.offAllNamed('/mainContainer');
  }

  login() async {
    AuthenticationServices _auth = AuthenticationServices();
    if (_formKey.currentState!.validate()) {
      TextInput.finishAutofillContext();
      dynamic result = await _auth.signIn(
          _emailController.text.trim(), _passwordController.text.trim());
      if (_auth.errorMessage != '') {
        showSnackbar('Login Failed', _auth.errorMessage, false);
      }
      if (result == null) {
      } else {
        navigateToHome();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.myLightGrey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                child: HeaderWidget(250, true, Icons.login_rounded),
              ),
              SizedBox(height: 40),
              SafeArea(
                  child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        // padding: EdgeInsets.only(left: 10, right: 10),
                        child: AutofillGroup(
                          child: Column(
                            children: [
                              NameFieldWidget(controller: _emailController),
                              const SizedBox(
                                height: 16,
                              ),
                              PasswordFieldWidget(
                                controller: _passwordController,
                                hintText: 'Password',
                                currentPassword: '',
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ButtonWidget(
                                text: 'Login',
                                onClicked: login,
                                color: Palette.orange,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
