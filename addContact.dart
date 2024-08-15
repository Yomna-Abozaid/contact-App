import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/contact.dart';
import '../database/Dbhelper.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String? name;
  String? phone;
  String? imgUrl;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
      child: Padding(
        padding: const EdgeInsets.all(10.0).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Contact Name',
                ),
                onChanged: (val){
                  setState(() {
                    name=val;

                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'phone',
                ),
                onChanged: (val){
                  setState(() {
                    phone=val;

                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'image Url',
                ),
                onChanged: (val){
                  setState(() {
                    imgUrl=val;

                  });
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom( backgroundColor: Colors.blue),
                  onPressed: () async {
                    // Check if any field is null
                    if (name == null || phone == null || imgUrl == null) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all the fields'),
                        ),
                      );
                    } else {
                      Contact contact = Contact({
                        'name': name,
                        'phone': phone,
                        'imgUrl': imgUrl,
                      });
                      var dbHelper = Db_Helper();
                      try {
                        await dbHelper.insertContact(contact);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $e'),
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                      name = null;
                      phone = null;
                      imgUrl = null;
                    }
                  },
child: Text('Save',style: TextStyle(
  fontSize: 15,color: Colors.white
),),
                ),
              )
            ],
          ),

          ),
        ),
      ),
    );
  }
}
