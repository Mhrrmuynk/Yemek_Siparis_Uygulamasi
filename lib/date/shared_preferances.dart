import 'package:shared_preferences/shared_preferences.dart';

var toplam_tutar = 0;
var sp;
Future<String> SepetToplam(int yemekFiyat) async {
  sp = await SharedPreferences.getInstance();
  toplam_tutar = (toplam_tutar + yemekFiyat);
  sp.setInt("toplam_tutar", toplam_tutar);
  toplam_tutar = sp.getInt("toplam_tutar");
  print("toplam tutar" + toplam_tutar.toString());
  return sp.getInt("toplam_tutar").toString();
}

Future<String> SepetCikarma(int yemekFiyat) async {
  sp = await SharedPreferences.getInstance();
  toplam_tutar -= yemekFiyat;
  sp.setInt("toplam_tutar", toplam_tutar);
  toplam_tutar = sp.getInt("toplam_tutar");
  print("toplam tutar" + toplam_tutar.toString());
  return sp.getInt("toplam_tutar").toString();
}
