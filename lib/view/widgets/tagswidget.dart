

import 'package:flutter/material.dart';

Widget tagsWidget ({required  String label}){
  return   Chip(
    label: Text('#$label'),
    backgroundColor: Colors.grey.shade300,
  );
}