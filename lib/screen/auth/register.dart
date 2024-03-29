
import 'package:flutter/material.dart';
import 'package:flutter_loginui/screen/auth/decoration_funcion.dart';
import 'package:flutter_loginui/screen/auth/signup_bar.dart';
import 'package:flutter_loginui/screen/auth/title.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class Register extends StatelessWidget{
  const Register({Key key, this.onSignInPress}) : super(key : key);
  final VoidCallback onSignInPress;
  @override
  Widget build(BuildContext context) {
    final isSubmitting= context.isSubmitting();
    // TODO: implement build
    return SignInForm(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: LoginTitle(
                    title: 'Create \nAccount',
                  ),
                )),
            Expanded(
              flex: 4,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: EmailTextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                      decoration: registerInputDecoration(hintText: 'Email'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: PasswordTextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                      decoration: registerInputDecoration(hintText: 'Password'),
                    ),
                  ),
                  SignUpBar(
                    label: 'Sign Up',
                    isLoading: isSubmitting,
                    onPressed: (){
                      context.registerWithEmailAndPassword();
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        onSignInPress?.call();
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }

}