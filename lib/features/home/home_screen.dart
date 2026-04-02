import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/demo/demo_routes.dart';
import '../../data/models/route_model.dart';
import '../../data/repositories/favorites_repository.dart';
import '../routes/route_detail_screen.dart';

enum _HomeTierFilter {
  highlight,
  teaser,
  standard,
  premium,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FavoritesRepository favoritesRepo = FavoritesRepository();
  final TextEditingController searchController = TextEditingController();

  _HomeTierFilter currentTierFilter = _HomeTierFilter.highlight;
  String currentDurationFilter = 'Alle';
  String currentCityFilter = 'Alle';
  String currentThemeFilter = 'Alle';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<RouteModel> get _filteredRoutes {
    final query = searchController.text.trim();

    Iterable<RouteModel> routes = demoRoutes;

    if (currentTierFilter != _HomeTierFilter.highlight) {
      routes = routes.where((route) {
        switch (currentTierFilter) {
          case _HomeTierFilter.highlight:
            return true;
          case _HomeTierFilter.teaser:
            return route.tier == RouteTier.teaser;
          case _HomeTierFilter.standard:
            return route.tier == RouteTier.standard;
          case _HomeTierFilter.premium:
            return route.tier == RouteTier.premium;
        }
      });
    }

    if (currentDurationFilter != 'Alle') {
      routes =
          routes.where((route) => route.durationLabel == currentDurationFilter);
    }

    if (currentCityFilter != 'Alle') {
      routes = routes.where((route) => route.city == currentCityFilter);
    }

    if (currentThemeFilter != 'Alle') {
      routes = routes.where((route) => route.focus == currentThemeFilter);
    }

    routes = routes.where((route) => route.matchesQuery(query));

    final list = routes.toList();

    if (currentTierFilter == _HomeTierFilter.highlight &&
        query.isEmpty &&
        currentDurationFilter == 'Alle' &&
        currentCityFilter == 'Alle' &&
        currentThemeFilter == 'Alle') {
      return list.take(4).toList();
    }

    return list;
  }

  List<String> get _durationOptions {
    final values =
        demoRoutes.map((e) => e.durationLabel).toSet().toList()..sort();
    return ['Alle', ...values];
  }

  List<String> get _cityOptions {
    final values = demoRoutes.map((e) => e.city).toSet().toList()..sort();
    return ['Alle', ...values];
  }

  List<String> get _themeOptions {
    final values = demoRoutes.map((e) => e.focus).toSet().toList()..sort();
    return ['Alle', ...values];
  }

  bool get _hasActiveFilters {
    return currentDurationFilter != 'Alle' ||
        currentCityFilter != 'Alle' ||
        currentThemeFilter != 'Alle';
  }

  int get _activeFilterCount {
    int count = 0;
    if (currentCityFilter != 'Alle') count++;
    if (currentDurationFilter != 'Alle') count++;
    if (currentThemeFilter != 'Alle') count++;
    return count;
  }

