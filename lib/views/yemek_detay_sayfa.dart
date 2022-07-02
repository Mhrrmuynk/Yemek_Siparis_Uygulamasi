import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_sepet/cubit/sepet_liste_cubt.dart';
import 'package:yemek_sepet/cubit/yemek_deyat_cubit.dart';
import 'package:yemek_sepet/date/shared_preferances.dart';
import 'package:yemek_sepet/entiti/yemekler.dart';

class YemeklerDetaySayfa extends StatefulWidget {
  Yemek yemek;
  YemeklerDetaySayfa({Key? key, required this.yemek}) : super(key: key);

  @override
  State<YemeklerDetaySayfa> createState() => _YemeklerDetaySayfaState();
}

class _YemeklerDetaySayfaState extends State<YemeklerDetaySayfa> {
  int sepet_tutari = 0;
  int values = 0;

  @override
  Widget build(BuildContext context) {
    var yemek = widget.yemek;

    return Scaffold(
      appBar: AppBar(
        title: Text(yemek.yemek_adi),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
            Text(yemek.yemek_adi),
            Text(
              "${yemek.yemek_fiyat} ₺",
              style: TextStyle(fontSize: 32, color: Colors.red),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (values > 0) {
                        --values;
                        sepet_tutari = urun_toplam(yemek);
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.horizontal_rule)),
                Text("$values", style: TextStyle(fontSize: 32)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        ++values;
                        sepet_tutari = urun_toplam(yemek);
                      });
                    },
                    icon: Icon(Icons.add)),
              ],
            ),
            Text(
              "Toplam Tutar: ${sepet_tutari} ₺",
              style: TextStyle(fontSize: 32, color: Colors.red),
            ),
            ElevatedButton(
                onPressed: () {
                  SepetToplam(sepet_tutari);

                  context
                      .read<YemekDetayCubit>()
                      .SepeteEkle(yemek.yemek_adi, yemek.yemek_fiyat, yemek.yemek_resim_adi, values.toString(), yemek.kullanici_adi);
                },
                child: const Text("sepete ekle"))
          ],
        ),
      ),
    );
  }

  int urun_toplam(Yemek yemek) {
    return (int.parse(yemek.yemek_fiyat) * values);
  }
}



// import 'package:flutter/material.dart';
// import 'package:provider/src/provider.dart';

// import 'package:yemek_sepet/entiti/yemekler.dart';

// class YemekDetaySayfa extends StatefulWidget {
//   Yemek yemek;
//   YemekDetaySayfa({Key? key, required this.yemek}) : super(key: key);
//   @override
//   State<YemekDetaySayfa> createState() => _YemekDetaySayfaState();
// }

// class _YemekDetaySayfaState extends State<YemekDetaySayfa> {
//   var tfKisiAdi = TextEditingController();
//   var tfKisiTel = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     var yemek = widget.yemek;
//     tfKisiAdi.text = yemek.yemek_adi;
//     tfKisiTel.text = yemek.yemek_fiyat;
//     tfKisiTel.text = yemek.yemek_fiyat;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Kisi Guncelle"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(80.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               TextField(
//                 controller: tfKisiAdi,
//                 decoration: const InputDecoration(hintText: "kişi adi"),
//               ),
//               TextField(
//                 controller: tfKisiTel,
//                 decoration: const InputDecoration(hintText: "kişi Tel"),
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     context.read<KisiDetayCubit>().KisiGuncelle(int.parse(widget.kisi.kisi_id), tfKisiAdi.text, tfKisiTel.text);
//                   },
//                   child: const Text("Kaydet"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
