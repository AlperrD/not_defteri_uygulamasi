import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_uygulamasi/data/entity/not_class.dart';
import 'package:not_uygulamasi/data/repo/not_defteri_dao_repositories.dart';

class NotAnasayfaCubit extends Cubit<List<Not>>{
    var nrepo= NotDefteriDaoRepo();
  NotAnasayfaCubit():super(<Not>[]);

    Future<void> notYukle()async{
      var liste = await nrepo.notYukle();
      print("not yükleme çalıştı");
      emit(liste);
  }

    Future<void> ara(String aramaKelimesi) async {
    var liste = await nrepo.ara(aramaKelimesi);
      emit(liste);
  }

      Future<void> sil (int notId) async {
    // List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM notDefteri WHERE notId = $notId');
    // await nrepo.notKaydetCop(notId);
    await nrepo.sil(notId);
  }

  Future<void> copKutusunaKaydet(int notId) async{
    print("Cubit cop kutusu not ekleme başladı.");
    await nrepo.copKutusunaKaydet(notId);
    
  }
  
}