import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../routes.dart';

class SearchEventsScreen extends StatefulWidget {
  const SearchEventsScreen({Key? key}) : super(key: key);

  @override
  State<SearchEventsScreen> createState() => _SearchEventsScreenState();
}

class _SearchEventsScreenState extends State<SearchEventsScreen> {
  String searchedGenre = ''; // gênero pesquisado atual

  // eventos por gênero (simulado)
  final Map<String, List<Map<String, String>>> eventsByGenre = {
    'rock': [
      {
        'title': 'Rock na Casa',
        'image': 'assets/images/evento1.jpg',
        'style': 'Rock',
      },
      {
        'title': 'Rock Festival',
        'image': 'assets/images/evento4.jpg',
        'style': 'Rock',
      },
    ],
    'jazz': [
      {
        'title': 'Jazz Night',
        'image': 'assets/images/evento2.jpg',
        'style': 'Jazz',
      },
      {
        'title': 'Smooth Jazz',
        'image': 'assets/images/evento5.jpg',
        'style': 'Jazz',
      },
    ],
    'eletronica': [
      {
        'title': 'Eletrônica Party',
        'image': 'assets/images/evento3.jpg',
        'style': 'Eletrônica',
      },
    ],
  };

  // mapa de gêneros semelhantes
  final Map<String, List<String>> similarGenresMap = {
    'rock': ['jazz', 'eletronica'],
    'jazz': ['rock'],
    'eletronica': ['rock', 'jazz'],
  };

  @override
  Widget build(BuildContext context) {
    final mainEvents = eventsByGenre[searchedGenre.toLowerCase()] ?? [];
    final similarGenres = similarGenresMap[searchedGenre.toLowerCase()] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buscar eventos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppTheme.backgroundGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppTheme.backgroundGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              // barra de busca
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Digite o gênero (ex.: Rock, Jazz...)',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      searchedGenre = value.trim();
                    });
                  },
                ),
              ),
              if (searchedGenre.isNotEmpty)
                _buildCarousel(
                  context,
                  mainEvents,
                  'Eventos de $searchedGenre',
                ),
              for (var genre in similarGenres)
                _buildCarousel(
                  context,
                  eventsByGenre[genre] ?? [],
                  'Talvez você goste também de $genre',
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel(
    BuildContext context,
    List<Map<String, String>> events,
    String title,
  ) {
    if (events.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: events.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final event = events[index];
              return SizedBox(
                width: 150,
                child: Card(
                  color: Colors.white.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          event['image']!,
                          width: 150,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              event['style']!,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: Colors.white70,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 4,
                                      ),
                                      backgroundColor: AppTheme.primaryPurple,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.events,
                                        arguments: event,
                                      );
                                    },
                                    child: const Text(
                                      'Ver mais',
                                      style: TextStyle(fontSize: 9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
