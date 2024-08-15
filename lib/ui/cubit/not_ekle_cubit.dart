import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_uygulamasi/data/repo/not_defteri_dao_repositories.dart';

class NotEkleCubit extends Cubit<void> {

  NotEkleCubit():super(0);
  var nrepo = NotDefteriDaoRepo();

  Future<void> kaydet (String baslik, String not, String eklenmeTarih)async{
    await nrepo.notKaydet(baslik, not, eklenmeTarih);
    print("Not kaydedildi.");
  }
}