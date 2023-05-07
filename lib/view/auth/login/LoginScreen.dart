import 'package:consultant_app/view/auth/login/LoginVM.dart';
import 'package:consultant_app/view/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/Constants.dart';
import '../../widgets/CustomText.dart';
import '../../widgets/SocialIcons.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ChangeNotifierProvider<LoginVM>(
        create: (viewModel) => LoginVM(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: context.watch<LoginVM>().emailError,
                hintStyle: const TextStyle(
                    color: kHintGreyColor, fontSize: 12, fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: context.watch<LoginVM>().passwordError,
                hintStyle: const TextStyle(
                    color: kHintGreyColor, fontSize: 12, fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Consumer<LoginVM>(builder: (_, viewModel, __) {
              return Button(
                onPressed: viewModel.isLoading
                    ? null
                    : () {
                        if (!context.read<LoginVM>().validateInputs(
                            emailController.text, passwordController.text)) {
                          return;
                        }
                        viewModel.loginRequest(emailController.text,
                            passwordController.text, context);
                      },
                title: 'Log In',
              );
            }),
            const SizedBox(
              height: 20,
            ),
            CustomText(
                'orText', 14, 'Poppins', kHintGreyColor, FontWeight.w400),
            const SizedBox(
              height: 20,
            ),
            const SocialIcons(),
          ],
        ),
      ),
    );
  }
}
