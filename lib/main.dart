import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nottingapp/Notlar.dart';
import 'package:nottingapp/NotlarDao.dart';
import 'package:nottingapp/notdetaysayfa.dart';
import 'package:nottingapp/noteklesayfa.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DemoV1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  Future<List<Notlar>> tumNotlariGoster() async {
    var notlarListesi = await Notlardao().tumNotlar();

    return notlarListesi;
  }


  Future<List<Notlar>> aramaYap(String aramaKelimesi) async {
    var notlarListesi = await Notlardao().notArama(aramaKelimesi);
    return notlarListesi;
  }

  Future<void> sil(int not_id) async {
    await Notlardao().notSil(not_id);
    setState(() {

    });
  }

  Future<bool> uygulamayiKapat() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            uygulamayiKapat();
          },
        ),
        title: aramaYapiliyorMu ?
            TextField(
              decoration: InputDecoration(hintText: "Search.."),
              onChanged: (aramaSonucu) {
                print("Search Results = $aramaSonucu");
                setState(() {
                  aramaKelimesi = aramaSonucu;
                });
              },
            )
            : Text("Notes"),
        actions: [
          aramaYapiliyorMu ?
              IconButton(
                icon: Icon(Icons.cancel, color: Colors.white,),
                onPressed: () {
                  setState(() {
                    aramaYapiliyorMu = false;
                    aramaKelimesi = "";
                  });
                },
              )
              : IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = true;
              });
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: uygulamayiKapat,
        child: FutureBuilder<List<Notlar>>(
          future: aramaYapiliyorMu ? aramaYap(aramaKelimesi) : tumNotlariGoster(),
          builder: (context, snapshot){
            if(snapshot.hasData) {
              var notlarListesi = snapshot.data;
              return ListView.builder(
                itemCount: notlarListesi!.length,
                itemBuilder: (context, index) {
                  var not = notlarListesi[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => notdetaysayfa(not: not,)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(not.not_baslik, style: TextStyle(fontWeight: FontWeight.bold),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(child: Container(
                                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                                  child: Text(not.not_icerik, softWrap: true,),
                                )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(not.not_tarih, style: TextStyle(fontSize: 10),),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.redAccent,),
                                  onPressed: () {
                                    sil(not.not_id);
                                  },
                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => noteklesayfa()));
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }
}