import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:flutter/material.dart';

class Registerpage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  final void Function()? ontap;
  void register(BuildContext context) {
    // get authservice
    AuthService _authservice = AuthService();
    if (_passwordcontroller.text == _confirmpasswordcontroller.text) {
      try {_authservice.signUp(
        Email: _emailcontroller.text,
        password: _passwordcontroller.text,
      );}
      catch(e){
        showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
      }
    }
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text("the Passwords don't match up!")),
      );
    }
  }

  new({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            //icon
            Icon(
              Icons.message,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 23),

            //welcoming text
            Text(
              "Connect",
              style: TextStyle(
                fontSize: 23,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 23),

            MyTextfield(
              hintText: "Email",
              isObscure: false,
              controller: _emailcontroller,
            ),
            SizedBox(height: 12),
            MyTextfield(
              hintText: "Password",
              isObscure: true,
              controller: _passwordcontroller,
            ),
            SizedBox(height: 12),
            MyTextfield(
              hintText: "Confirm Password",
              isObscure: true,
              controller: _confirmpasswordcontroller,
            ),

            SizedBox(height: 25),

            MyButton(text: "Register", ontap: ()=> register(context)),

            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: ontap,
                  child: Text(
                    "Login now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
