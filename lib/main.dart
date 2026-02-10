import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      home: const EkranA(), 
    );
  }
}

class EkranA extends StatelessWidget {
  const EkranA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ekrn A : Connexion")),
      body: Center(
        child: ElevatedButton(
          child: const Text("konekte (Aller vers B)"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EkranB()),
            );
          },
        ),
      ),
    );
  }
}

class EkranB extends StatelessWidget {
  const EkranB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ekran B : Notes"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), 
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(" liste notes"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EkranC()),
                );
              },
              child: const Text("Modifier note"),
            ),
          ],
        ),
      ),
    );
  }
}

class EkranC extends StatelessWidget {
  const EkranC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ekran C : Edisyon")),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100),
          child: const Text("Anule "),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}