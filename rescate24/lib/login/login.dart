import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rescate24/components/my_button.dart';
import 'package:rescate24/components/my_text_field.dart';
import 'package:rescate24/components/social_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              SvgPicture.asset("lib/images/logoprincipal.svg"),
              const SizedBox(
                height: 50,
              ),
              MyTextField(
                  controller: usernameController,
                  hintText: "Correo electronico o numero de cedula",
                  obscureText: false,
                  startIcon: "lib/images/user_icon.svg"),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  controller: passwordController,
                  hintText: "Contrasenia",
                  obscureText: true,
                  startIcon: "lib/images/lock_icon.svg"),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/dashboard'),
                  child: MyButton(
                    title: 'Entrar',
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Olvido su contrasenia?",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const SocialButton(
                title: "Inicia sesion con Facebook",
                icon: "lib/images/facebook_icon.png",
                buttonColor: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              const SocialButton(
                title: "Inicia sesion con Google",
                icon: "lib/images/google_icon.png",
                buttonColor: Colors.blue,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "No tienes una cuenta?",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "REGISTRARSE",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Al ingresar aceptas los Terminos y condiciones del Servicio \n y las politicas de privacidad de Rescate 24",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
