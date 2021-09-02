import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nottingapp/NotlarDao.dart';

import 'main.dart';

class noteklesayfa extends StatefulWidget {
  @override
  _noteklesayfaState createState() => _noteklesayfaState();
}

class _noteklesayfaState extends State<noteklesayfa> {

  var tfBaslik = TextEditingController();
  var tfIcerik = TextEditingController();

  Future<void> kayit(String not_baslik, String not_icerik) async {
    DateTime now = new DateTime.now();
    String tarih = now.day.toString() + "/" + now.month.toString() + "/" + now.year.toString() +
        "  " + now.hour.toString() + ":" + now.minute.toString();
    await Notlardao().notEkle(not_baslik, not_icerik, tarih);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: tfBaslik,
                    decoration: InputDecoration(hintText: "You can optionally add a title.", hintStyle: TextStyle(fontSize: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: tfIcerik,
                  decoration: InputDecoration(hintText: "You can enter your note", hintStyle: TextStyle(fontSize: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          kayit(tfBaslik.text, tfIcerik.text);
        },
        tooltip: 'Note Save',
        icon: Icon(Icons.save),
        label: Text("Save"),
      ),
    );
  }
}