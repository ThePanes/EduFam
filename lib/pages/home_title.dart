import 'package:aplication_laboratorio/data/user_db.dart';
import 'package:aplication_laboratorio/pages/start_page.dart';
import 'package:flutter/material.dart';


class HomeTitle extends StatefulWidget {
  const HomeTitle({super.key});

  @override
  State<HomeTitle> createState() => _HomeTitleState();
}

class _HomeTitleState extends State<HomeTitle> {
  UserProfile? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final loadedUser = await UserDB.getUser();
    setState(() {
      user = loadedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        clipBehavior: Clip.antiAlias,
        title: Column(
          children: [
            Text("Edufam"),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Image.asset('assets/edufam.png', fit: BoxFit.cover, width: 100,)],
              ),
            ),
            const Icon(
              Icons.person,
              size: 80,
              color: Color.fromARGB(255, 24, 152, 215),
            ),
            const SizedBox(height: 16),
            Text(
              'Bienvenido, "${user?.nombre ?? "Usuario"}"',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StartPage()),
                );
              },
              child: const Text('Iniciar Sesion'),
            ),
          ],
        ),
      ),
    );
  }
}

