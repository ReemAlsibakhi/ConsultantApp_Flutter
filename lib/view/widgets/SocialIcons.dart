import 'package:flutter/cupertino.dart';

import 'CircularImage.dart';

class SocialIcons extends StatelessWidget {
  const SocialIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularImage('images/facebook.png'),
        const SizedBox(
          width: 20,
        ),
        CircularImage('images/twitter.png'),
        const SizedBox(
          width: 20,
        ),
        CircularImage('images/google.png'),
      ],
    );
  }
}
