import 'package:consultant_app/utils/SharedPref.dart';
import 'package:consultant_app/view/auth/register/RegisterVM.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/repositories/Auth/auth_api.dart';
import '../../../utils/Constants.dart';
import '../../../view_models/auth_view_model.dart';
import '../../widgets/Button.dart';
import '../../widgets/CustomText.dart';
import '../../widgets/SocialIcons.dart';
import '../../widgets/customTextField.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  AuthApi auth = AuthApi();
  AuthViewModel authModel = AuthViewModel();
  RegisterVM vm = RegisterVM(sharedPref: SharedPref());
  TextEditingController? controller_email = TextEditingController();
  TextEditingController? controller_pass = TextEditingController();
  TextEditingController? controller_confirm_pass = TextEditingController();
  TextEditingController? controller_userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (BuildContext context, snapshot) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            customTextField(
              authModel.emailTFHintText,
              false,
              controller: controller_email,
            ),
            const SizedBox(
              height: 8,
            ),
            customTextField(
              authModel.passTFHint,
              true,
              controller: controller_pass,
            ),
            const SizedBox(
              height: 8,
            ),
            customTextField(
              authModel.confirmPassTFHint,
              true,
              controller: controller_confirm_pass,
            ),
            const SizedBox(
              height: 8,
            ),
            customTextField(
              authModel.userNameTFHint,
              false,
              controller: controller_userName,
            ),
            const SizedBox(
              height: 15,
            ),
            Button(
              onPressed: () async {
                vm.registerRequest(controller_email!.text,
                    controller_pass!.text, controller_userName!.text, context);
              },
              title: authModel.signUpBtnText,
            ),
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
      );
    });
  }
}
