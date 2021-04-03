import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngabflutter/backend/auth.dart';
import 'package:ngabflutter/pages/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class HomeKu extends StatefulWidget {
  final String uid;

  HomeKu({Key key, @required this.uid}) : super(key: key);

  @override
  _HomeKuState createState() => _HomeKuState(uid);
}

class _HomeKuState extends State<HomeKu> {
  final String uid;
  final picker = ImagePicker();
  _HomeKuState(this.uid);
  File _imageFile;

  TextEditingController _name = TextEditingController();
  TextEditingController _bahan = TextEditingController();

  final AuthService _auth = AuthService();

  var recipecollections = FirebaseFirestore.instance.collection('recipe');

  List allRecipes = [];

  Future<void> getRecipes() async {
    await recipecollections.get().then((result) => {
          result.docs.forEach((element) {
            print(element.data());
            allRecipes.add(element);
          })
        });
    setState(() {});
    return;
  }

  @override
  initState() {
    getRecipes();
    setState(() {});
    super.initState();
    return;
  }

  Future<void> _deleteRecipe({String id}) async {
    await recipecollections.doc(id).delete();
    await getRecipes();
  }

  // Future<void> _chooseImage() async {
  //   PickedFile pickedfile = await picker.getImage(source: ImageSource.gallery);

  //   setState(() {
  //     _imageFile = File(pickedfile.path);
  //   });
  // }

  Future<void> _addRecipe({String name, String bahan, File image}) async {
    // String ImageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = image.path;
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('Images').child(fileName);
    final UploadTask uploadtask = storageReference.putFile(image);
    String imageUrl = await (await uploadtask).ref.getDownloadURL();

    User user = await FirebaseAuth.instance.currentUser;
    await recipecollections.add({
      'name': name,
      'bahan': bahan,
      'image': imageUrl,
      'author': user.email
    });

    await getRecipes();
  }

