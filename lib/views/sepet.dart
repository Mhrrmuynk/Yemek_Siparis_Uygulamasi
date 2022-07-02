import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yemek_sepet/cubit/sepet_liste_cubt.dart';
import 'package:yemek_sepet/date/shared_preferances.dart';
import 'package:yemek_sepet/entiti/sepet_yemekler.dart';

class SepetSayfa extends StatefulWidget {
  SepetSayfa({Key? key}) : super(key: key);

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  int sepet_toplam_tutari = 0;

  @override
  void initState() {
    context.read<SepetListeleCubit>().SepetYukle("Muharrem_uyanik");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sepet"),
          actions: [const Icon(Icons.shopping_cart), Text(toplam_tutar.toString())],
        ),
        body: BlocBuilder<SepetListeleCubit, List<Sepet>>(
          builder: (context, SepetListesi) {
            if (SepetListesi.isNotEmpty) {
              return ListView.builder(
                  itemCount: SepetListesi.length,
                  itemBuilder: (context, index) {
                    var sepet = SepetListesi[index];
                    sepet_toplam_tutari = int.parse(sepet.yemek_fiyat) * int.parse(sepet.yemek_siparis_adet);

                    return Card(
                      child: Row(
                        children: [
                          SizedBox(
                              width: 150, height: 150, child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sepet.yemek_resim_adi}")),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sepet.yemek_adi,
                                style: const TextStyle(fontSize: 25),
                              ),
                              const SizedBox(height: 50),
                              Text(
                                "${sepet.yemek_fiyat} ₺ X ${sepet.yemek_siparis_adet} = ${int.parse(sepet.yemek_fiyat) * int.parse(sepet.yemek_siparis_adet)}",
                                style: const TextStyle(fontSize: 20, color: Colors.blue),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("${sepet.yemek_adi} silinsin mi?"),
                                  action: SnackBarAction(
                                    label: "Evet",
                                    onPressed: () {
                                      context.read<SepetListeleCubit>().sil(int.parse(sepet.sepet_yemek_id), sepet.kullanici_adi);
                                      SepetCikarma(sepet_toplam_tutari);
                                      setState(() {});
                                    },
                                  ),
                                ));
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.black45,
                              ))
                        ],
                      ),
                    );
                  });
              setState(() {});
            } else {
              return const Center(child: Text("burası çalıştı yemek"));
            }
          },
        ));
  }
}
