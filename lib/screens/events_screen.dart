import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)?.settings.arguments as Map?;
    return Scaffold(
      appBar: AppBar(title: const Text('Eventos')),
      body: Center(
        child: Text(
          event != null
              ? 'Você clicou em: ${event['title']}'
              : 'Lista geral de eventos',
        ),
      ),
    );
  }
}
