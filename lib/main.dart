import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_uygulamasi/ui/cubit/cop_kutusu_cubit.dart';
import 'package:not_uygulamasi/ui/cubit/not_anasayfa_cubit.dart';
import 'package:not_uygulamasi/ui/cubit/not_duzenle.dart';
import 'package:not_uygulamasi/ui/cubit/not_ekle_cubit.dart';
import 'package:not_uygulamasi/ui/vievs/not_anasayfa.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (create)=> NotEkleCubit(),),
        BlocProvider(create: (create)=> NotAnasayfaCubit(),),
        BlocProvider(create: (create)=> NotDuzenleCubit(),),
        BlocProvider(create: (create)=> CopKutusuCubit())
      ],
      child: MaterialApp(
        title: 'Not Defteri',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
        home: const NotDefteriAnaSayfa(),
      ),
    );
  }
}
