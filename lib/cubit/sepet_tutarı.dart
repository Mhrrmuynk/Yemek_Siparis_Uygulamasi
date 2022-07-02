import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_sepet/repo/yemklerdio_repo.dart';

class SepetTutar extends Cubit<int> {
  SepetTutar() : super(0);

  var srepo = YemeklerRepo();

  Future<void> sepet_tutar_hesapla(int hesap) async {
    var liste = await srepo.hesap(hesap);
    emit(liste);
  }
}
