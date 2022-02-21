import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

//Si el state es bastante grande lo ideal es moverlo a otro archivo junto a todos
// los widget necesarios para su funcionamiento

//Creamos un stateful widget Para manejar que cada vez que haya un cambio en nuestra
// app, esta se actualice y no haya que recargar la app, consiste en 2 partes
//parte 1 un statefulwidget
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

//parte 2 Este es el estado encargado de actualizar nuestra ui, dentro definimos lo componente de ui que se actualizaran
class _RandomWordsState extends State<RandomWords> {
  //Aqui definimos una variable que almacenara un listado de wordpair
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  //Aqui creamos una funcion que retornara un listView que tambien es un widget (Toodo es un widget aqui)
  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),

        //  Para agregar elementos a nuestro listView utilizamos el elemento Itembuilder
        //  el cual es una funcion que recibe 2 parametros

        itemBuilder: (context, item) {
          //Los divider son separadores
          if (item.isOdd) {
            return const Divider();
          }

          //Calculate the number of wordpairs that are on the list minus the divider widgets
          final index = item ~/ 2;

          if (index >= _randomWordPairs.length) {
            //Aqui asigno los valores a mi estado utilizando el metodo generate, le envio 10 wordPairs
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }

          //Retornamos el widget que nos creara el row de la lista
          return _buildRow(_randomWordPairs[index]);
        });
  }

  Widget _buildRow(WordPair wordPair) {
    //Aqui retornamos un listTile que es basicamente un row de la lista
    return ListTile(
      title: Text(wordPair.asPascalCase,
          style: const TextStyle(fontSize: 20, color: Colors.black)),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Aqui indicamos la estructura visual que deseamos que tenga nuestra app
    //Esta nos permite crear pantallas con elementos de ui en comun
    // scaffold es un widget de alto nivel que nos permite tener varios widget de bajo nivel

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Word Generator"),
      ),

//  El contenedor es lo que debemos de utilizar para mover widgets en la pantalla

      body: Container(
//  Indicamos el hijo del contenedor, que es el elemento que deseamos manejar
        child: _buildList(),

//modificaciones de margin padding y height y widht
//         margin: const EdgeInsets.all(100),
//         padding: const EdgeInsets.all(10),
//         color: Colors.blueGrey,
//         height: 100,
//         width: 100,
      ),
    );
  }
}
