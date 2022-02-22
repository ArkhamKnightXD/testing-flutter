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
  final _savedWordPairs = <WordPair>{};

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

    //Evaluando si la wordPair enviada ya fue guardada
    final alreadySaved = _savedWordPairs.contains(wordPair);

    //Aqui retornamos un listTile que es basicamente una fila de la lista
    return ListTile(
      title: Text(wordPair.asPascalCase,
          style: const TextStyle(fontSize: 20, color: Colors.black)),

      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border, color: alreadySaved ? Colors.red : Colors.blueGrey),

      onTap: () {

        setState(() {

          if(alreadySaved){

            _savedWordPairs.remove(wordPair);
          }
          else{

            _savedWordPairs.add(wordPair);
          }
        });
      },
    );
  }

  // esta funcion abrira otra pagina, utilizaremos navigator que es el widget
// encargado de las rutas
    void _pushSaved() {

    //le enviamos el context al navigator
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context){

          final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair wordPair)  {

            return ListTile(
              title: Text(wordPair.asPascalCase, style: const TextStyle(fontSize: 16.0),),
            );
          });

          //Esto me agrega separacion entre las distintas filas de la lista de que envie
          final List<Widget> divided = ListTile.divideTiles(context: context, tiles: tiles).toList();

          return Scaffold(

            appBar: AppBar(

              title: const Text("Save Words"),
              backgroundColor: Colors.blueGrey,
            ),

            body: ListView(
              children: divided,
            ),
          );
        })
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
      //  De esta forma agrego un boton y su funcionalidad en el appbar
        actions: <Widget>[
          //definimos el widget icon le enviamos un widget de icon junto a la funcionalidad
          // que deseamos que haga cuando este sea presionado
          IconButton(onPressed: _pushSaved, icon: const Icon(Icons.list))
        ],
      ),

//  El contenedor es lo que debemos de utilizar para mover widgets en la pantalla y agregar margin y padding

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

