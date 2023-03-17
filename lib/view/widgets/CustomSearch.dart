import 'package:consultant_app/view/search/SearchVM.dart';
import 'package:flutter/material.dart';

import '../../utils/Constants.dart';

class CustomSearch extends StatelessWidget {
  CustomSearch(
    this.vm, {
    Key? key,
  }) : super(key: key);
  SearchVM vm;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      onChanged: (value) {
        vm.setText(value);
        print('value : $value');
      },
      decoration: InputDecoration(
        fillColor: kLightGreyColor,
        filled: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 1, color: kGreyColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 1, color: kLightPrimaryColor)),
        hintText: 'Search',
        hintStyle: const TextStyle(
            color: kHintGreyColor, fontSize: 12, fontFamily: 'Poppins'),
        prefixIcon: Image.asset('images/search.png'),
      ),
    );
  }
}
