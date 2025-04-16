import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  /*
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final Function() togglePasswordVisibility;
  final Function() onForgotPassword;
  final Function(String, String) onLogin;*/

  /*const Login({
    Key? key,
     this.usernameController,
    required this.passwordController,
    required this.obscurePassword,
    required this.togglePasswordVisibility,
    required this.onForgotPassword,
    required this.onLogin,
  }) : super(key: key);*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Stack(children: [
        // Background Image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'), // Or NetworkImage
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Background image
                  Image.asset(
                    'images/login_effect.png',
                    //width: 500,
                    height: 50,
                    fit: BoxFit.cover,
                  ),

                  // Foreground image
                  Image.asset(
                    'images/person_set.png',
                    //width: 300,
                    height: 150,
                  ),
                ],
              ),
              Container(
                child: Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Text("Connecter vous",
                            style: TextStyle(
                                color: Color(0XFF124388),
                                fontSize: 40,
                                fontWeight: FontWeight.bold)),
                        Text("Bienvenue",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Identifiant',
                                style: TextStyle(
                                  color: Color(0xFF1A5297),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: 'Entrer votre identifiant',
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.person_outline),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Mot de passe',
                                style: TextStyle(
                                  color: Color(0xFF1A5297),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: '••••••••',
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(Icons.key),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.visibility_off),
                                      onPressed: () {},
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Mot de passe oublié?',
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFFF9D976), // gold/yellow
                                      const Color(0xFF6BBBF7), // blue
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Se connecter',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "ou continuer avec",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500]),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 140, top: 30),
                          child: Row(
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0XFF4CAF50).withOpacity(0.4),
                                ),
                                child: Image.asset("images/google.png"),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0XFF0A66C2).withOpacity(0.40),
                                ),
                                child: Image.asset("images/fb.png"),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
