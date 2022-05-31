import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double min;
  final double max;
  final int? divisions;
  final String label;

  final String formProperty;
  final Map<String, double> sendValues;

  const CustomSlider({
    Key? key,
    required this.min,
    required this.max,
    this.divisions,
    required this.label,
    required this.formProperty,
    required this.sendValues,
  }) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${widget.label}: ${_value.toString()}'),
        Slider(
            value: _value,
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions ?? 0,
            onChanged: (value) {
              widget.sendValues[widget.formProperty] = value;

              setState(() {
                _value = value;
              });
              // ignore: avoid_print
              print(value);
            }),
      ],
    );
  }
}
