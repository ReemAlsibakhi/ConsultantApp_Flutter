import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../lang/ar/AppStrings.dart';
import '../../../../utils/colors.dart';
import '../../../base/button.dart';
import '../../../base/custom_text.dart';
import '../../../base/social_icons.dart';
import 'login_vm.dart';

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
                AppStrings.email,
                context.watch<LoginVM>().emailError),
            _buildTextFormField(passwordController, true, TextInputType.text,
                AppStrings.password, context.watch<LoginVM>().passwordError),
            _buildButton(context),
            SizedBox(
              height: 15.h,
            ),
            CustomText(AppStrings.or, 12.sp, 'Poppins', kHintGreyColor,
                FontWeight.w400),
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
                _validateData(context, viewModel);
              },
        title: AppStrings.login,
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

  void _validateData(BuildContext context, LoginVM viewModel) {
    if (!context
        .read<LoginVM>()
        .validateInputs(emailController.text, passwordController.text)) {
      return;
    }
    viewModel.loginRequest(
        emailController.text, passwordController.text, context);
  }
}
