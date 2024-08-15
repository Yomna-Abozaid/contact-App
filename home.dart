import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:untitled29/widgets/addContact.dart';

import 'Model/contact.dart';
import 'database/Dbhelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact> _contacts = [];

  Future<void> _fetchContacts() async {
    var dbHelper = Db_Helper();
    List<Map<String, dynamic>> contacts = await dbHelper.getContacts();
    setState(() {
      _contacts = contacts.map((contact) => Contact.fromMap(contact)).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
            size: 35,
          ),
          onPressed: () {
            showModalBottomSheet(
                    context: context, builder: (context) => AddContact())
                .then((_) => _fetchContacts());
          },
        ),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          title: Text('Contacts'),
          centerTitle: true,
        ),
        body: _contacts.isEmpty
            ? Center(
                child: Text('No Contact Available'),
              )
            : FutureBuilder(
          future: Db_Helper().getContacts(),builder:
        (context,snapshot){if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              crossAxisCount: 2,
            ),
            itemCount: _contacts.length,
            itemBuilder: (context, index) {
              Contact contact = _contacts[index];
              return Container(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: 130,
                        width: 130,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: contact.imgUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        contact.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        contact.phone,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );

        }

        },
        ),

      ),
    );
  }
}
