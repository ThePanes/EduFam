import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aplication_laboratorio/data/user_db.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  Future<void> _editField(String field, String initialValue) async {
    final controller = TextEditingController(text: initialValue);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar $field'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: field),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    if (result != null && user != null) {
      final updatedUser = UserProfile(
        id: user!.id,
        nombre: field == 'Usuario' ? result : user!.nombre,
        correo: field == 'Correo' ? result : user!.correo,
        contrasena: field == 'Contraseña' ? result : user!.contrasena,
        direccion: field == 'Dirección' ? result : user!.direccion,
        telefono: field == 'Teléfono' ? result : user!.telefono,
        colegio: user!.colegio,
      );
      await UserDB.insertOrUpdateUser(updatedUser);
      setState(() {
        user = updatedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.person, size: 80, color: Colors.blueGrey),
                  Text('"${user!.nombre}"', style: const TextStyle(fontSize: 20)),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 30, color: Color.fromARGB(255, 196, 194, 191)),
                    onPressed: () => _editField('Usuario', user!.nombre),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("Correo Electronico: ${user!.correo}"),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 30, color: Color.fromARGB(255, 196, 194, 191)),
                        onPressed: () => _editField('Correo', user!.correo),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("Contraseña: ${user!.contrasena}"),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 30, color: Color.fromARGB(255, 196, 194, 191)),
                        onPressed: () => _editField('Contraseña', user!.contrasena),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("Direccion: ${user!.direccion}"),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 30, color: Color.fromARGB(255, 196, 194, 191)),
                        onPressed: () => _editField('Dirección', user!.direccion),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Text("Telefono: ${user!.telefono}"),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 30, color: Color.fromARGB(255, 196, 194, 191)),
                        onPressed: () => _editField('Teléfono', user!.telefono),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40, width: 350),
                      Text(user!.colegio),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
