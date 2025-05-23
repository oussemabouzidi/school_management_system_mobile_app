import 'package:circular_gradient_spinner/circular_gradient_spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/controller/login_controller.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controllers for the text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController loginController = Get.put(LoginController());

  // Selected role: 0 for élève, 1 for parent
  int _selectedRole = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF4A90E2),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF4A90E2),
          secondary: Color(0xFF67B0F9),
          background: Color(0xFFF9FAFC),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: Color(0xFFF9FAFC),
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFEAF3FC),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App Logo/Branding
                  SizedBox(height: 40),
                  Image.asset(
                    'images/logo_home_page.png',
                    width: 180,
                    height: 180,
                  ),
                  SizedBox(height: 5),

                  Text(
                    "ISE Collège Lycée",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A90E2),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Connectez-vous à votre compte",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF67B0F9),
                    ),
                  ),
                  SizedBox(height: 40),

                  // Role Selection
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Color(0xFF4A90E2),
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Choisissez votre profil',
                                  style: TextStyle(
                                    color: Color(0xFF2D3142),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Role selection buttons
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedRole = 0;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      color: _selectedRole == 0
                                          ? Color(0xFF4A90E2)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: _selectedRole == 0
                                            ? Color(0xFF4A90E2)
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 32,
                                          height: 32,
                                          child:
                                              Image.asset('images/eleve.png'),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Élève',
                                          style: TextStyle(
                                            color: _selectedRole == 0
                                                ? Colors.white
                                                : Color(0xFF2D3142),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedRole = 1;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      color: _selectedRole == 1
                                          ? Color(0xFF4A90E2)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: _selectedRole == 1
                                            ? Color(0xFF4A90E2)
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 32,
                                          height: 32,
                                          child:
                                              Image.asset('images/parent.png'),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Parent',
                                          style: TextStyle(
                                            color: _selectedRole == 1
                                                ? Colors.white
                                                : Color(0xFF2D3142),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // Login Form
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.login,
                                color: Color(0xFF2D3142),
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Connexion',
                                  style: TextStyle(
                                    color: Color(0xFF2D3142),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Username field
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              hintText: _selectedRole == 0
                                  ? ' Email élève'
                                  : ' Email parent',
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              prefixIcon: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(Icons.person, color: Colors.purple),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.purple),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),

                        // Password field
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: ' Mot de passe',
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              prefixIcon: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(Icons.key, color: Colors.green),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),

                        Obx(() {
                          return loginController.isLoading.value
                              ? CircularGradientSpinner(
                                  color: Colors.blue,
                                  size: 50,
                                  strokeWidth: 20,
                                )
                              :
                              // Login button
                              Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        // Here you would handle the login logic
                                        print(
                                            'Role: ${_selectedRole == 0 ? "Élève" : "Parent"}');
                                        print(
                                            'Username: ${_usernameController.text}');
                                        print(
                                            'Password: ${_passwordController.text}');

                                        String email = _usernameController.text;
                                        String password =
                                            _passwordController.text;
                                        if (email.isEmpty || password.isEmpty) {
                                          Get.snackbar(
                                            'Erreur',
                                            'Veuillez remplir tous les champs.',
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.white,
                                            backgroundColor: Colors.redAccent
                                                .withOpacity(0.7),
                                          );
                                          loginController.isLoading.value =
                                              false;
                                          return;
                                        }
                                        loginController.isLoading.value = true;

                                        try {
                                          await loginController.fetchUser(
                                              email: email, pwd: password);

                                          if (!loginController.hasError.value &&
                                              loginController.user.id != 0) {
                                            // Success: Navigate to /wrapper
                                            print(
                                                'Role: ${loginController.user.role}');

                                            Get.offNamed(
                                                '/wrapper'); // Or pass role/id if needed
                                          } else {
                                            // Failed: show snackbar
                                            Get.snackbar(
                                              'Échec de la connexion',
                                              loginController
                                                  .errorMessage.value,
                                              snackPosition: SnackPosition.TOP,
                                              colorText: Colors.white,
                                              backgroundColor: Colors.redAccent
                                                  .withOpacity(0.7),
                                            );
                                            loginController.isLoading.value =
                                                false;
                                          }
                                        } catch (e) {
                                          Get.snackbar(
                                            'Erreur',
                                            'Une erreur inattendue est survenue.',
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.white,
                                            backgroundColor: Colors.redAccent
                                                .withOpacity(0.7),
                                          );
                                          loginController.isLoading.value =
                                              false;
                                        } finally {
                                          loginController.isLoading.value =
                                              false;
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF4A90E2),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        'Se connecter',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                        }),
                        // Forgot password link
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextButton(
                            onPressed: () {
                              // Handle forgot password
                            },
                            child: Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(
                                color: Color(0xFF67B0F9),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
