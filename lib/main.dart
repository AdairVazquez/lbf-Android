import 'package:LBF/Pages/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// Configuraciones de Firebase basadas en tu JSON
const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyCAB8KN48asZbTi43lieOIXiRBVI4OP-04",
  appId: "1:356390893145:android:21f566980bcd23463ee348",
  messagingSenderId: "356390893145",
  projectId: "localbf",
  databaseURL: "https://localbf-default-rtdb.firebaseio.com/",  // Agregado desde tu firebase_url
  storageBucket: "localbf.appspot.com",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase con las opciones necesarias
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// Pantalla de Splash con animación
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Configuración del AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Definición de la animación: un movimiento sutil hacia arriba y abajo
    _animation = Tween<Offset>(
      begin: Offset(0, 0),   // Punto inicial (sin desplazamiento)
      end: Offset(0, -0.10), // Mover la imagen un poco hacia arriba
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller);

    // Repetir la animación para un efecto de rebote
    _controller.repeat(reverse: true);

    // Temporizador para cambiar de pantalla después de 3 segundos
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Login()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Limpiar el controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Widget animado para la imagen del logo
            SlideTransition(
              position: _animation,
              child: Image.asset(
                'assets/images/logo_yapp.png',
                width: 300,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Local',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.deepPurple.shade900,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Business',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.deepPurple.shade900,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Finder',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.deepPurple.shade900,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
