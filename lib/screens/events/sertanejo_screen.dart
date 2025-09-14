// lib/screens/events/sertanejo_screen.dart
import 'package:flutter/material.dart';
import 'package:muve/theme/app_theme.dart' as theme;
import '../../routes.dart';

class SertanejoScreen extends StatelessWidget {
  const SertanejoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gradient = theme.AppTheme.mainGradient;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          const _MuveFab(), // botão central que volta para home
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        // rodapé com botão eventos voltando para EventsScreen
        child: _BottomBar(
          onTapEvents: () {
            Navigator.pushReplacementNamed(context, Routes.events);
          },
          onTapSearch: null,
          onTapMessages: null,
          onTapProfileRoute: Routes.profile,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 22, 16, 160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _SertanejoHeader(),
                SizedBox(height: 30), // espaçamento extra abaixo do título
                _SertanejoBody(), // agora apenas o texto
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* =================== HEADER =================== */

class _SertanejoHeader extends StatelessWidget {
  const _SertanejoHeader();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Sertanejo',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/* =================== BODY CONTEÚDO =================== */

class _SertanejoBody extends StatelessWidget {
  const _SertanejoBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        'Encontre o modão que mais combina com você! Aqui você fica por dentro das melhores atrações de Sertanejo pelo Brasil!',
        textAlign: TextAlign.justify,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

/* =================== COMPONENTES REUTILIZÁVEIS =================== */

// botão central com logo do Muve que volta para Home
class _MuveFab extends StatelessWidget {
  const _MuveFab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      width: 66,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.home);
        },
        elevation: 4,
        backgroundColor: Colors.white.withOpacity(0.15),
        shape: const CircleBorder(),
        child: ClipOval(
          child: Image.asset('assets/images/muvelogo.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}

// rodapé igual das outras telas
class _BottomBar extends StatelessWidget {
  final VoidCallback? onTapEvents;
  final VoidCallback? onTapSearch;
  final VoidCallback? onTapMessages;
  final String? onTapProfileRoute;

  const _BottomBar({
    super.key,
    this.onTapEvents,
    this.onTapSearch,
    this.onTapMessages,
    this.onTapProfileRoute,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color(0xFF2D124E).withOpacity(0.92),
        notchMargin: 8,
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(icon: Icons.event, label: 'Eventos', onTap: onTapEvents),
              _NavItem(icon: Icons.search, label: 'Buscar', onTap: onTapSearch),
              const SizedBox(width: 84),
              _NavItem(
                icon: Icons.chat_bubble_outline,
                label: 'Messages',
                onTap: onTapMessages,
              ),
              _NavItem(
                icon: Icons.person_outline,
                label: 'Perfil',
                onTap: () {
                  if (onTapProfileRoute != null) {
                    Navigator.pushNamed(context, onTapProfileRoute!);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white.withOpacity(0.95), size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.95),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
