import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_sepet/entiti/sepet_yemekler.dart';
import 'package:yemek_sepet/repo/yemklerdio_repo.dart';

class SepetListeleCubit extends Cubit<List<Sepet>> {
  SepetListeleCubit() : super(<Sepet>[]);

  var srepo = YemeklerRepo();

  Future<void> SepetYukle(String kullanici_adi) async {
    var liste = await srepo.tumSepet(kullanici_adi);
    emit(liste);
  }

  Future<void> sil(int sepet_yemek_id, String kullanici_adi) async {
    await srepo.SepetiSil(sepet_yemek_id, kullanici_adi);
    await SepetYukle("Muharrem_uyanik");
  }
}
