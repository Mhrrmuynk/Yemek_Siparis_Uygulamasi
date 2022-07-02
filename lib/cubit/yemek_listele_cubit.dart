import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_sepet/entiti/yemekler.dart';
import 'package:yemek_sepet/repo/yemklerdio_repo.dart';

class YemekListeleCubit extends Cubit<List<Yemek>> {
  YemekListeleCubit() : super(<Yemek>[]);

  var yrepo = YemeklerRepo();

  Future<void> YemekYukle() async {
    var liste = await yrepo.tumYemekler();
    emit(liste);
  }
}
