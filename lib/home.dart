import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _resultado = "";
  TextEditingController cepController = TextEditingController();

  _recuperarCep(String cep) async {
    String url = "https://viacep.com.br/ws/${cep}/json/";
    http.Response response;
    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
    _resultado = "${retorno["logradouro"]}, ${retorno["bairro"]}, ${retorno["localidade"]}, ${retorno["uf"]}"
        "${retorno["cep"]}";
    print(cep);

    });
    print(_resultado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(children: [
          TextField(
            keyboardType: TextInputType.number,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            maxLength: 8,
            decoration: InputDecoration(
              labelText: "Digite o cep: ex: 79002141",
            ),
            style: TextStyle(fontSize: 20),
            controller: cepController,
          ),
          ElevatedButton(
              onPressed: () => _recuperarCep(cepController.text), child: Text("Clique aqui")),

          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(_resultado, style: TextStyle(fontSize: 20),),
          ),
        ]),
      ),
    );
  }
}