  Future<void> _updateRecipe(
      {String id, String name, String bahan, File image}) async {
    // // String ImageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    if (image != null) {
      String fileName = image.path;
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('Images').child(fileName);
      final UploadTask uploadtask = storageReference.putFile(image);
      String imageUrl = await (await uploadtask).ref.getDownloadURL();

      await recipecollections
          .doc(id)
          .update({'name': name, 'bahan': bahan, 'image': imageUrl});
    } else {
      await recipecollections.doc(id).update({'name': name, 'bahan': bahan});
    }
    await getRecipes();
  }

  // Future refreshData() async {
  //   listData.clear();
  //   await Future.delayed(Duration(seconds: 2));
  //   for (var index = 0; index < 10; index++) {
  //     var nama = 'User ${index + 1}';
  //     var nomor = Random().nextInt(100);
  //     listData.add(User(nama, nomor));
  //   }
  //   setState(() {});
  // }

  void showdialog(DocumentSnapshot ds) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add Recipe"),
            content: Form(
                key: formkey,
                autovalidate: true,
                child: Column(children: [
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                    ),
                    validator: (_val) {
                      if (_val.isEmpty) {
                        return "Can't Be Empty";
                      } else {
                        return null;
                      }
                    },
                    controller: _name,
                  ),
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Bahan Bahan",
                    ),
                    validator: (_val) {
                      if (_val.isEmpty) {
                        return "Can't Be Empty";
                      } else {
                        return null;
                      }
                    },
                    controller: _bahan,
                  ),
                  if (_imageFile != null) Image.file(_imageFile, height: 200),
                  IconButton(
                      icon: Icon(Icons.photo_album),
                      onPressed: () async {
                        PickedFile pickedfile =
                            await picker.getImage(source: ImageSource.gallery);

                        setState(() {
                          _imageFile = File(pickedfile.path);
                        });
                      })
                ])),
            actions: <Widget>[
              RaisedButton(
                color: Colors.purple,
                onPressed: () async {
                  if (formkey.currentState.validate()) {
                    formkey.currentState.save();
                    await _addRecipe(
                        name: _name.text,
                        bahan: _bahan.text,
                        image: _imageFile);
                    await getRecipes();
                    setState(() {});
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeKu(
                            uid: uid,
                          ),
                        ));
                  }
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontFamily: "tepeno",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }

  void updateRecipe({String id, String nama, String bahan, String imageUrl}) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    TextEditingController _nameUpdate = TextEditingController(text: nama);
    TextEditingController _bahanUpdate = TextEditingController(text: bahan);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add Recipe"),
            content: Form(
                key: formkey,
                autovalidate: true,
                child: Column(children: [
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                    ),
                    validator: (_val) {
                      if (_val.isEmpty) {
                        return "Can't Be Empty";
                      } else {
                        return null;
                      }
                    },
                    controller: _nameUpdate,
                  ),
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Bahan Bahan",
                    ),
                    validator: (_val) {
                      if (_val.isEmpty) {
                        return "Can't Be Empty";
                      } else {
                        return null;
                      }
                    },
                    controller: _bahanUpdate,
                  ),
                  if (_imageFile != null) ...[
                    Image.file(_imageFile, height: 200)
                  ],
                  IconButton(
                      icon: Icon(Icons.photo_album),
                      onPressed: () async {
                        PickedFile pickedfile =
                            await picker.getImage(source: ImageSource.gallery);

                        setState(() {
                          _imageFile = File(pickedfile.path);
                        });
                      })
                ])),
            actions: <Widget>[
              RaisedButton(
                color: Colors.purple,
                onPressed: () async {
                  if (formkey.currentState.validate()) {
                    formkey.currentState.save();
                    await _updateRecipe(
                        id: id,
                        name: _nameUpdate.text,
                        bahan: _bahanUpdate.text,
                        image: _imageFile);
                    await getRecipes();
                    setState(() {});
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeKu(
                            uid: uid,
                          ),
                        ));
                  }
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontFamily: "tepeno",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var recipesdata = recipecollections.get();
    return RefreshIndicator(
        onRefresh: () {
          return;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Home",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              elevation: 10,
              backgroundColor: Colors.black,
              actions: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.search),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.notifications),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.more_vert),
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text('Kawand'),
                    accountEmail: Text('Kawand@gmail.com'),
                    decoration: BoxDecoration(color: Colors.blueAccent),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text('Drawer layout Item 1'),
                      onTap: () {
                        //bapak
                      },
                    ),
                  ),
                  Divider(
                    height: 10.0,
                  ),
                  ListTile(
                    leading: Icon(Icons.accessibility),
                    title: Text('Drawer layout Item 2'),
                    onTap: () {
                      //Bapak
                    },
                  ),
                  Divider(
                    height: 10.0,
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () async {
                      await _auth.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    },
                  )
                ],
              ),
            ),
            body: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              itemBuilder: (_, home) {
                if (home < allRecipes.length) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    height: 250,
                    color: Colors.grey[200],
                    child: Column(children: [
                      // if (allRecipes[home].data()['image'] != "")
                      Image.network(allRecipes[home].data()['image'],
                          height: 100),
                      Text("Nama : " +
                          allRecipes[home].data()['name'].toString()),
                      Text("Bahan : " +
                          allRecipes[home].data()['bahan'].toString()),
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            print(allRecipes[home].data());
                            updateRecipe(
                                id: allRecipes[home].id,
                                nama: allRecipes[home].data()['name'],
                                bahan: allRecipes[home].data()['bahan'],
                                imageUrl: allRecipes[home].data()['image']);
                          }),

                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteRecipe(id: allRecipes[home].id);
                            setState(() {});
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeKu(
                                    uid: uid,
                                  ),
                                ));
                          })
                    ]),
                  );
                }
                return Text("");
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => showdialog(null),
            )));
  }
}
