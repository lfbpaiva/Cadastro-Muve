import 'package:flutter/material.dart';
import '../theme/app_theme.dart' as theme;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        child: const _BottomBar(),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _TabsHeader(),
                SizedBox(height: 12),
                _ComposerCard(),
                SizedBox(height: 12),
                _PostCardPatrocinado(),
                _PostDivider(),
                _PostCardBanda(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabsHeader extends StatelessWidget {
  const _TabsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Para você',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Seguindo',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComposerCard extends StatelessWidget {
  const _ComposerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'O que está acontecendo?',
                    style: TextStyle(color: Colors.white.withOpacity(0.85)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _PillButton(label: 'Postar', onTap: () {}),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              _ComposerIcon(icon: Icons.image_outlined),
              _ComposerIcon(icon: Icons.gif_box_outlined),
              _ComposerIcon(icon: Icons.emoji_emotions_outlined),
            ],
          ),
        ],
      ),
    );
  }
}

class _PostCardPatrocinado extends StatelessWidget {
  const _PostCardPatrocinado();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Avatar(), // avatar nos posts permanece
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'musico123',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const _MuveBadge(),
                        const Spacer(),
                        Icon(Icons.more_horiz, color: Colors.white.withOpacity(0.85)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text('há 2 h',
                        style: TextStyle(color: Colors.white.withOpacity(0.7))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Lançamento do meu single!',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 8),
          Text('Patrocinado',
              style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
          const SizedBox(height: 10),
          const _AudioPlayerMock(),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.thumb_up_alt_outlined,
                  color: Colors.white.withOpacity(0.9), size: 20),
              const SizedBox(width: 6),
              Text('Curtir', style: TextStyle(color: Colors.white.withOpacity(0.9))),
              const SizedBox(width: 18),
              Icon(Icons.mode_comment_outlined,
                  color: Colors.white.withOpacity(0.9), size: 20),
              const SizedBox(width: 6),
              Text('Comentar', style: TextStyle(color: Colors.white.withOpacity(0.9))),
            ],
          ),
        ],
      ),
    );
  }
}

class _PostCardBanda extends StatelessWidget {
  const _PostCardBanda();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Avatar(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'bandaXYZ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const _MuveBadge(),
                        const Spacer(),
                        Icon(Icons.more_horiz, color: Colors.white.withOpacity(0.85)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text('há 3 h',
                        style: TextStyle(color: Colors.white.withOpacity(0.7))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Clipe novo',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 12),
          const _MediaTile.big(showPlay: true),
        ],
      ),
    );
  }
}

class _PostDivider extends StatelessWidget {
  const _PostDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.white.withOpacity(0.15),
    );
  }
}


class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Image.asset(
        'assets/images/muvelogo.png',
        height: 44,
        width: 44,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _MuveBadge extends StatelessWidget {
  const _MuveBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: const Text(
        'M',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _ComposerIcon extends StatelessWidget {
  final IconData icon;
  const _ComposerIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Icon(icon, color: Colors.white.withOpacity(0.9)),
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PillButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFF4A148C), Color(0xFF6A1B9A)],
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _AudioPlayerMock extends StatelessWidget {
  const _AudioPlayerMock();

  @override
  Widget build(BuildContext context) {
    final labelStyle =
    TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white24,
                ),
                child: Icon(Icons.play_arrow,
                    color: Colors.white.withOpacity(0.95)),
              ),
              const SizedBox(width: 12),
              // waveform compacto
              const Expanded(child: _WaveformBars(height: 40)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text('0:00', style: labelStyle),
              const SizedBox(width: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.4,
                    minHeight: 6,
                    backgroundColor: Colors.white.withOpacity(0.15),
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(0.9)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text('0:30', style: labelStyle),
            ],
          ),
        ],
      ),
    );
  }
}

class _WaveformBars extends StatelessWidget {
  final double height;
  const _WaveformBars({this.height = 56});

  @override
  Widget build(BuildContext context) {
    final bars = [
      8, 16, 24, 34, 50, 36, 26, 18, 12, 20, 30, 44, 54, 44, 30, 20, 12, 18, 26,
      36, 50, 34, 24, 16, 8
    ];
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: bars
            .map(
              (h) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                height: (h.toDouble() * (height / 56)),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}

class _MediaTile extends StatelessWidget {
  final bool big;
  final bool showPlay;
  const _MediaTile.big({this.showPlay = true}) : big = true;
  const _MediaTile.small({this.showPlay = true}) : big = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: big ? 4 / 3 : 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: Colors.white.withOpacity(0.08)),
            Image.asset('assets/images/muvelogo.png', fit: BoxFit.cover),
            if (showPlay)
              Center(
                child: Icon(Icons.play_circle_fill,
                    color: Colors.white.withOpacity(0.95),
                    size: big ? 56 : 36),
              ),
          ],
        ),
      ),
    );
  }
}

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

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: const Color(0xFF2D124E).withOpacity(0.92),
      notchMargin: 8,
      child: SizedBox(
        height: 76,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            _NavItem(icon: Icons.event, label: 'Eventos'),
            _NavItem(icon: Icons.search, label: 'Buscar'),
            SizedBox(width: 56), // espaço do FAB central
            _NavItem(icon: Icons.chat_bubble_outline, label: 'Messages'),
            _NavItem(icon: Icons.person_outline, label: 'Perfil'),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.95)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.95))),
      ],
    );
  }
}
