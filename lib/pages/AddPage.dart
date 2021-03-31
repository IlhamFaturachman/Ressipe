import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRecipe extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController bahan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference recipes = firestore.collection('recipe');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        actions: [
          FlatButton(
            onPressed: () {
              recipes.add({
                'name': name.text,
                'bahan': bahan.text,
              }).whenComplete(() => Navigator.pop(context));
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: 'Name',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: bahan,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Content',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
