import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../routes.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // gradiente visível até o topo
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.registerChoice);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            // herda exatamente do LoginScreen
            colors: [
              Colors.purple.shade900,
              Colors.purple.shade800,
              Colors.purple.shade400,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // mesma distância da logo no LoginScreen
            const SizedBox(height: 20),

            /// LOGO (mesma posição/tamanho do LoginScreen)
            Center(
              child: FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: Image.asset(
                  'assets/images/muvelogo.png',
                  height: 250, // igual ao LoginScreen
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// TÍTULOS (na mesma área do gradient)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                    duration: const Duration(milliseconds: 1300),
                    child: const Text(
                      "Cadastro de Usuário / Músico",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1300),
                    child: const Text(
                      "Preencha seus dados para continuar",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            /// CONTAINER BRANCO EXPANDIDO (ocupa o resto da tela)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 30),
                        _buildInputField(
                          hint: "Nome completo",
                          icon: Icons.person,
                          delay: 1400,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          hint: "Telefone para autenticação",
                          icon: Icons.phone,
                          delay: 1500,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          hint: "E-mail",
                          icon: Icons.email,
                          delay: 1600,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          hint: "Senha",
                          icon: Icons.lock,
                          delay: 1700,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 30),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1800),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, Routes.login);
                            },
                            height: 45,
                            color: Colors.purple[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Text(
                                "Registrar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 60), // respiro no fim
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String hint,
    required IconData icon,
    required int delay,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return FadeInUp(
      duration: Duration(milliseconds: delay),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(225, 95, 27, .3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            prefixIcon: Icon(icon, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
