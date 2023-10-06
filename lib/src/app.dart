import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppState extends State<App> {
  int numeroImagens = 0;

  void obterImagem() async {
    var request = http.Request(
        'get',
        Uri.https(
            'api.pexels.com', 'v1/curated', {'page': '1', 'per_page': '1'}));
    request.headers.addAll({
      'Authorization': '' //api key
    });
    var result = await request.send();
    if (result.statusCode == 200) {
      var response = await http.Response.fromStream(result);
      print(response.body);
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
        body: Center(
            child: Text('You have pressed the button $numeroImagens times.')),
      ),
    );
  }
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}
