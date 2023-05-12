import 'package:consultant_app/lang/ar/AppStrings.dart';
import 'package:consultant_app/view/screens/auth/register/register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';
import '../../../base/button.dart';
import '../../../base/custom_text.dart';
import '../../../base/social_icons.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ChangeNotifierProvider<RegisterVM>(
        create: (viewModel) => RegisterVM(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTextFormField(nameController, false, TextInputType.text,
                AppStrings.userName, context.watch<RegisterVM>().nameError),
            _buildTextFormField(
                emailController,
                false,
                TextInputType.emailAddress,
                AppStrings.email,
                context.watch<RegisterVM>().emailError),
            _buildTextFormField(passwordController, true, TextInputType.text,
                AppStrings.password, context.watch<RegisterVM>().passwordError),
            _buildTextFormField(
                confirmPassController,
                true,
                TextInputType.text,
                AppStrings.password,
                context.watch<RegisterVM>().confirmPasswordError),
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

  Consumer<RegisterVM> _buildButton(BuildContext context) {
    return Consumer<RegisterVM>(builder: (_, viewModel, __) {
      return Button(
        onPressed: viewModel.isLoading
            ? null
            : () {
                _validateData(context, viewModel);
              },
        title: AppStrings.signUp,
      );
    });
  }

  Widget _buildTextFormField(TextEditingController controller, bool obscure,
      TextInputType inputType, String label, String? error) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: null,
          hintText: label,
          errorText: error,
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

  void _validateData(BuildContext context, RegisterVM viewModel) {
    if (!context.read<RegisterVM>().validateInputs(
        emailController.text,
        passwordController.text,
        confirmPassController.text,
        nameController.text)) {
      return;
    }
    viewModel.registerRequest(emailController.text, passwordController.text,
        nameController.text, context);
  }
}
