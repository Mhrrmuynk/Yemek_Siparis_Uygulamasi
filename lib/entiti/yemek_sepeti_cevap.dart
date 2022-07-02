import 'package:yemek_sepet/entiti/sepet_yemekler.dart';

class SepetCevap {
  List<Sepet> sepet_yemekler;
  int success;

  SepetCevap({required this.sepet_yemekler, required this.success});

  factory SepetCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List;
    List<Sepet> YemeklerListesi = jsonArray.map((jsonArrayNesnesi) => Sepet.fromJson(jsonArrayNesnesi)).toList();
    return SepetCevap(sepet_yemekler: YemeklerListesi, success: json["success"] as int);
  }
}
