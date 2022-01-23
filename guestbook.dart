import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:uas_rapb_mrw/detail.dart';
import 'sql_helper.dart';
import 'detail.dart';

class GuestBook extends StatefulWidget {
  const GuestBook({Key? key}) : super(key: key);

  @override
  _GuestBookState createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    //Loading the All Journal
    _refreshJournals();
  }

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _notelpController = TextEditingController();
  final TextEditingController _pesanController = TextEditingController();

//This Function will called when user want to add a new item or update A item.
  void _showForm(int? id) async {
    // if Id is null,  it will create a new entry, else it will update an item!
    if (id != null) {
      //updating Id!
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _namaController.text = existingJournal['nama'];
      _emailController.text = existingJournal['email'];
      _notelpController.text = existingJournal['notelp'];
      _pesanController.text = existingJournal['pesan'];
    }

    showDialog(
        context: context,
        // elevation: 5,
        builder: (_) => Material(
              child: Container(
                padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: const Text(
                  'Form Buku Tamu',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),

              const SizedBox(
                height: 25.0,
              ),

              TextFormField(
                controller: _namaController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  hintText: 'Input Nama Anda',
                  icon: const Icon(Icons.account_box),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
              ),

              const SizedBox(
                height: 25.0,
              ),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Masukkan Email Anda',
                  icon: const Icon(Icons.alternate_email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
              ),

              const SizedBox(
                height: 25.0,
              ),

              TextFormField(
                controller: _notelpController,
                keyboardType: TextInputType.phone,
                autofocus: true,
                maxLength: 12,
                decoration: InputDecoration(
                  labelText: 'No Telp',
                  hintText: 'Masukkan No Telp Anda',
                  icon: const Icon(Icons.contact_phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
              ),
              
              const SizedBox(
                height: 25.0,
              ),

              TextFormField(
                controller: _pesanController,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Pesan',
                  hintText: 'Tuliskan Pesan Anda',
                  icon: const Icon(Icons.message_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
              ),

              const SizedBox(
                height: 25.0,
              ),

                    ElevatedButton(
                      onPressed: () async {
                        // Save new journal
                        if (id == null) {
                          await _addItem();
                        }

                        if (id != null) {
                          await _updateItem(id);
                        }

                        // Clear the text fields
                        _namaController.text = '';
                        _emailController.text = '';
                        _notelpController.text = '';
                        _pesanController.text = '';

                        // Close the bottom sheet
                        Navigator.of(context).pop();
                      },
                      child: Text(id == null ? 'Create New' : 'Update'),
                    )
                  ],
                ),
              ),
            ));
  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _namaController.text,
        _emailController.text,
        _notelpController.text,
        _pesanController.text);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id,
        _namaController.text,
        _emailController.text,
        _notelpController.text,
        _pesanController.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUEST BOOK'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) => Card(
                color: Colors.blue[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text(_journals[index]['nama']),
                    subtitle: Text(_journals[index]['email']),
                    
                    trailing: SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showForm(_journals[index]['id']),
                            // Calling the funtion with Id, to update the respected Item!
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _deleteItem(_journals[index]['id']),
                            // Calling the funtion with Id, to delete the respected Item!
                          ),
                          IconButton(
                            icon: const Icon(Icons.visibility_outlined),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    id1: _journals[index]['id1'],
                                    nama1: _journals[index]['nama1'],
                                    email1: _journals[index]['email1'],
                                    notelp1: _journals[index]['notelp1'],
                                    pesan1: _journals[index]['pesan1'])
                                )
                              );
                            }// Calling the funtion with Id, to delete the respected Item!
                          ),
                        ],
                      ),
                    )),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
