import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_uygulamasi/data/entity/not_class.dart';
import 'package:not_uygulamasi/ui/cubit/not_anasayfa_cubit.dart';
import 'package:not_uygulamasi/ui/vievs/cop_kutusu_not.dart';
import 'package:not_uygulamasi/ui/vievs/not_duzenle.dart';
import 'package:not_uygulamasi/ui/vievs/not_ekle.dart';

class NotDefteriAnaSayfa extends StatefulWidget {
  const NotDefteriAnaSayfa({super.key});

  @override
  State<NotDefteriAnaSayfa> createState() => _NotDefteriAnaSayfaState();
}

class _NotDefteriAnaSayfaState extends State<NotDefteriAnaSayfa> {
  bool aramaYapiliyorMu = false;
  final String notDurum = "Silinsin Mi ?";
  final String textButtonText = "Silinen Notlar";
  bool listview = true;
  var switchListTileText = "Liste Görünümü";
  @override
  void initState() {
    super.initState();
    context.read<NotAnasayfaCubit>().notYukle();
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      drawer: Drawer(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Menü",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _DrawerMenuItems(textButtonText: textButtonText),
                  const Icon(Icons.delete_outline_rounded)
                ],
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 19),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(switchListTileText),
                    Transform.scale(
                      scale: 0.7,
                      child: Switch(value: listview, onChanged: (value){ 
                                      setState(() {
                      listview = value;
                                      });
                                    }),
                    ),
                  ],
                ),
              ),
              const Divider(),
              
              
              
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: aramaYapiliyorMu
            ? TextField(
                decoration: const InputDecoration(hintText: "Ara"),
                onChanged: (aramaSonucu) {
                  context.read<NotAnasayfaCubit>().ara(aramaSonucu);
                },
              )
            : const Text("Notlar"),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                    });
                    context.read<NotAnasayfaCubit>().notYukle();
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
      body: BlocBuilder<NotAnasayfaCubit, List<Not>>(
          builder: (context, notlistesi) {
        if (notlistesi.isNotEmpty) {
          return listview == true ? ListView.builder(
              itemCount: notlistesi.length,
              itemBuilder: (context, indeks) {
                var not = notlistesi[indeks];
                return _ListViewNotes(not: not, notDurum: notDurum);
              }) : GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemCount:notlistesi.length,  itemBuilder: (context, indeks) {
                var not = notlistesi[indeks];
                return _ListViewNotes(not: not, notDurum: notDurum);});
        } else {
          return const Center();
        }
      }),
      floatingActionButton: const _NotEkle(),
    );
  }
}

class _DrawerMenuItems extends StatelessWidget {
  const _DrawerMenuItems({
    super.key,
    required this.textButtonText,
  });

  final String textButtonText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child:  Text(
          textButtonText,
          style: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const CopKutusuNotlar())).then((value) => {
                context.read<NotAnasayfaCubit>().notYukle(),
              });
        });
  }
}

class _NotEkle extends StatelessWidget {
  const _NotEkle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotDefteriNotEkle()))
            .then((value) {
          context.read<NotAnasayfaCubit>().notYukle();
        });
      },
      child: const Icon(Icons.add),
    );
  }
}

class _ListViewNotes extends StatelessWidget {
  const _ListViewNotes({
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NotDuzenle(notlar: not))).then((value) => {
                context.read<NotAnasayfaCubit>().notYukle(),
              });
        },
        child: Card(
          child: SizedBox(
            height: 130,
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
                      content: Text(
                          "Not: ${not.baslik} $notDurum"),
                      action: SnackBarAction(
                        label: "Evet",
                        onPressed: () {
                          context
                              .read<NotAnasayfaCubit>()
                              .copKutusunaKaydet(not.notId)
                              .then((value) {
                            context
                                .read<NotAnasayfaCubit>()
                                .sil(not.notId);
                          }).whenComplete(() {
                            context
                                .read<NotAnasayfaCubit>()
                                .notYukle();
                          });
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
