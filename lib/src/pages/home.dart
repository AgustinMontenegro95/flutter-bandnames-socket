
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/band.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Heroes del silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 5),
  ];

  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BandNames', style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => _bandTile(bands[index])
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed: () {
          _addNewBand();
        },
      ),
   );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        debugPrint('Direction: $direction');
        debugPrint('id: ${band.id}');
        //llamar el borrado en el server
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.center,
          child: Text('Delete Band'),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name!.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name.toString()),
        trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20)),
        onTap: () {
          debugPrint(band.name);
        },
      ),
    );
  }

  _addNewBand(){

    final textController = TextEditingController();

    if(Platform.isAndroid){
      return showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            title: const Text('New band name: '),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                child: const Text('ADD'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () {
                  addBandToList(textController.text);
                },
              ),
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context, 
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('New band name'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('ADD'),
              onPressed: () {
                addBandToList(textController.text);
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Dismiss'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );

  }

  void addBandToList(String name){
    debugPrint(name);
    if (name.length > 1){
      bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {
        
      });
    }
    Navigator.pop(context);
  }

}