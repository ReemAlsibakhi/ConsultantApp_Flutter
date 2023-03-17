import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 25),
      child: TextField(
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          labelText: 'search',
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search),
          // hintText: 'search',
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.8),
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400, width: 0.8),
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
        ),
      ),
    );
  }
}
