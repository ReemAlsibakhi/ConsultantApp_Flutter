import 'package:consultant_app/view/auth/login/login_vm.dart';
import 'package:consultant_app/view/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        create: (_) => LoginVM(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTextFormField(
                emailController,
                false,
                TextInputType.emailAddress,
                'Email',
                context.watch<LoginVM>().emailError),
            _buildTextFormField(passwordController, true, TextInputType.text,
                'Password', context.watch<LoginVM>().passwordError),
            _buildButton(context),
            SizedBox(
              height: 15.h,
            ),
            CustomText('OR', 12.sp, 'Poppins', kHintGreyColor, FontWeight.w400),
            SizedBox(
              height: 15.h,
            ),
            const SocialIcons(),
            SizedBox(
              height: 12.h,
            )
          ],
        ),
      ),
    );
  }

  Consumer<LoginVM> _buildButton(BuildContext context) {
    return Consumer<LoginVM>(builder: (_, viewModel, __) {
      return Button(
        onPressed: viewModel.isLoading
            ? null
            : () {
                if (!context.read<LoginVM>().validateInputs(
                    emailController.text, passwordController.text)) {
                  return;
                }
                viewModel.loginRequest(
                    emailController.text, passwordController.text, context);
              },
        title: 'Log In',
      );
    });
  }

  Widget _buildTextFormField(TextEditingController controller, bool obscure,
      TextInputType inputType, String label, String? error) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: null,
          errorText: error,
          hintText: label,
          errorStyle: TextStyle(
              color: Colors.red, fontSize: 8.sp, fontFamily: 'Poppins'),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kGreyColor),
          ),
          labelStyle: TextStyle(
              color: kHintGreyColor, fontSize: 12.sp, fontFamily: 'Poppins'),
          contentPadding: const EdgeInsets.all(0.0),
          hintStyle: TextStyle(
              color: kHintGreyColor, fontSize: 12.sp, fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}
