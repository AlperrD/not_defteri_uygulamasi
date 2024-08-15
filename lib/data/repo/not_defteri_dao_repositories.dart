import 'package:not_uygulamasi/data/entity/not_class.dart';
import 'package:not_uygulamasi/sqlite/veritabani_yardimcisi.dart';
import 'package:not_uygulamasi/sqlite/veritabani_yardimcisi_cop_kutusu.dart';

class NotDefteriDaoRepo {

  Future<void> notKaydet(String baslik, String not, String eklenmeTarih) async{
    // db bağlan.
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var yeniNot = <String, dynamic>{};
    yeniNot["notBaslik"] = baslik;
    yeniNot["notİcerik"] = not;
    yeniNot["eklenmeTarih"] = eklenmeTarih;
    db.insert("notDefteri", yeniNot);
  }

  
    Future<List<Not>> notYukle()async{

      var db = await VeritabaniYardimcisi.veritabaniErisim();
      List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM notDefteri');

      return List.generate(maps.length, (i){
        var satir = maps[i];
        return Not(notId: satir["notId"],baslik: satir["notBaslik"], not: satir["notİcerik"], eklenmeTarihi: satir["eklenmeTarih"]);
      });
  }

      Future<List<Not>> ara(String aramaKelimesi) async {
      var db = await VeritabaniYardimcisi.veritabaniErisim();
      List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM notDefteri WHERE notBaslik like '%$aramaKelimesi%'");

      return List.generate(maps.length, (i){
        var satir = maps[i];
        return Not(notId: satir["notId"],baslik: satir["notBaslik"], not: satir["notİcerik"], eklenmeTarihi: satir["eklenmeTarih"]);
      });
  }

      Future<void> sil (int notId) async {

      var db = await VeritabaniYardimcisi.veritabaniErisim();
      await db.delete("notDefteri",where: "notId = ?",whereArgs: [notId] );
      print("Not silme çalıştı.");

  }

      Future<void> guncelle(int notId, String baslik, String not, String eklenmeTarih)async{
      var db = await VeritabaniYardimcisi.veritabaniErisim();
      var guncellenenNot = Map<String, dynamic>();
      guncellenenNot["notId"] = notId;
      guncellenenNot["notBaslik"] = baslik;
      guncellenenNot["notİcerik"] = not;
      guncellenenNot["eklenmeTarih"] = eklenmeTarih;
      
      await db.update("notDefteri", guncellenenNot,where: "notId = ?",whereArgs: [notId] ); // kisi id soru işareti yerine geçiyor kişi id varsa güncelleme yapılıyor.
    
      }

      // notlar için çöp kutusu işlemleri

      Future<void> copKutusuSil (int notId) async {

      var db = await VeritabaniYardimcisiCopKutusu.veritabaniErisim();
      await db.delete("notDefteri",where: "notId = ?",whereArgs: [notId] );
      print("Not silme cop kutusu çalıştı.");

  }

    Future<void> copKutusunaKaydet(int notId)async{
      var db1 = await VeritabaniYardimcisi.veritabaniErisim();
      var db = await VeritabaniYardimcisiCopKutusu.veritabaniErisim();
      var veri = await db1.rawQuery("SELECT * FROM notDefteri WHERE notId = $notId");
      
       var yeniNot = <String, dynamic>{};
      List.generate(veri.length, (i)async{

   
    var satir = veri[i];
    yeniNot["notBaslik"] = satir["notBaslik"];
    yeniNot["notİcerik"] = satir["notİcerik"];
    yeniNot["eklenmeTarih"] = satir["eklenmeTarih"];
    
     print("Cop kutusuna silinen not eklendi.");
      });
      await db.insert("notDefteri", yeniNot, nullColumnHack: "notId");
        
    
      
    }

Future<List<Not>> copKutusuNotYukle() async {
  var db = await VeritabaniYardimcisiCopKutusu.veritabaniErisim();
  List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM notDefteri');
  
  return List.generate(maps.length, (i) {
    var satir = maps[i];
    return Not(
      notId: satir["notId"] ?? 0, // null kontrolü, varsayılan değer
      baslik: satir["notBaslik"] ?? '', // null kontrolü, varsayılan değer
      not: satir["notİcerik"] ?? '', // null kontrolü, varsayılan değer
      eklenmeTarihi: satir["eklenmeTarih"] ?? '', // null kontrolü, varsayılan değer
    );
  });
}




  
      Future<List<Not>>copKutusuNotara(String aramaKelimesi) async {
      var db = await VeritabaniYardimcisiCopKutusu.veritabaniErisim();
      List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM notDefteri WHERE notBaslik like '%$aramaKelimesi%'");

      return List.generate(maps.length, (i){
        var satir = maps[i];
        return Not(notId: satir["notId"],baslik: satir["notBaslik"], not: satir["notİcerik"], eklenmeTarihi: satir["eklenmeTarih"]);
      });
  }

  
  
}