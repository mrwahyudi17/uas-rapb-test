import 'dart:ui';
import 'package:flutter/material.dart';
import 'guestbook.dart';
import 'detail.dart';
import 'sql_helper.dart';
import 'detail.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'UAS RAPB',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(),

        initialRoute: '/',
        routes: {
          '/': (BuildContext context) {
            return const Home();
          },
          '/guestbook': (BuildContext context) {
            return const GuestBook();
          },
        }
    );
  }
}

Widget builDrawer(BuildContext context){
  return Drawer(
    child: ListView(
      children: [
        ListTile(
          title: Text('Home'),
          leading: Icon(Icons.home),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        Divider(),
        ListTile(
          title: Text('Guest Book'),
          leading: Icon(Icons.group_sharp),
          onTap: () {
            Navigator.pushNamed(context, '/guestbook');
          },
        ),
      ],
    ),
  );
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
      ),
      drawer: builDrawer(context),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: const Text(
              'My Profil',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: const[
              Text('Nama: Muhammad Rizki Wahyudi'),
              Text('NIM: 191420016'),
              Text('Kelas: IF5P'),
              Text('Email: mrizki.wahyudi17@gmail.com'),
              Text('Telp: 0812 2345 6789')
            ],
          ),
        ],
      )
    );
  }
}
