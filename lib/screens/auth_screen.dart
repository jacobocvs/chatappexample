import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import './chat_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  FocusNode? _focusNode;
  bool _loggingIn = false;
  TextEditingController? _passwordController;
  TextEditingController? _usernameController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _passwordController = TextEditingController(text: '');
    _usernameController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _passwordController?.dispose();
    _usernameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text('Login'),
    ),
    body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
        child: Column(
          children: [
            TextField(
              autocorrect: false,
              autofillHints: _loggingIn ? null : [AutofillHints.email],
              autofocus: true,
              controller: _usernameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                labelText: 'Correo',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () => _usernameController?.clear(),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              onEditingComplete: () {
                _focusNode?.requestFocus();
              },
              readOnly: _loggingIn,
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.next,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                autocorrect: false,
                autofillHints: _loggingIn ? null : [AutofillHints.password],
                controller: _passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () => _passwordController?.clear(),
                  ),
                ),
                focusNode: _focusNode,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                onEditingComplete: _login,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.done,
              ),
            ),
            TextButton(
              onPressed: _login,
              child: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    ),
  );

  void _login() async {
    setState(() {
      _loggingIn = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController!.text,
        password: _passwordController!.text,
      );
      if (!mounted) return;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ChatScreen()));
      _usernameController?.clear();
      _passwordController?.clear();
    } catch (e) {
      setState(() {
        _loggingIn = false;
      });

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
          content: Text(
            e.toString(),
          ),
          title: const Text('Error'),
        ),
      );
    }
  }
}
