import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:not_uygulamasi/ui/cubit/not_ekle_cubit.dart';

class NotDefteriNotEkle extends StatefulWidget {
  const NotDefteriNotEkle({super.key});

  @override
  State<NotDefteriNotEkle> createState() => _NotDefteriNotEkleState();
}

class _NotDefteriNotEkleState extends State<NotDefteriNotEkle> {
  TextEditingController baslikController = TextEditingController();
  TextEditingController notController = TextEditingController();
  DateTime now = DateTime.now();

  final String iconButtonTooltip = "Not Ekle";
  final String appBarTitleText = "Not Ekle";
  final String notEklemeBasarili = "Not Eklendi";
  final String notEklemeBasarisiz = "Boş Not Eklenemedi.";
  final String notEkleBaslikText = "Başlık";
  final String notEkleIcerikText = 'Notunuzu buraya yazın...';

  // Tarih ve saat formatlarını belirle
  DateFormat dateFormat1 = DateFormat('dd.MM.yyyy');
  DateFormat timeFormat = DateFormat('HH:mm');
  String formattedDateTime = '';
  void _formatDateTime() {
    // Şu anki tarihi ve saati al
    DateTime now = DateTime.now();

    // Tarih ve saat formatlarını belirle
    DateFormat dateFormat = DateFormat('dd.MM.yyyy');
    DateFormat timeFormat = DateFormat('HH:mm');

    // Formatlı tarih ve saati al
    String formattedDate = dateFormat.format(now);
    String formattedTime = timeFormat.format(now);

    // Tarih ve saati birleştir
    setState(() {
      formattedDateTime = '$formattedDate - $formattedTime';
    });
  }

  void otoSave(bool didPop, Object? result) {
    if (didPop) {
      _formatDateTime();
      (notController.text != "" || baslikController.text != "")
          ? {
              context.read<NotEkleCubit>().kaydet(baslikController.text, notController.text, formattedDateTime),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(notEklemeBasarili))),
              setState(() {
                notController.text = "";
                baslikController.text = "";
              })
            }
          : false; //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(notEklemeBasarisiz)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: true,
      onPopInvokedWithResult: otoSave,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            appBarTitleText,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          //leading: const Icon(Icons.arrow_back_ios_outlined),
          centerTitle: false,
          actions: [
            IconButton(
              tooltip: iconButtonTooltip,
              icon: const Icon(Icons.save),
              onPressed: () {
                _formatDateTime();
                (notController.text != "" || baslikController.text != "")
                    ? {
                        context
                            .read<NotEkleCubit>()
                            .kaydet(baslikController.text, notController.text, formattedDateTime),
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(notEklemeBasarili))),
                        setState(() {
                          notController.text = "";
                          baslikController.text = "";
                        })
                      }
                    : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(notEklemeBasarisiz)));
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xFF1c1c22), //const Color.fromARGB(255, 65, 64, 61),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                //color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: baslikController,
                style: const TextStyle(fontSize: 25),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: notEkleBaslikText,
                  contentPadding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 5),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: notController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: notEkleIcerikText,
                    contentPadding: const EdgeInsets.all(5.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
