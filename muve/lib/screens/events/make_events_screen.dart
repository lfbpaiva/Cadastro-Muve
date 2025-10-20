// lib/screens/events/make_events_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:muve/theme/app_theme.dart' as theme;

class MakeEventsScreen extends StatefulWidget {
  const MakeEventsScreen({super.key});

  @override
  State<MakeEventsScreen> createState() => _MakeEventsScreenState();
}

class _MakeEventsScreenState extends State<MakeEventsScreen> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _localController = TextEditingController();
  final _dataController = TextEditingController();
  final _horaController = TextEditingController();
  final _categoriaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final gradient = theme.AppTheme.mainGradient;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 22, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Publicar Novo Evento',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildField(
                  controller: _tituloController,
                  hint: 'Título do Evento',
                  icon: Icons.event,
                ),
                _buildField(
                  controller: _descricaoController,
                  hint: 'Descrição do Evento',
                  icon: Icons.description_outlined,
                  maxLines: 3,
                ),
                _buildField(
                  controller: _localController,
                  hint: 'Localização',
                  icon: Icons.place_outlined,
                ),
                _buildField(
                  controller: _dataController,
                  hint: 'Data (Ex.: 25/09/2025)',
                  icon: Icons.calendar_month_outlined,
                ),
                _buildField(
                  controller: _horaController,
                  hint: 'Horário (Ex.: 19h às 23h)',
                  icon: Icons.access_time,
                ),
                _buildField(
                  controller: _categoriaController,
                  hint: 'Categoria / Estilo',
                  icon: Icons.style_outlined,
                ),
                const SizedBox(height: 30),

                // BOTÃO DE PUBLICAR
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (_tituloController.text.isEmpty ||
                          _horaController.text.isEmpty ||
                          _localController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Preencha os campos obrigatórios'),
                          ),
                        );
                        return;
                      }

                      final novoEvento = {
                        'titulo': _tituloController.text,
                        'descricao': _descricaoController.text,
                        'local': _localController.text,
                        'data': _dataController.text,
                        'hora': _horaController.text,
                        'categoria': _categoriaController.text,
                      };

                      // POST no backend
                      final resp = await http.post(
                        Uri.parse('http://localhost:3000/eventos'),
                        headers: {'Content-Type': 'application/json'},
                        body: jsonEncode(novoEvento),
                      );

                      if (resp.statusCode == 201) {
                        final eventoCriado = jsonDecode(resp.body);
                        Navigator.pop(
                          context,
                          eventoCriado,
                        ); // devolve já do banco
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Erro ao publicar evento: ${resp.body}',
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.check, color: Colors.white),
                    label: const Text(
                      'Publicar Evento',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(106, 27, 154, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // BOTÃO DE CANCELAR
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                    label: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white),
          prefixIcon: Icon(icon, color: Colors.black),
          filled: true,
          fillColor: const Color.fromRGBO(220, 176, 255, 1),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
