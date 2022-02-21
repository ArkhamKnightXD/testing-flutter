//Primero importamos la libreria material de flutter,
// esto nos permite acceder a multiples widgets y diseños de ui
import 'package:flutter/material.dart';
import 'package:learning_flutter/random_words.dart';

//Creamos nuestra funcion main
void main(){

  //flutter tiene una funcion global runApp que toma un unico widget como argumento
  //y Mostrara ese widget en cualquier dispositivo que estemos utilizando
  runApp(MyApp());
}

//Los statelesswidget son lo que se deben de utilizar solo para la visualizacion
// de los datos y no para realizar calculos o logicas de negocios
class MyApp extends StatelessWidget {
  //Constructor del widget, podemos ignorarlo por ahora
  const MyApp({Key? key}) : super(key: key);

  //El metodo build retorna un widget y es el que utilizaremos para crear y modificar el ui
  @override
  Widget build(BuildContext context) {
    //MaterialApp es lo que se utiliza como la raiz de la app
    return const MaterialApp(


     home: RandomWords(),
    );
  }
}





//Notas como podemos ver al final, una app en flutter solo son un conjunto de widgets agregados de forma coherente
