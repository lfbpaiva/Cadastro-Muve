import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../routes.dart';

class RegisterClientScreen extends StatefulWidget {
  const RegisterClientScreen({super.key});

  @override
  State<RegisterClientScreen> createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
  String tipoPessoa = "Pessoa Física";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.purple.shade900,
              Colors.purple.shade800,
              Colors.purple.shade400,
            ],
          ),
        ),
        child: Column(
          children: [
            // Parte roxa (gradient) que ocupa o topo
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Image.asset(
                      'assets/images/muvelogo.png',
                      height: 250,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: const Text(
                      "Cadastro de Contratante",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
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

            // Parte branca (inputs) que ocupa o resto
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      // Nome
                      _buildInputField(
                        hint: "Nome completo",
                        icon: Icons.person,
                        delay: 1400,
                      ),
                      const SizedBox(height: 20),

                      // E-mail (novo campo)
                      _buildInputField(
                        hint: "E-mail",
                        icon: Icons.email,
                        delay: 1450,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),

                      // Telefone
                      _buildInputField(
                        hint: "Telefone para autenticação",
                        icon: Icons.phone,
                        delay: 1500,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),

                      // Dropdown Pessoa Física/Jurídica
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
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
                          child: DropdownButton<String>(
                            value: tipoPessoa,
                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                            items: <String>["Pessoa Física", "Pessoa Jurídica"]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: const TextStyle(color: Colors.black)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                tipoPessoa = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // CPF ou CNPJ
                      if (tipoPessoa == "Pessoa Física")
                        _buildInputField(
                          hint: "CPF",
                          icon: Icons.badge,
                          delay: 1700,
                          keyboardType: TextInputType.number,
                        ),
                      if (tipoPessoa == "Pessoa Jurídica") ...[
                        _buildInputField(
                          hint: "CNPJ",
                          icon: Icons.business,
                          delay: 1700,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          hint: "Razão Social",
                          icon: Icons.badge,
                          delay: 1800,
                        ),
                      ],

                      const SizedBox(height: 30),

                      // Botão Registrar
                      FadeInUp(
                        duration: const Duration(milliseconds: 1900),
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
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
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
