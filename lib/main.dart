import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.greenAccent),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _items = List<String>.generate(20, (i) => 'Halo ${i + 1}');

  @override
  Widget build(BuildContext context) {
    const destinations = <NavigationDestination>[
      NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
      NavigationDestination(icon: Icon(Icons.event), label: 'Acara'),
      NavigationDestination(icon: Icon(Icons.notifications), label: 'Notifikasi'),
      NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaptive Design'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.greenAccent,
      ),
      body: Stack(
        children: [
          AdaptiveScaffold(
            useDrawer: false,
            selectedIndex: _selectedIndex,
            onSelectedIndexChange: (i) => setState(() => _selectedIndex = i),
            destinations: destinations,
            smallBody: (_) => _FeedGrid(cols: 1, items: _items),
            body: (context) {
              final width = MediaQuery.of(context).size.width;
              final cols = width < 905 ? 2 : 3;
              return _FeedGrid(cols: cols, items: _items);
            },
          ),
          Positioned(
            bottom: 120,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
              tooltip: 'Tambah',
              backgroundColor: Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedGrid extends StatelessWidget {
  const _FeedGrid({required this.cols, required this.items});
  final int cols;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: cols == 1 ? 5 : 3 / 2,
      ),
      itemBuilder: (_, i) => Card(
        elevation: 2,
        child: Center(
          child: Text(
            items[i],
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}