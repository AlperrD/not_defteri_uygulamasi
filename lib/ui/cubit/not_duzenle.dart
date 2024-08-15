import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_uygulamasi/data/repo/not_defteri_dao_repositories.dart';
class NotDuzenleCubit extends Cubit<void>{ // Ekranda bir değer göstermesi gerekmediği için void olarak tanımlandı.
  NotDuzenleCubit():super(0);
  
  var nrepo = NotDefteriDaoRepo();

    Future<void> guncelle(int notId, String baslik, String not, String eklenmeTarih)async{
    await nrepo.guncelle(notId, baslik, not,eklenmeTarih);
  }

  
}