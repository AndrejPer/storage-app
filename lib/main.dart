import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storage App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _selectedIndex = 0;

  static final List<_TabConfig> _tabs = <_TabConfig>[
    const _TabConfig(
      label: 'Log',
      icon: Icons.camera_alt_outlined,
      selectedIcon: Icons.camera_alt,
      child: _LogScreen(),
    ),
    const _TabConfig(
      label: 'Check',
      icon: Icons.find_in_page_outlined,
      selectedIcon: Icons.find_in_page,
      child: _PlaceholderScreen(title: 'Check'),
    ),
    const _TabConfig(
      label: 'Settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      child: _PlaceholderScreen(title: 'Settings'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _TabConfig current = _tabs[_selectedIndex];

    return Scaffold(
      appBar: AppBar(title: Text(current.label)),
      body: current.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: _tabs
            .map(
              (tab) => NavigationDestination(
                icon: Icon(tab.icon),
                selectedIcon: Icon(tab.selectedIcon),
                label: tab.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _TabConfig {
  const _TabConfig({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.child,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget child;
}

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.widgets_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text('$title screen', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Placeholder content.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _LogScreen extends StatefulWidget {
  const _LogScreen();

  @override
  State<_LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<_LogScreen> {
  XFile? pickedFile;
  final ImagePicker picker = ImagePicker();

  Future<void> _takePicture() async {
    // Implementation will go here
  }

  Future<void> _selectFromGallery() async {
    final file = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedFile = file;
    });

    if (pickedFile == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No image selected yet.')));
    } else {
      // File imageFile = File(pickedFile!.path);
      // Use the image file as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (pickedFile != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.file(File(pickedFile!.path), fit: BoxFit.contain),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No image selected'),
            ),
          ElevatedButton(
            onPressed: _takePicture,
            child: const Text('Take Picture'),
          ),
          ElevatedButton(
            onPressed: _selectFromGallery,
            child: const Text('Select from Gallery'),
          ),
        ],
      ),
    );
  }
}
