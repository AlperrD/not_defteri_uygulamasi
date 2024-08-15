import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:not_uygulamasi/data/entity/not_class.dart';
import 'package:not_uygulamasi/ui/cubit/not_duzenle.dart';

class NotDuzenle extends StatefulWidget {
  final Not notlar;
  const NotDuzenle({super.key,required this.notlar});

  @override
  State<NotDuzenle> createState() => _NotDuzenleState();
}

class _NotDuzenleState extends State<NotDuzenle> {
  TextEditingController baslikController = TextEditingController();
  TextEditingController notController = TextEditingController();
  String formattedDateTime = "";
  final String notDuzenleAppBarText = 'Not Düzenle';
  final String appBarIconButtonToolTipText = "Düzenlemeyi Kaydet";
  final String notDuzenlendiText = "Not Düzenlendi";
  final String notDuzenlemeBasarisizText = "Boş Not Düzenlenemez";
  final String notDuzenleBaslik = "Başlık";
  final String notDuzenleIcerik = 'Notunuzu buraya yazın...';
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
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var not  = widget.notlar;
    baslikController.text = not.baslik;
    notController.text = not.not;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(notDuzenleAppBarText,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        //leading: const Icon(Icons.arrow_back_ios_outlined),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: appBarIconButtonToolTipText,
            onPressed: () { 
              _formatDateTime();
              baslikController.text != widget.notlar.baslik || notController.text != widget.notlar.not?{
              context.read<NotDuzenleCubit>().guncelle(widget.notlar.notId, baslikController.text, notController.text, formattedDateTime),
              ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(notDuzenlendiText))),
              } : ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(notDuzenlemeBasarisizText)));
            },
          ),
        ],
      ),
      body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Container(
    decoration: BoxDecoration(
     color:const Color.fromARGB(255, 65, 64, 61),
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
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: baslikController,
            maxLines: null,
            style: const TextStyle(fontSize: 25),
            decoration:  InputDecoration(
              border: InputBorder.none,
              hintText: notDuzenleBaslik,
              contentPadding: const EdgeInsets.all(8.0),
            ),
          ),
        ),
        Expanded(
  // TextField'in daha fazla yer kaplamasını sağlar
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: notController,
              maxLines: null, // Metnin çok satırlı olmasını sağlar
              decoration:  InputDecoration(
                border: InputBorder.none,
                hintText: notDuzenleIcerik,
                contentPadding: const EdgeInsets.all(8.0),
              ),
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