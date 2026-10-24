import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AboutPage(),
    );
  }
}

class Feature {
  const Feature(this.title, this.icon);

  final String title;
  final IconData icon;
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const images = [
    'assets/images/cloud-storage.png',
    'assets/images/amazon-cloud.png',
    'assets/images/azure-cloud.png',
    'assets/images/cloudflare-cloud.png',
    'assets/images/google-cloud.png',
  ];

  static const features = [
    Feature('Удобный интерфейс', Icons.touch_app),
    Feature('Контроль доступа', Icons.lock),
    Feature('Бесплатно до 1ТБ', Icons.sd_storage),
    Feature('Синхронизация', Icons.sync),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cloud Storage',
          style: TextStyle(fontFamily: "PressStart2P", color: Colors.purple),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.login),
            tooltip: 'Авторизация',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Облачные хранилища',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Современный сервис для загрузки, скачивания и долгосрочного хранения любых типов файлов.'
                  'Защитите свои данные от утери, делитесь ссылками с друзьями и коллегами, и'
                  'синхронизируйте информацию между всеми своими устройствами в реальном времени.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    images[index],
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: features.length,
              itemBuilder: (context, index) {
                final feature = features[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(feature.icon, color: Colors.blue),
                    title: Text(feature.title),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(feature.title)));
                    },
                  ),
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, color: Colors.blue, size: 50),
                SizedBox(width: 16),
                Column(
                  children: [
                    Text(
                      'Плотников Максим Павлович',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text('ИКБО-60-23', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