  Future<void> _shareRoute(RouteModel route) async {
    final shareText =
        'Spurenwege – ${route.title}\n${route.city} • ${route.durationLabel}\n${route.shortDescription}';

    await Clipboard.setData(ClipboardData(text: shareText));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Routeninfo zu "${route.title}" in die Zwischenablage kopiert.'),
      ),
    );
  }

  void _toggleFavorite(RouteModel route) {
    setState(() {
      favoritesRepo.toggleRouteFavorite(route.id);
    });
  }

  String get _sectionTitle {
    switch (currentTierFilter) {
      case _HomeTierFilter.highlight:
        return 'Erste Spuren';
      case _HomeTierFilter.teaser:
        return 'Teaser-Routen';
      case _HomeTierFilter.standard:
        return 'Standard-Routen';
      case _HomeTierFilter.premium:
        return 'Premium-Routen';
    }
  }

  Future<void> _openFilterPanel() async {
    String tempCity = currentCityFilter;
    String tempDuration = currentDurationFilter;
    String tempTheme = currentThemeFilter;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF121821),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 44,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Filter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Wähle Ort, Dauer und Thema für passende Routen.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _SheetDropdown(
                      label: 'Ort',
                      value: tempCity,
                      options: _cityOptions,
                      onChanged: (value) {
                        setModalState(() {
                          tempCity = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _SheetDropdown(
                      label: 'Dauer',
                      value: tempDuration,
                      options: _durationOptions,
                      onChanged: (value) {
                        setModalState(() {
                          tempDuration = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _SheetDropdown(
                      label: 'Thema',
                      value: tempTheme,
                      options: _themeOptions,
                      onChanged: (value) {
                        setModalState(() {
                          tempTheme = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                currentCityFilter = 'Alle';
                                currentDurationFilter = 'Alle';
                                currentThemeFilter = 'Alle';
                              });
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(color: Color(0xFF2A3644)),
                            ),
                            child: const Text('Zurücksetzen'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                currentCityFilter = tempCity;
                                currentDurationFilter = tempDuration;
                                currentThemeFilter = tempTheme;
                              });
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F8CFF),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text('Anwenden'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _resetAll() {
    setState(() {
      searchController.clear();
      currentTierFilter = _HomeTierFilter.highlight;
      currentDurationFilter = 'Alle';
      currentCityFilter = 'Alle';
      currentThemeFilter = 'Alle';
    });
  }

  @override
  Widget build(BuildContext context) {
    final routes = _filteredRoutes;
    final hasActiveSearch = searchController.text.trim().isNotEmpty ||
        _hasActiveFilters ||
        currentTierFilter != _HomeTierFilter.highlight;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
              decoration: BoxDecoration(
                color: const Color(0xFF121821),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF1C2430)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF26384B),
                          Color(0xFF1A2633),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFF3A4D63)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Spurenwege',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 31,
                            fontWeight: FontWeight.w900,
                            height: 1.0,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(height: 6),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'wenn Orte erzählen',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.3,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Verborgene Wege, gespürte Orte und Routen, die ihre Ziele erst nach und nach preisgeben.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D131A),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFF1A2230)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.white54,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              hintText: 'Suche...',
                              hintStyle: TextStyle(
                                color: Colors.white54,
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _openFilterPanel,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Color(0xFF2A3644)),
                            backgroundColor: const Color(0xFF0F141C),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          icon: const Icon(Icons.tune, size: 18),
                          label: Text(
                            _activeFilterCount > 0
                                ? 'Filter ($_activeFilterCount)'
                                : 'Filter',
                          ),
                        ),
                      ),
                      if (_hasActiveFilters) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              currentCityFilter = 'Alle';
                              currentDurationFilter = 'Alle';
                              currentThemeFilter = 'Alle';
                            });
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFF0F141C),
                            side: const BorderSide(color: Color(0xFF2A3644)),
                          ),
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white70,
                            size: 18,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _TierChip(
                          label: 'Highlights',
                          selected:
                              currentTierFilter == _HomeTierFilter.highlight,
                          onTap: () {
                            setState(() {
                              currentTierFilter = _HomeTierFilter.highlight;
                            });
                          },
                        ),
                        _TierChip(
                          label: 'Teaser',
                          selected: currentTierFilter == _HomeTierFilter.teaser,
                          onTap: () {
                            setState(() {
                              currentTierFilter = _HomeTierFilter.teaser;
                            });
                          },
                        ),
                        _TierChip(
                          label: 'Standard',
                          selected:
                              currentTierFilter == _HomeTierFilter.standard,
                          onTap: () {
                            setState(() {
                              currentTierFilter = _HomeTierFilter.standard;
                            });
                          },
                        ),
                        _TierChip(
                          label: 'Premium',
                          selected:
                              currentTierFilter == _HomeTierFilter.premium,
                          onTap: () {
                            setState(() {
                              currentTierFilter = _HomeTierFilter.premium;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _sectionTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (hasActiveSearch)
                  TextButton(
                    onPressed: _resetAll,
                    child: const Text('Zurücksetzen'),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            if (_hasActiveFilters)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (currentCityFilter != 'Alle')
                      _ActiveFilterChip(label: 'Ort: $currentCityFilter'),
                    if (currentDurationFilter != 'Alle')
                      _ActiveFilterChip(label: 'Dauer: $currentDurationFilter'),
                    if (currentThemeFilter != 'Alle')
                      _ActiveFilterChip(label: 'Thema: $currentThemeFilter'),
                  ],
                ),
              ),
            if (routes.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF121821),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF1C2430)),
                ),
                child: const Text(
                  'Keine passende Route gefunden.',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ...routes.map(
              (route) => _RouteBannerCard(
                route: route,
                isFavorite: favoritesRepo.isRouteFavorite(route.id),
                onFavoriteTap: () => _toggleFavorite(route),
                onShareTap: () => _shareRoute(route),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteBannerCard extends StatelessWidget {
  final RouteModel route;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onShareTap;

  const _RouteBannerCard({
    required this.route,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onShareTap,
  });

  Color _tierColor(RouteTier tier) {
    switch (tier) {
      case RouteTier.teaser:
        return const Color(0xFF27415D);
      case RouteTier.standard:
        return const Color(0xFF3D3A1F);
      case RouteTier.premium:
        return const Color(0xFF4A2A56);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RouteDetailScreen(route: route),
          ),
        );
      },
      child: Container(
        height: 230,
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            image: AssetImage(route.startImage),
            fit: BoxFit.cover,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.78),
                Colors.black.withOpacity(0.18),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            border: Border.all(color: const Color(0xFF1C2430)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _tierColor(route.tier),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        route.tierLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: onFavoriteTap,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.redAccent : Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: onShareTap,
                      icon: const Icon(
                        Icons.ios_share,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  route.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  route.shortDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _MetaBadge(label: route.city),
                    _MetaBadge(label: route.durationLabel),
                    _MetaBadge(label: route.focus),
                    _MetaBadge(label: route.difficulty),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Stimmung: ${route.mood}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MetaBadge extends StatelessWidget {
  final String label;

  const _MetaBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.32),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ActiveFilterChip extends StatelessWidget {
  final String label;

  const _ActiveFilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF121821),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFF2A3644)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _TierChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TierChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: const Color(0xFF4F8CFF),
        backgroundColor: const Color(0xFF0F141C),
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.white70,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: const BorderSide(color: Color(0xFF1C2430)),
        ),
      ),
    );
  }
}

class _SheetDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  const _SheetDropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F141C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1C2430)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF121821),
          style: const TextStyle(color: Colors.white),
          iconEnabledColor: Colors.white70,
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(
                '$label: $option',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}