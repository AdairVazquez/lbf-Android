import 'package:LBF/Pages/Home.dart';
import 'package:LBF/Pages/RegistroUsr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = '';
  bool _isPasswordVisible = false;

  // Inicializa GoogleSignIn con el clientId
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '356390893145-1npodi11duouunp0c53lhc3eu6h3e6nq.apps.googleusercontent.com', // Reemplaza con tu clientId
  );

  // Función para validar el login
  Future<void> _login() async {
    try {
      // Autenticación con Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Mostrar alerta de Bienvenida
      AlertaBienvenido();
      // Si el inicio de sesión es exitoso, redirigir a Home
      if (userCredential.user != null) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      // Mostrar errores de autenticación
      if (e.code == 'user-not-found') {
        _showErrorAlert('No se encontró un usuario con ese correo.');
      } else if (e.code == 'wrong-password') {
        _showErrorAlert('Contraseña incorrecta.');
      } else {
        _showErrorAlert('Error: ${e.message}');
      }
    }
  }

  // Método para iniciar sesión con Google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      AlertaBienvenido();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in with the credential and obtain UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      // Navigate to the home screen upon successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (e) {
      // Handle the error here, such as showing a dialog or snackbar
      print('Error signing in with Google: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in with Google: $e')),
      );
    }
  }

  Future<void> signInWithGitHub(BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: "Ov23li5sdoVD8PcUQy4Z",
        clientSecret: "cfad002d3b8b2251edf9801434738ea1415327c6",
        redirectUrl: "https://localbf.firebaseapp.com/__/auth/handler"
    );
    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        print(result.token);
        // Crea un objeto de credenciales de Firebase
        final credential = GithubAuthProvider.credential(result.token!);
        try {
          AlertaBienvenido();
          // Inicia sesión en Firebase con las credenciales de GitHub
          UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()));
          // Aquí puedes manejar el usuario registrado
          print("Usuario registrado: ${userCredential.user?.uid}");

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Usuario registrado: ${userCredential.user?.uid}')),
          );
        } on FirebaseAuthException catch (e) {
          // Maneja el error si ocurre
          print("Error al registrarse: ${e.message}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al registrarse: ${e.message}')),
          );
        }
        break;
      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        print(result.errorMessage);
        break;
    }
  }

  // Función para mostrar la alerta de bienvenida
  void AlertaBienvenido() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: '¡Bienvenido!',
      text: '¡Redirigiendo!',
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  // Función para mostrar alertas de error
  void _showErrorAlert(String message) {
    print(message);
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: message,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size mediaSize = MediaQuery.of(context).size;
    Color myColor = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/images/fondo_shop.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(myColor.withOpacity(0.3), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(top: 80, child: _buildTop()),
            Positioned(bottom: 0, child: _buildBottom(mediaSize, myColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_bag,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "Local Business Finder",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              letterSpacing: 3,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottom(Size mediaSize, Color myColor) {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(myColor),
        ),
      ),
    );
  }

  Widget _buildForm(Color myColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bienvenido",
          style: TextStyle(
              color: myColor, letterSpacing: 3, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Introduce tu información por favor"),
        const SizedBox(height: 60),
        _buildGreyText("Email"),
        _buildInputField(_emailController),
        const SizedBox(height: 40),
        _buildGreyText("Contraseña"),
        _buildInputField(_passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
        _buildRegisterButton(), // Botón para registrar usuario
        const SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildInputField(TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        )
            : const Icon(Icons.account_circle_outlined),
      ),
      obscureText: isPassword && !_isPasswordVisible,
    );
  }

  // Botón de Login
  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _login,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        foregroundColor: Colors.purple.shade900,
        backgroundColor: Colors.white,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("LOGIN"),
    );
  }

  // Botón para registrar nuevo usuario
  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegistroUsr(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple.shade900,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("REGISTRARME"),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Ó inicia sesión con"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async{
                  await signInWithGoogle(context);
                } , // Método de inicio de sesión con Google
                child: Image.asset(
                  "assets/images/google.png",
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                 // Método de inicio de sesión con GitHub
                onTap: () async{
                  await signInWithGitHub(context);
                },
                child: Image.asset(
                  "assets/images/github.png",
                  height: 40,
                  width: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
