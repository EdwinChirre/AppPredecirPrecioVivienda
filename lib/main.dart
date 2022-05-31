import 'package:flutter/material.dart';
import 'package:flutter_precio_casa/screens/pred_precio_form.dart';

//crear mi funcion de arranque

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const MaterialApp(
        title: "Precio de viviendas App",
        debugShowCheckedModeBanner: false,
        home: preciocasaForm());
  }
}
