import 'dart:convert';

import 'package:exibe_imagens/src/models/image_model.dart';
import 'package:exibe_imagens/src/widgets/image_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppState extends State<App> {
  int numeroImagens = 0;
  int currentPage = 1;
  List<ImageModel> imagens = [];

  void obterImagem() async {
    var request = http.Request(
        'get',
        Uri.https('api.pexels.com', 'v1/curated',
            {'page': '$currentPage', 'per_page': '1'}));
    request.headers.addAll({
      'Authorization': '' //api key
    });
    final result = await request.send();
    if (result.statusCode == 200) {
      final response = await http.Response.fromStream(result);
      var decodedJSON = json.decode(response.body);
      var imagem = ImageModel.fromJSON(decodedJSON);
      setState(() {
        currentPage++;
        imagens.add(imagem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Imagens"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: obterImagem,
        child: const Icon(Icons.add_a_photo_outlined),
      ),
      body: ImageList(imagens),
    ));
  }
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}
