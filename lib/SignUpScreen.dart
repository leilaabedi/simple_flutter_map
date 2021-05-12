import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:simple_flutter_map/map_page.dart';
import 'package:simple_flutter_map/static_methods.dart';
import 'LogInScreen.dart';
import 'constants.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'sign_up_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child('Users');

  Size size;
  FocusNode node;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool showLoadingProgress = false;

  String email = "", password = "";
  var _formKey = GlobalKey<FormState>();

  // FirebaseAuth auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    node = FocusScope.of(context);

    return Scaffold(
      backgroundColor: Color(0xff000752),
      //change colum to listview
      body: Form(
        key: _formKey,
        child: ModalProgressHUD(
          inAsyncCall: showLoadingProgress,
          progressIndicator: kCustomProgressIndicator,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 180,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            ),
                            Text(
                              "Welcome to Map App",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(150)),
                          color: Color(0xffff2fc3)),
                    ),
                    Theme(
                      data: ThemeData(
                        hintColor: Colors.blue,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 50, right: 20, left: 20),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter user name";
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "User Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffff2fc3), width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffff2fc3), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffff2fc3), width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffff2fc3), width: 1)),
                          ),
                        ),
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        hintColor: Colors.blue,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter Email";
                            } else {
                              email = value;
                            }

                            return null;
                          },

                          //  onSaved: (value){
                          //   email=value;
                          //},

                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffff2fc3), width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffff2fc3), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffff2fc3), width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffff2fc3), width: 1)),
                          ),
                        ),
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        hintColor: Colors.blue,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                        child: TextFormField(
                          obscureText: true,
                          autocorrect: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter password";
                            } else if (value.length < 8) {
                              return "your password shouldn't be less than 8 char";
                            } else {
                              password = value;
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffff2fc3), width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffff2fc3), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffff2fc3), width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color(0xffff2fc3), width: 1)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            onSignUpPressed();
                            //  print("ok");
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Color(0xffff2fc3),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: RaisedButton(
                        onPressed: () {},
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.google,
                              color: Color(0xffff2fc3),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sign Up with google",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff000725),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: RaisedButton(
                        onPressed: () {},
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sign Up with google",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff000725),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "You already have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LogInScreen()));
                            },
                            child: Column(children: [
                              Text(
                                "Log In",
                                style: TextStyle(color: Colors.blue),
                              ),
                              Container(
                                width: 45,
                                height: 1,
                                color: Colors.blue,
                              ),
                            ]),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  uploadInfo() async {
    showLoadingProgress = true;
    setState(() {});
    try {
      print('signing in');
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('after singing in');
      if (userCredential != null) {
        print('user is: ${userCredential.user}');
        uploadToDatabase(userCredential.user);
      } else {
        print('user is null');
      }
    } catch (e) {
      print('myError: $e');
      showLoadingProgress = false;
      setState(() {});
    }
  }

  onSignUpPressed() {
    uploadInfo();
  }

  uploadToDatabase(User user) async {
    try {
      await dbRef.child(user.uid).set({
        'uid': user.uid,
        'email': user.email,
      });
      showLoadingProgress = false;
      setState(() {});
      Navigator.popAndPushNamed(
        context,
        MapPage.id,
        arguments: {

          'email': email,
          'uid': user.uid,
        },
      );
    } catch (e) {
      showLoadingProgress = false;
      setState(() {});
      StaticMethods.showErrorDialog(context: context, text: 'sth went wrong');
      print(e);
    }
  }
}
