import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final TextInputType? keyboardType;

  final String formProperty;
  final Map<String, double> formValues;

  const CustomTextForm(
      {Key? key,
      this.hintText,
      this.labelText,
      this.icon,
      this.keyboardType,
      required this.formProperty,
      required this.formValues})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: icon == null ? null : Icon(icon)),
      onChanged: (value) =>
          formValues[formProperty] = (value != "") ? double.parse(value) : 0.0,
      validator: (value) {
        if (value == null) return 'Campo requerido';
        // ignore: prefer_is_empty
        return value.length < 1 ? 'Campo requerido' : null;
      },
    );
  }
}
