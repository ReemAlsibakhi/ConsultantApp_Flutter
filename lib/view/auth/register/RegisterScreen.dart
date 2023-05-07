import 'package:consultant_app/view/auth/register/RegisterVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/Constants.dart';
import '../../../view_models/auth_view_model.dart';
import '../../widgets/Button.dart';
import '../../widgets/CustomText.dart';
import '../../widgets/SocialIcons.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  AuthViewModel authModel = AuthViewModel();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirm_passdController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ChangeNotifierProvider<RegisterVM>(
        create: (viewModel) => RegisterVM(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'UserName',
                errorText: context.watch<RegisterVM>().nameError,
                hintStyle: const TextStyle(
                    color: kHintGreyColor, fontSize: 12, fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: context.watch<RegisterVM>().emailError,
                hintStyle: const TextStyle(
                    color: kHintGreyColor, fontSize: 12, fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: context.watch<RegisterVM>().passwordError,
                hintStyle: const TextStyle(
                    color: kHintGreyColor, fontSize: 12, fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: confirm_passdController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                errorText: context.watch<RegisterVM>().confirmPasswordError,
                hintStyle: const TextStyle(
                    color: kHintGreyColor, fontSize: 12, fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Consumer<RegisterVM>(builder: (_, viewModel, __) {
              return Button(
                onPressed: viewModel.isLoading
                    ? null
                    : () {
                        if (!context.read<RegisterVM>().validateInputs(
                            emailController.text,
                            passwordController.text,
                            confirm_passdController.text,
                            nameController.text)) {
                          return;
                        }
                        viewModel.registerRequest(
                            emailController.text,
                            passwordController.text,
                            nameController.text,
                            context);
                      },
                title: 'Sign Up',
              );
            }),
            const SizedBox(
              height: 20,
            ),
            CustomText(authModel.orText, 14, 'Poppins', kHintGreyColor,
                FontWeight.w400),
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
