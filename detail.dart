import 'package:flutter/material.dart';
import 'main.dart';
import 'guestbook.dart';
import 'sql_helper.dart';

class DetailPage extends StatefulWidget {
  final int id1;
  final String nama1;
  final String email1;
  final String notelp1;
  final String pesan1;

  const DetailPage(
    { Key? key,
    required this.id1,
    required this.nama1,
    required this.email1,
    required this.notelp1,
    required this.pesan1}) 
    : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Detail Data'),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text('Tampilan Detail Data'),
            ),
            ListView(
              padding: EdgeInsets.all(10.0),
              shrinkWrap: true,
              children: [
                Text('ID: ${widget.id1}'),
                Text('Nama: ${widget.nama1}'),
                Text('Email: ${widget.email1}'),
                Text('No. Telp: ${widget.notelp1}'),
                Text('Pesan: ${widget.pesan1}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
