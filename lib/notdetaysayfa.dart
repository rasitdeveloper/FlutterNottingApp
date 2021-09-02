import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nottingapp/NotlarDao.dart';

import 'Notlar.dart';
import 'main.dart';

class notdetaysayfa extends StatefulWidget {
  Notlar not;
  notdetaysayfa({required this.not});

  @override
  _notdetaysayfaState createState() => _notdetaysayfaState();
}

class _notdetaysayfaState extends State<notdetaysayfa> {

  var tfBaslik = TextEditingController();
  var tfIcerik = TextEditingController();

  Future<void> guncelle(int not_id, String not_baslik, String not_icerik) async {
    DateTime now = new DateTime.now();
    String tarih = now.day.toString() + "/" + now.month.toString() + "/" + now.year.toString() +
        "  " + now.hour.toString() + ":" + now.minute.toString();
    await Notlardao().notGuncelle(not_id, not_baslik, not_icerik, tarih);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var not = widget.not;
    tfBaslik.text = not.not_baslik;
    tfIcerik.text = not.not_icerik;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Detail"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
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
          guncelle(widget.not.not_id, tfBaslik.text, tfIcerik.text);
        },
        tooltip: 'Note Update',
        icon: Icon(Icons.update),
        label: Text("Update"),
      ),
    );
  }
}