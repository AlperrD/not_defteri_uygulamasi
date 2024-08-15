import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_uygulamasi/data/entity/not_class.dart';
import 'package:not_uygulamasi/ui/cubit/cop_kutusu_cubit.dart';

class CopKutusuNotlar extends StatefulWidget {
  const CopKutusuNotlar({super.key});
  

  @override
  State<CopKutusuNotlar> createState() => _CopKutusuNotlarState();
}

class _CopKutusuNotlarState extends State<CopKutusuNotlar> {
  bool aramaYapiliyorMu = false;
  final String copKutusuAppBarText = "Silinen Notlar";
  final String notDurum = "Not Kalıcı Olarak Silinecek Emin Misin ?";
  @override
  void initState() {
    super.initState();
    context.read<CopKutusuCubit>().copKutusunotYukle();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu
            ? TextField(
                decoration: const InputDecoration(hintText: "Ara"),
                onChanged: (aramaSonucu) {
                  context.read<CopKutusuCubit>().copKutusuNotAra(aramaSonucu);
                },
              )
            :  Text(copKutusuAppBarText),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                    });
                    context.read<CopKutusuCubit>().copKutusunotYukle();
                  },
                  icon: const Icon(Icons.clear))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                  icon: const Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<CopKutusuCubit, List<Not>>(
          builder: (context, notlistesi) {
        if (notlistesi.isNotEmpty) {
          return ListView.builder(
              itemCount: notlistesi.length,
              itemBuilder: (context, indeks) {
                var not = notlistesi[indeks];
                return _CopKutusuListViewNotes(not: not, notDurum: notDurum);
              });
        } else {
          return const Center();
        }
      }),
    );
  }
}

class _CopKutusuListViewNotes extends StatelessWidget {
  const _CopKutusuListViewNotes({
    super.key,
    required this.not,
    required this.notDurum,
  });

  final Not not;
  final String notDurum;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
        },
        child: Card(
          child: SizedBox(
            height: 120,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          not.baslik,
                          style: const TextStyle(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Flexible(
                          child: Text(
                            not.not,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Text(
                          not.eklenmeTarihi,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                      content:
                          Text("Not: ${not.baslik}, $notDurum"),
                      action: SnackBarAction(
                        label: "Evet",
                        onPressed: () {
                          context
                              .read<CopKutusuCubit>()
                              .copKutusuNotSil(not.notId);
                          context
                              .read<CopKutusuCubit>()
                              .copKutusunotYukle();
    
                        },
                      ),
                    ));
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}