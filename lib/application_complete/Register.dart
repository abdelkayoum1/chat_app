import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:frt/application_complete/constant.dart';
import 'package:frt/application_complete/snackbar1.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:image_picker/image_picker.dart';

//import 'package:firebase_storage/firebase_storage.dart';

import 'dart:math';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  // TextEditingController username = TextEditingController();
  //TextEditingController age = TextEditingController();
  //TextEditingController title = TextEditingController();
  // File? imgpath;
  ////String? pathname;
  final SupabaseClient supabase = Supabase.instance.client;

  authentification() async {
    setState(() {
      isloading = true;
    });
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      showSnackBar(context, 'succes');
      // print('${user.user!.uid}');

      //final imagefirebasefirestore = FirebaseStorage.instance.ref(pathname);
      // await imagefirebasefirestore.putFile(imgpath!);
      // String imgurl = await imagefirebasefirestore.getDownloadURL();

      CollectionReference usee = FirebaseFirestore.instance.collection(
        'messages',
      );
      usee
          .doc(user.user!.uid)
          .set({
            //'url': imgurl,
            // 'username': username.text,
            // 'age': age.text,
            // 'title': title.text,
            'email': email.text,
            'pass': password.text,
          })
          .then((value) => print('add'))
          .catchError((error) => print('erreur:${error}'));
      //print("${user.user?.uid}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'your password inf a 6  ');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'your email is exict dija ');
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isloading = false;
    });
  }

  /*
  authentification() async {
    setState(() {
      isloading = true;
    });

    try {
      // إنشاء مستخدم في Supabase Auth
      final response = await supabase.auth.signUp(
        email: email.text,
        password: password.text,
      );

      final user = response.user;

      // رفع الصورة إلى Supabase Storage
      await Supabase.instance.client.storage
          .from('image')
          .upload(pathname!, imgpath!);

      // جلب الرابط العام للصورة
      final publicUrl = await Supabase.instance.client.storage
          .from('image')
          .getPublicUrl(pathname!);

      // تخزين المعلومات في قاعدة Supabase
      await supabase.from('users').insert({
        'id': user?.id,
        'username': username.text,
        'age': age.text,
        'title': title.text,
        'email': email.text,
        'image_url': publicUrl,
      });

      ShowSnackbar(context, 'Account created successfully!');
    } catch (e) {
      print('Error: $e');
      ShowSnackbar(context, 'Registration failed');
    }

    setState(() {
      isloading = false;
    });
  }
*/

  bool isvisible = true;
  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    super.dispose();
  }

  bool isloading = false;
  final _formkey = GlobalKey<FormState>();
  bool ispassword8char = false;
  bool ispassword1number = false;
  bool ispasswordupper = false;
  bool ispasswordlowwer = false;
  bool ispassword1numberspecial = false;

  changepassword(String password) {
    ispassword8char = false;

    ispassword1number = false;
    ispasswordupper = false;
    ispasswordlowwer = false;
    ispassword1numberspecial = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        ispassword8char = true;
      }

      if (password.contains(RegExp(r'[0-9]'))) {
        ispassword1number = true;
      }
      if (password.contains(RegExp(r'[A-Z]'))) {
        ispasswordupper = true;
      }
      if (password.contains(RegExp(r'[a-z]'))) {
        ispasswordlowwer = true;
      }
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        ispassword1numberspecial = true;
      }
    });
  }

  add_photo(ImageSource image) async {
    final imgpathh = await ImagePicker().pickImage(source: image);
    try {
      if (imgpathh != null) {
        setState(() {
          // imgpath = File(imgpathh.path);
          // pathname = basename(imgpathh.path);
          int cpt = Random().nextInt(9999);
          // pathname = '$cpt$pathname';
        });
      } else {
        showSnackBar(context, 'ne image selected');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Register'), elevation: 3),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(33.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        /*
                        child: Stack(
                          children: [
                            pathname == null
                                ? CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 80,
                                    backgroundImage: AssetImage(
                                      'assets/images/avatar.png',
                                    ),
                                  )
                                : ClipOval(
                                    child: Image.file(
                                      imgpath!,
                                      width: 145,
                                      height: 145,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                            Positioned(
                              left: 115,
                              bottom: -4,
                              child: IconButton(
                                onPressed: () {
                                  //add_photo();
                                  showModalBottomSheet(
                                    context: context,

                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: EdgeInsets.all(22),
                                        height: 170,
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                add_photo(ImageSource.camera);
                                              },
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.camera),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Text('From camera'),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await add_photo(
                                                  ImageSource.gallery,
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.photo_outlined,
                                                    ),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Text('From Galery'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.add_a_photo),
                              ),
                            ),
                          ],
                        ),
                        */
                      ),
                    ),
                    SizedBox(height: 15),
                    /*
                    TextField(
                      controller: username,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: aaaa.copyWith(
                        hintText: 'entrer_username',
                        suffixIcon: Icon(Icons.person),
                      ),
                    ),
                    */
                    SizedBox(height: 20),
                    /*
                    TextField(
                      controller: age,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: aaaa.copyWith(
                        hintText: 'entrer_your_age',
                        suffixIcon: Icon(Icons.pest_control_rodent),
                      ),
                    ),
                    */
                    SizedBox(height: 20),
                    /*
                    TextField(
                      controller: title,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: aaaa.copyWith(
                        hintText: 'entrer_your title',
                        suffixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    */
                    SizedBox(height: 20),

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
                    TextFormField(
                      onChanged: (password) {
                        changepassword(password);
                      },
                      validator: (value) {
                        return value!.length < 8 ? "entrer 8 charectere" : null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: password,
                      keyboardType: TextInputType.text,
                      obscureText: isvisible ? true : false,
                      decoration: aaaa.copyWith(
                        hintText: "entrer_your_password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (isvisible == true) {
                                isvisible = false;
                              } else {
                                isvisible = true;
                              }
                            });
                          },
                          icon: Icon(
                            isvisible ? Icons.visibility_off : Icons.visibility,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: ispassword8char
                                ? Colors.green
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('At lest 8 characters'),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: ispassword1number
                                ? Colors.green
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('At lest 1 Numbers'),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: ispasswordupper
                                ? Colors.green
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Hass Uppercasse'),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: ispasswordlowwer
                                ? Colors.green
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Has Lowercase'),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: ispassword1numberspecial
                                ? Colors.green
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Has Spécial caracters'),
                      ],
                    ),

                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          await authentification();
                          if (!mounted) return;
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Applicationcomplete_login()));
                        } else {
                          showSnackBar(context, 'ERROR');
                        }
                      },
                      child: isloading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Sign in',
                              style: TextStyle(color: Colors.white),
                            ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.green,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Do not have a account?",
                          style: TextStyle(fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/applicationcomptele_login',
                            );
                          },
                          child: Text(
                            'Login  ',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
