import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_uygulamasi/data/entity/not_class.dart';
import 'package:not_uygulamasi/data/repo/not_defteri_dao_repositories.dart';

class CopKutusuCubit extends Cubit<List<Not>> {
  CopKutusuCubit() : super(<Not>[]);

  var nrepo = NotDefteriDaoRepo();

  Future<void> copKutusunotYukle() async {
    var liste = await nrepo.copKutusuNotYukle();
    print("cop kutusuna not yükleme cubit çalıştı");
    emit(liste);
  }

  Future<void> copKutusuNotSil(int notId) async {
    // List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM notDefteri WHERE notId = $notId');
    // await nrepo.notKaydetCop(notId);
    await nrepo.copKutusuSil(notId);
    print("cop kutusundan not silme cubit çalıştı. ");
  }

  Future<void> copKutusuNotAra(String aramaKelimesi) async {
    var liste = await nrepo.copKutusuNotara(aramaKelimesi);
    emit(liste);
  }
}
