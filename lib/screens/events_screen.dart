import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:muve/theme/app_theme.dart' as theme;
import '../routes.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gradient = theme.AppTheme.mainGradient;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const _MuveFab(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
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
                _EventsHeader(),
                SizedBox(height: 40), // mais distância entre título e carrossel
                _EventsCarousel(), // carrossel com células fixas
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* =================== HEADER =================== */

class _EventsHeader extends StatelessWidget {
  const _EventsHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: Text(
          'Shows em destaque',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

/* =================== CARROSSEL =================== */

class _EventsCarousel extends StatelessWidget {
  const _EventsCarousel();

  @override
  Widget build(BuildContext context) {
    final events = [
      {
        'title': 'Imagine Dragons',
        'image': 'assets/images/images_events_screen/imagine-dragons_image.jpg'
      },
      {
        'title': 'Linkin Park',
        'image': 'assets/images/images_events_screen/linkin-park_image.png'
      },
      {
        'title': 'Marshmallow',
        'image': 'assets/images/images_events_screen/marshmallow_image.jpg'
      },
      {
        'title': 'Orchestra',
        'image': 'assets/images/images_events_screen/orchestra_image.jpg'
      },
      {
        'title': 'Péricles',
        'image': 'assets/images/images_events_screen/pericles_image.jpg'
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: events.map((event) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: 130, // largura fixa do cartão
              height: 170, // altura fixa do cartão
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        event['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event['title']!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/* =================== COMPONENTES REUTILIZÁVEIS =================== */

class _MuveFab extends StatelessWidget {
  const _MuveFab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      width: 66,
      child: FloatingActionButton(
        onPressed: () {},
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

/// Bottom bar com SafeArea interno e altura folgada
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

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.profile),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Image.asset(
          'assets/images/muvelogo.png',
          height: 44,
          width: 44,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
