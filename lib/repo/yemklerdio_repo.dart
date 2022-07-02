import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yemek_sepet/entiti/sepet_yemekler.dart';
import 'package:yemek_sepet/entiti/yeme_cevap.dart';
import 'package:yemek_sepet/entiti/yemek_sepeti_cevap.dart';
import 'package:yemek_sepet/entiti/yemekler.dart';

class YemeklerRepo {
  List<Yemek> parsYemeklerCevap(String cevap) {
    return YemekCevap.fromJson(json.decode(cevap)).yemekler;
  }

  List<Sepet> parsSepetCevap(String cevap) {
    if (cevap == null) {
      return <Sepet>[];
    } else {
      return SepetCevap.fromJson(json.decode(cevap)).sepet_yemekler;
    }
  }

  Future<void> SepeteEkle(String yemek_ad, String yemek_fiyat, String yemek_resim_adi, String yemek_adedi, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi": yemek_ad,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat,
      "yemek_siparis_adet": yemek_adedi,
      "kullanici_adi": kullanici_adi
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
  }

  Future<List<Yemek>> tumYemekler() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parsYemeklerCevap(cevap.data.toString());
  }

  Future<List<Sepet>> tumSepet(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";

    var veri = {"kullanici_adi": kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    if (cevap == null) ;
    return parsSepetCevap(cevap.data.toString());
  }

  Future<void> SepetiSil(int sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"kullanici_adi": kullanici_adi, "sepet_yemek_id": sepet_yemek_id.toString()};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("sepet sil : ${cevap.data.toString()}");
  }

  Future<int> hesap(int yemekFiyat) async {
    int toplam_tutar = 0;

    var sp = await SharedPreferences.getInstance();
    toplam_tutar = sp.getInt("toplam_tutar") ?? 0;

    toplam_tutar += yemekFiyat;

    sp.setInt("toplam_tutar", toplam_tutar);
    return toplam_tutar;
  }
}
