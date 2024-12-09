import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/features/authentication/controllers/login/login_controller.dart';
import 'package:leader_app/utils/constants/text_strings.dart';


import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            /// Email

            TextFormField(
              controller: controller.email,
              validator: (value)=>TValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail), labelText: TTexts.emailLogin),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Password
                Obx(
           ()=> TextFormField(
              validator: (value) => TValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration:  InputDecoration(
                  labelText: TTexts.passwordSignup,
                  prefixIcon: const Icon(Icons.key),
                  suffixIcon:IconButton(
                    onPressed: ()=> controller.hidePassword.value =!controller.hidePassword.value,
                    icon:  Icon ( controller.hidePassword.value? Icons.remove_red_eye : Icons.remove_red_eye_outlined))),
            ),
          ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember Me
                Row(
                  children: [
                    Obx(()=> Checkbox(
                      value: controller.rememberMe.value,
                       onChanged: (value) => controller.rememberMe.value =!controller.rememberMe.value),
                       ),
                    const Text(TTexts.rememberMeLogin),
                  ],
                ),

                /// Forget Password
                // TextButton(
                //     onPressed: () =>Get.to(()=>const ForgetPassword()),
                //     child: const Text(TTexts.forgetPasswordLogin)),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// Sign In Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: ()=>controller.emailAndPasswordsignIn(), child: const Text(TTexts.signinInLogin))),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            /// Create Account Button
            // SizedBox(
            //     width: double.infinity,
            //     child: OutlinedButton(
            //         onPressed: () => Get.to(() => const SignupScreen()),
            //         child: const Text(TTexts.createAccountLogin))),
          ],
        ),
      ),
    );
  }
}
