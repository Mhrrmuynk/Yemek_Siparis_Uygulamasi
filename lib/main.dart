import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_sepet/cubit/sepet_liste_cubt.dart';

import 'package:yemek_sepet/cubit/yemek_deyat_cubit.dart';
import 'package:yemek_sepet/cubit/yemek_listele_cubit.dart';
import 'package:yemek_sepet/entiti/sepet_yemekler.dart';
import 'package:yemek_sepet/views/anasayfa.dart';
import 'package:yemek_sepet/views/sepet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => YemekDetayCubit(),
        ),
        BlocProvider(
          create: (context) => SepetListeleCubit(),
        ),
        BlocProvider(create: (context) => YemekListeleCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Anasayfa(),
      ),
    );
  }
}
