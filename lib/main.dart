import 'package:firebase_auth/firebase_auth.dart';

import 'package:frt/application_complete/Register.dart';
import 'package:frt/application_complete/applicationcomplete_login.dart';
import 'package:frt/application_complete/chat_app.dart';
import 'package:frt/application_complete/constant_chat.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:frt/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/*
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  print("✅ Firebase Ready");
  runApp(myapp());
}
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://eahjbeisixzjmbkhuine.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVhaGpiZWlzaXh6am1ia2h1aW5lIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAyMTQ4NTYsImV4cCI6MjA3NTc5MDg1Nn0.Vnss2bv_IAWTK941Au3gfqD010yCK1H4t0cQ6D4bXE8',
  );
  runApp(myapp());
}

class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  Widget build(BuildContext context) {
    return
    /*
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return Cart();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return GoogleSignInProvider();
          },
        ),
      ],
    */
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        hintColor: Colors.amber,
        useMaterial3: true,
        fontFamily: 'myfont',
        textTheme: Theme.of(context).textTheme.copyWith(
          headlineLarge: TextStyle(
            color: Colors.white,
            fontFamily: 'myfont',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      /*
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        */
      //supportedLocales: [Locale("ar", "AE")],
      locale: Locale("ar", "AE"),

      home: Applicationcomplete_login(),
      /*
         StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            if (snapshot.hasData) {
              return Home();
            } else {
              return Applicationcomplete_login();
            }
          },
        ),
        */
      routes: {
        ChatApp.id: (ctx) => ChatApp(),

        //'/detail_screen':(ctx)=>Detail_Screen(),
        '/applicationcomptele_login': (ctx) => Applicationcomplete_login(),
        '/register': (ctx) => Register(),
      },
    );
  }
}

class Ap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(38.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'khelifa',
                  style: TextStyle(color: Colors.black, fontSize: 58),
                ),
                Text('abdou', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          Icon(Icons.star),
          Text('41'),
        ],
      ),
    );
  }
}

class Appp extends StatelessWidget {
  @override
  Widget share = Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(Icons.share, color: Colors.blue, size: 48),
      Text('share', style: TextStyle(color: Colors.black)),
    ],
  );
  var call = Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(Icons.call, color: Colors.blue, size: 48),
      Text('call', style: TextStyle(color: Colors.black)),
    ],
  );
  var message = Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(Icons.inbox, color: Colors.blue, size: 48),
      Text(('message'), style: TextStyle(color: Colors.black)),
    ],
  );

  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [share, call, message],
      ),
    );
    ;
  }
}

class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 150,
        color: Colors.green,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.yellow,
              width: 150,
              height: 150,
              child: Center(
                child: Text(
                  'hello',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
            ),
            Container(
              color: Colors.red,
              width: 150,
              height: 150,
              child: Center(
                child: Text(
                  'hello',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
            ),
            Container(
              color: Colors.yellow,
              width: 150,
              height: 150,
              child: Center(
                child: Text(
                  'hello',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
