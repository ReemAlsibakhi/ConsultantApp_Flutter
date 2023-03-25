import 'package:consultant_app/view/auth/login/LoginVM.dart';
import 'package:consultant_app/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/Constants.dart';
import '../../widgets/Button.dart';
import '../../widgets/CustomText.dart';
import '../../widgets/SocialIcons.dart';
import '../../widgets/customTextField.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  AuthViewModel authModel = AuthViewModel();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<LoginVM>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          customTextField(
            authModel.emailTFHintText,
            false,
            controller: emailController,
          ),
          const SizedBox(
            height: 16,
          ),
          customTextField(
            authModel.passTFHint,
            true,
            controller: passController,
          ),
          const SizedBox(
            height: 40,
          ),
          Button(
            title: authModel.signInBtnText,
            onPressed: () async {
              viewModel.loginRequest(
                  emailController.text, passController.text, context);
              print(passController.text);
              print(emailController.text);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomText(
              authModel.orText, 14, 'Poppins', kHintGreyColor, FontWeight.w400),
          const SizedBox(
            height: 20,
          ),
          const SocialIcons(),
        ],
      ),
    );
  }
}
