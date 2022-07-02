import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_sepet/repo/yemklerdio_repo.dart';

class YemekDetayCubit extends Cubit<void> {
  YemekDetayCubit() : super(0);
  var krepo = YemeklerRepo();

  Future<void> SepeteEkle(String yemek_ad, String yemek_fiyat, yemek_resim_adi, yemek_adedi, kullanici_adi) async {
    await krepo.SepeteEkle(yemek_ad, yemek_fiyat, yemek_resim_adi, yemek_adedi, kullanici_adi);
  }
}
