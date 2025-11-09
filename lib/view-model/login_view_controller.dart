import 'package:digital_marketing_assignment/constant/custom_snackbar.dart';
import 'package:digital_marketing_assignment/repo/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewController extends GetxController {
  final LoginRepo _api = LoginRepo();

  final mobileController = TextEditingController();
  final List<TextEditingController> otpControllers = List.generate(4, (_) => TextEditingController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  void onClose() {
    mobileController.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }


void clearLoginData() {
  for (var controller in otpControllers) {
    controller.clear(); // Clears the text inside each TextEditingController
  }
  mobileController.clear();
  update();
}

void loginApi(BuildContext context,{bool showSuccessPopup = false}) {
  String token="reqres-free-v1";
  Map<String, String> data = {
    'email': emailController.text,
    'password': passwordController.text,
  };

 _api.loginApi(data,authToken:token).then((value) {
  String successMessage = value['message'] ?? 'Operation successful';
  if (value['status'] == '200') {
    CustomSnackbar.showSnackbar(context, successMessage);
    Future.delayed(const Duration(seconds: 2), () {
      
    });
  } else {
    CustomSnackbar.showSnackbar(context,
      value['message'] ?? 'Something went wrong',
      isError: true,
    );
  }
}).catchError((error) {
  CustomSnackbar.showSnackbar(context,
    error.toString(),
    isError: true,
  );
});
}


}
