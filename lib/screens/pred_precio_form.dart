//import 'dart:html';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/custom_slider.dart';
import '../widgets/custom_text_form_field.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class preciocasaForm extends StatelessWidget {
  const preciocasaForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    Map<String, double> sendValues = {
      "BsmtFinSF1": 0,
      "GarageYrBlt": 0,
      "p1stFlrSF": 0,
      "GarageArea": 0,
      "TotalBsmtSF": 0,
      "YearBuilt": 0,
      "GarageCars": 0,
      "GrLivArea": 0,
      "OverallQual": 0
    };

    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text('Estimación de precios de viviendas'))),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        child: Form(
          key: formkey,
          child: Column(children: [
            CustomTextForm(
                labelText: 'Tamaño terminado del tipo 1 (m2)',
                hintText: '0 m2',
                formProperty: 'BsmtFinSF1',
                formValues: sendValues,
                keyboardType: TextInputType.number),
            CustomTextForm(
                labelText: 'Año en el que se construyó el garaje',
                hintText: '1900',
                formProperty: 'GarageYrBlt',
                formValues: sendValues,
                keyboardType: TextInputType.number),
            CustomTextForm(
                labelText: 'Tamaño del primer piso (m2)',
                hintText: '0 m2',
                formProperty: 'p1stFlrSF',
                formValues: sendValues,
                keyboardType: TextInputType.number),
            CustomTextForm(
                labelText: 'Tamaño del garaje (m2)',
                hintText: '0 m2',
                formProperty: 'GarageArea',
                formValues: sendValues,
                keyboardType: TextInputType.number),
            CustomTextForm(
                labelText: 'Tamaño del área del zótano (m2)',
                hintText: '0 m2',
                formProperty: 'TotalBsmtSF',
                formValues: sendValues,
                keyboardType: TextInputType.number),
            CustomTextForm(
                labelText: 'Año de construcción de la casa',
                hintText: '0 m2',
                formProperty: 'YearBuilt',
                formValues: sendValues,
                keyboardType: TextInputType.number),
            CustomTextForm(
                labelText: 'Tamaño del garaje en capacidad de automóviles',
                hintText: '0',
                formProperty: 'GarageCars',
                formValues: sendValues,
                keyboardType: TextInputType.number),
            CustomTextForm(
                labelText:
                    'Tamaño superficie habitable sobre el nivel de suelo (m2)',
                hintText: '0 m2',
                formProperty: 'GrLivArea',
                formValues: sendValues,
                keyboardType: TextInputType.number),
            SizedBox(height: 30),
            //Text('Puntaje sobre la material y calidad de acabado'),
            CustomSlider(
                formProperty: 'OverallQual',
                sendValues: sendValues,
                min: 1,
                max: 10,
                divisions: 9,
                label:
                    'Puntaje sobre la material y calidad de acabado (1 es bajo y 10 es alto)'),
            SizedBox(height: 30),
            ElevatedButton(
              child: const SizedBox(
                  width: double.infinity,
                  child: Center(child: Text('Estimar'))),
              onPressed: () async {
                if (!formkey.currentState!.validate()) {
                  return;
                }
                print(sendValues);
                //ruta del app
                final url = Uri.https("api-pred-casa-edwchi.herokuapp.com",
                    "/preciocasa-predictions");

                final response = await http.post(url,
                    body: json.encode(sendValues),
                    headers: {
                      'Content-Type': "application/json; charset=utf-8"
                    });

                print('Code Status: ${response.statusCode}');
                print('Response Body: ${response.body}');

                var precio_pred = 0.0;

                //final jsonResponse = jsonDecode(response.body);
                //precio_pred = jsonResponse['precio_casa'];
                //print(precio_pred);
                if (response.statusCode == 201) {
                  final jsonResponse = jsonDecode(response.body);
                  precio_pred = jsonResponse['precio_casa'];

                  Alert(
                      context: context,
                      type: AlertType.info,
                      title: "",
                      desc:
                          "La vivienda tiene un precio estimado de ${precio_pred} dólares",
                      buttons: [
                        DialogButton(
                            child: Text("OK"),
                            onPressed: () => Navigator.pop(context))
                      ]).show();
                }
              },
            )
          ]),
        ),
      )),
    );
  }
}
