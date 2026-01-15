import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frt/application_complete/chat_app.dart';
import 'package:frt/application_complete/constant.dart';
import 'package:frt/application_complete/snackbar1.dart';
import 'package:frt/cubit/chat_cubit.dart';
import 'package:frt/cubit/chat_state.dart';
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

  UserCredential? usere;

  /*
  Future<bool> loginne() async {
    try {
      usere = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      print(usere!.user);
      return true;
    } on FirebaseAuthException catch (e) {
      // showSnackuBar(context, "ERROr:${e.code}");
      if (e.code == 'invalid-credential') {
        showSnackBar(context, 'email ou password invalid');
        return false;
      } else if (e.code == 'invalid-email') {
        showSnackBar(context, 'email_incorrect');
        return false;
      }
      return false;
    } catch (ex) {
      showSnackBar(context, 'error');
      return false;
    }
  }
  */
  bool isvisible = false;

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is loading) {
            setState(() {
              isloading = true;
            });
          } else if (state is succes) {
            Navigator.pushReplacementNamed(
              context,
              ChatApp.id,
              arguments: email.text,
            );
          } else if (state is exception) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(title: Text('Login'), elevation: 3),
            body: ModalProgressHUD(
              inAsyncCall: isloading,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formkey,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,

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
                                  setState(() {});
                                  isvisible = !isvisible;
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
                                await BlocProvider.of<ChatCubit>(
                                  context,
                                ).loginne(
                                  email: email.text,
                                  password: password.text,
                                );
                                setState(() {
                                  isloading = false;
                                });
                              } else {
                                Applicationcomplete_login();
                              }
                              print(email.text);
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
          );
        },
      ),
    );
  }
}
