import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const JwetMoKache());

class JwetMoKache extends StatelessWidget {
  const JwetMoKache({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EkranJwet(),
    );
  }
}

class EkranJwet extends StatefulWidget {
  const EkranJwet({super.key});

  @override
  State<EkranJwet> createState() => _EkranJwetState();
}

class _EkranJwetState extends State<EkranJwet> {
  final List<Map<String, String>> lisMo = [
    {"mo": "CHÈZ", "endis": "Mwen gen kat pye, men mwen pa ka mache. Ou chita sou mwen."},
    {"mo": "DLO", "endis": "Ou bwè m lè w swaf, ou lave kò w avè m."},
    {"mo": "SOLÈY", "endis": "Mwen klere lajounen, men mwen kache lannwit."},
    {"mo": "PEN", "endis": "Moun renmen manje m nan maten ak kafe."},
    {"mo": "LIV", "endis": "Ou ouvri m pou w li istwa oubyen pou w aprann."},
    {"mo": "PLIM", "endis": "Ou kenbe m nan men w pou w ekri sa w panse."},
    {"mo": "KREMA", "endis": "Bwason dous ayisyen ki gen lèt ak kòk."},
  ];

  late String moKache;
  late String endis;
  List<String> letYoJwenn = [];
  int chans = 5;

  @override
  void initState() {
    super.initState();
    rekomanse();
  }

  void rekomanse() {
    setState(() {
      final random = Random();
      final chwa = lisMo[random.nextInt(lisMo.length)];
      moKache = chwa["mo"]!;
      endis = chwa["endis"]!;
      letYoJwenn = [];
      chans = 5;
    });
  }

  void tchekeLet(String let) {
    if (letYoJwenn.contains(let) || chans <= 0) return;

    setState(() {
      if (moKache.contains(let)) {
        letYoJwenn.add(let);
      } else {
        chans--;
      }
    });

    if (chans <= 0) {
      voyeSouEkranFinal("Ou Pèdi! Mo a te : $moKache");
    } else if (moKache.split('').every((l) => letYoJwenn.contains(l))) {
      voyeSouEkranFinal("Bravo! Ou Genyen!");
    }
  }

  void voyeSouEkranFinal(String mesaj) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EkranFinal(
          mesaj: mesaj,
          onRejoue: () {
            rekomanse();
          },
        ),
      ),
    );
  }

  Widget batiBoutonLet(String let) {
    bool dejaPeze = letYoJwenn.contains(let);
    return Expanded(
      child: GestureDetector(
        onTap: dejaPeze ? null : () => tchekeLet(let),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          height: 45,
          decoration: BoxDecoration(
            color: dejaPeze ? Colors.grey[400] : Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 1)
            ],
          ),
          child: Center(
            child: Text(
              let,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: dejaPeze ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String moPouAfiche = "";
    for (int i = 0; i < moKache.length; i++) {
      String let = moKache[i];
      moPouAfiche += letYoJwenn.contains(let) ? "$let " : "* ";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Chans ki rete : $chans"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(endis, 
              textAlign: TextAlign.center, 
              style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 18)),
          ),
          const Spacer(),
          Text(moPouAfiche, 
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            color: Colors.grey[300],
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: "QWERTYUIOP".split('').map((l) => batiBoutonLet(l)).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: "ASDFGHJKL".split('').map((l) => batiBoutonLet(l)).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.arrow_upward, size: 20),
                    ),
                    ... "ZXCVBNM".split('').map((l) => batiBoutonLet(l)).toList(),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.backspace_outlined, size: 20),
                    ),
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

class EkranFinal extends StatelessWidget {
  final String mesaj;
  final VoidCallback onRejoue;
  const EkranFinal({super.key, required this.mesaj, required this.onRejoue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.blueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mesaj, 
              textAlign: TextAlign.center, 
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
              onPressed: () {
                onRejoue();
                Navigator.pop(context);
              },
              child: const Text("REJOUE AK YON LÒT MO"),
            ),
          ],
        ),
      ),
    );
  }
}