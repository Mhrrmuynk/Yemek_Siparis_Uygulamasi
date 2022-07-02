import 'package:yemek_sepet/entiti/yemekler.dart';

class YemekCevap {
  List<Yemek> yemekler;
  int success;

  YemekCevap({required this.yemekler, required this.success});

  factory YemekCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["yemekler"] as List;
    List<Yemek> YemeklerListesi = jsonArray.map((jsonArrayNesnesi) => Yemek.fromJson(jsonArrayNesnesi)).toList();
    return YemekCevap(yemekler: YemeklerListesi, success: json["success"] as int);
  }
}
