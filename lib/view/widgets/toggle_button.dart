import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({Key? key}) : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  List<bool> isSelected = [false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
// list of booleans
        isSelected: isSelected,
// text color of selected toggle
        selectedColor: Colors.white,
// text color of not selected toggle
        color: Colors.blue,
// fill color of selected toggle
        fillColor: Colors.lightBlue.shade900,
// when pressed, splash color is seen
        splashColor: Colors.red,
// long press to identify highlight color
        highlightColor: Colors.orange,
// if consistency is needed for all text style
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
// border properties for each toggle
        renderBorder: true,
        borderColor: Colors.black,
        borderWidth: 1.5,
        borderRadius: BorderRadius.circular(10),
        selectedBorderColor: Colors.pink,
// add widgets for which the users need to toggle
        children: [],
// to select or deselect when pressed
        onPressed: (int newIndex) {});
  }
}
