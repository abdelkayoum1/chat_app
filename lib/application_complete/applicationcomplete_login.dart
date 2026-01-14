import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:frt/application_complete/chat_app.dart';
import 'package:frt/application_complete/constant.dart';
import 'package:frt/application_complete/snackbar1.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Applicationcomplete_login extends StatefulWidget {
  Applicationcomplete_login({super.key});

  @override
  State<Applicationcomplete_login> createState() =>
      _Applicationcomplete_loginState();
}

class _Applicationcomplete_loginState extends State<Applicationcomplete_login> {
  TextEditingController email = TextEditingController();

  final password = TextEditingController();
  final formkey = GlobalKey<FormState>();

  loginne() async {
    try {
      UserCredential usere = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );

      await Future.delayed(Duration(seconds: 2));
      print(usere.user!.displayName);
      // final user = FirebaseAuth.instance.currentUser;
      //if(user!.emailVerified){

      // }else{
      //    Navigator.pushReplacementNamed(context,'/verify_email');

      //  }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROr:${e.code}");
    }
  }

  bool isvisible = false;

  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    super.dispose();
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Login'), elevation: 3),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: ModalProgressHUD(
                inAsyncCall: isloading,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      TextFormField(
                        validator: (value) {
                          return value!.contains(
                                RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                ),
                              )
                              ? null
                              : "Entrer email valid";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration: aaaa.copyWith(
                          hintText: 'entrer_your_email',
                          suffixIcon: Icon(Icons.email),
                        ),
                      ),

                      SizedBox(height: 20),
                      TextField(
                        controller: password,
                        keyboardType: TextInputType.text,
                        obscureText: isvisible ? false : true,
                        decoration: aaaa.copyWith(
                          hintText: "entrer_your_password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isvisible = !isvisible;
                              });
                            },
                            icon: isvisible
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            color: isvisible ? Colors.blue : Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              isloading = true;
                            });
                            await loginne();
                            if (!mounted) {
                              return;
                            }
                            Navigator.pushReplacementNamed(
                              context,
                              ChatApp.id,
                              arguments: email.text,
                            );
                            print(email.text);
                          } else {
                            showSnackBar(context, 'Error');
                          }
                          //  ShowSnackbar(context, "succes");
                          isloading = false;
                          setState(() {});
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.green,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "n'est pas compte?",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text(
                              'Sign in ',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.blue[900],
                            ),
                          ),
                          Text("OR"),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.blue[900],
                            ),
                          ),
                        ],
                      ),
                      /*
                      GestureDetector(
                        onTap: () async {
                          // await google.googlelogin();

                          // Navigator.push(context, MaterialPageRoute(builder: ((context) => Home())));
                        },
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            shape: BoxShape.circle,
                          ),
                          margin: EdgeInsets.only(right: 20),
                          child: SvgPicture.asset("assets/images/google.svg"),
                        ),
                      ),
                      */
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
