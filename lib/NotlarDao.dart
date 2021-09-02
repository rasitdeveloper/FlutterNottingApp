import 'package:nottingapp/VeritabaniYardimcisi.dart';

import 'Notlar.dart';

class Notlardao {
  Future<List<Notlar>> tumNotlar() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM notlar");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Notlar(satir["not_id"], satir["not_baslik"], satir["not_icerik"], satir["not_tarih"]);
    });

  }

  Future<List<Notlar>> notArama(String aramaKelimesi) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM notlar WHERE not_baslik like '%$aramaKelimesi%' OR not_icerik like '%$aramaKelimesi%'");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Notlar(satir["not_id"], satir["not_baslik"], satir["not_icerik"], satir["not_tarih"]);
    });

  }

  Future<void> notEkle(String not_baslik, String not_icerik, String not_tarih) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var bilgiler = Map<String, dynamic>();
    bilgiler["not_baslik"] = not_baslik;
    bilgiler["not_icerik"] = not_icerik;
    bilgiler["not_tarih"] = not_tarih;
    await db.insert("notlar", bilgiler);
  }

  Future<void> notGuncelle(int not_id, String not_baslik, String not_icerik, String not_tarih) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var bilgiler = Map<String, dynamic>();
    bilgiler["not_baslik"] = not_baslik;
    bilgiler["not_icerik"] = not_icerik;
    bilgiler["not_tarih"] = not_tarih;
    await db.update("notlar", bilgiler, where: "not_id=?", whereArgs: [not_id]);

  }


  Future<void> notSil(int not_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("notlar", where: "not_id=?", whereArgs: [not_id]);

  }
}