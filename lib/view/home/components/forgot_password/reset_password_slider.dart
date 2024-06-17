import 'package:eshop/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final String email;

  ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  void resetPassword(BuildContext context) async {
    String otp = otpController.text.trim();
    String newPassword = newPasswordController.text.trim();
    var url = Uri.parse('$baseUrl/reset');
    var response = await http.post(url, body: {'email': email, 'otp': otp, 'newPassword': newPassword});

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset successfully')),
      );
      Navigator.pushReplacementNamed(context, '/home');  // Đóng màn hình reset password sau khi thành công
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reset password: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: otpController,
              decoration: InputDecoration(labelText: 'OTP'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => resetPassword(context),
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
