import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_sepet/cubit/sepet_liste_cubt.dart';
import 'package:yemek_sepet/cubit/yemek_listele_cubit.dart';
import 'package:yemek_sepet/date/shared_preferances.dart';
import 'package:yemek_sepet/entiti/yemekler.dart';
import 'package:yemek_sepet/views/sepet.dart';
import 'package:yemek_sepet/views/yemek_detay_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyoruMu = false;

  @override
  void initState() {
    context.read<YemekListeleCubit>().YemekYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yemekler"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa())).then((value) {
                  setState(() {});
                });
              },
              icon: Icon(Icons.shopping_cart_outlined)),
          Text(toplam_tutar.toString())
        ],
      ),
      body: BlocBuilder<YemekListeleCubit, List<Yemek>>(
        builder: (context, YemeklerListesi) {
          if (YemeklerListesi.isNotEmpty) {
            return ListView.builder(
                itemCount: YemeklerListesi.length,
                itemBuilder: (context, index) {
                  var yemek = YemeklerListesi[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => YemeklerDetaySayfa(yemek: yemek))).then((value) {
                        context.read<YemekListeleCubit>().YemekYukle();
                        setState(() {});
                      });
                    },
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(
                              width: 150, height: 150, child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}")),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                yemek.yemek_adi,
                                style: const TextStyle(fontSize: 25),
                              ),
                              const SizedBox(height: 50),
                              Text(
                                "${yemek.yemek_fiyat} ₺",
                                style: const TextStyle(fontSize: 20, color: Colors.blue),
                              )
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: Text("burası çalıştı"));
          }
        },
      ),
    );
  }
}
