import 'package:consultant_app/view/auth/register/register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                'UserName', context.watch<RegisterVM>().nameError),
            _buildTextFormField(
                emailController,
                false,
                TextInputType.emailAddress,
                'Email',
                context.watch<RegisterVM>().emailError),
            _buildTextFormField(passwordController, true, TextInputType.text,
                'Password', context.watch<RegisterVM>().passwordError),
            _buildTextFormField(
                confirmPassController,
                true,
                TextInputType.text,
                'Confirm Password',
                context.watch<RegisterVM>().confirmPasswordError),
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

  Consumer<RegisterVM> _buildButton(BuildContext context) {
    return Consumer<RegisterVM>(builder: (_, viewModel, __) {
      return Button(
        onPressed: viewModel.isLoading
            ? null
            : () {
                if (!context.read<RegisterVM>().validateInputs(
                    emailController.text,
                    passwordController.text,
                    confirmPassController.text,
                    nameController.text)) {
                  return;
                }
                viewModel.registerRequest(emailController.text,
                    passwordController.text, nameController.text, context);
              },
        title: 'Sign Up',
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
}
