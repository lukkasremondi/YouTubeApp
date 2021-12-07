import 'package:flutter/material.dart';
import 'package:youtube_app/telas/Inicio.dart';
import 'package:youtube_app/telas/EmAlta.dart';
import 'package:youtube_app/telas/Inscricoes.dart';
import 'package:youtube_app/telas/Biblioteca.dart';
import 'package:youtube_app/CustomSearchDelegate.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual = 0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {



    List telas = [
      Inicio(_resultado),
      EmAlta(),
      Inscricoes(),
      Biblioteca(),
    ];


    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.grey,
          opacity: 1,
        ),
        backgroundColor: Colors.white,
        title: Image.asset("images/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String? res = await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
              );
              setState(() {
                _resultado = res!;
              });
              //print("Resultado: Digitado " + res!);
            },
          ),
          /*
          //  Botos do youtube. Sem atribuicao neste projeto
          IconButton(
              onPressed: (){print("acao: videocam");},
              icon: Icon(Icons.videocam),
          ),
        IconButton(
            onPressed: (){print("acao: conta");},
            icon: Icon(Icons.account_circle),
        )*/
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        currentIndex: _indiceAtual,

        onTap: (indice){
          setState(() {
            _indiceAtual = indice;
            //print(_indiceAtual.toString());
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text("Início"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
              title: Text("Em Alta"),
              icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
              title: Text("Inscrições"),
              icon: Icon(Icons.subscriptions)
          ),
          BottomNavigationBarItem(
              title: Text("Biblioteca"),
              icon: Icon(Icons.folder)
          ),
        ],

      ),
    );
  }
}
