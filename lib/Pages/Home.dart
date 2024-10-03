import 'package:LBF/Pages/ListaAbarrotes.dart';
import 'package:LBF/Pages/Login.dart';
import 'package:LBF/Pages/Settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const Home(),
    );
  }
}

// Función para cerrar sesión
Future<void> _cerrarSesion() async {
  try {
    await FirebaseAuth.instance.signOut();
    print('Sesión cerrada con éxito.');
  } catch (e) {
    print('Error al cerrar sesión: $e');
  }
}

// Clase para representar cada tarjeta de la grilla
class CardData {
  final String imageUrl;
  final String title;
  final String subtitle;
  final Widget destinationPage;

  CardData({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.destinationPage,
  });
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de tarjetas con información y páginas de destino
    final List<CardData> cardDataList = [
      CardData(
        imageUrl: 'https://img.freepik.com/psd-gratis/hamburguesa-ternera-fresca-aislada-sobre-fondo-transparente_191095-9018.jpg',
        title: 'Comida rápida',
        subtitle: 'Date un break',
        destinationPage: ListaAbarrotes(),  // Pantalla a la que navegará
      ),
      CardData(
        imageUrl: 'https://i.pinimg.com/474x/a2/ec/7a/a2ec7ae3657608144fd84d2fa973136d.jpg',
        title: 'Tlapalerias',
        subtitle: 'Construye fácil',
        destinationPage: ListaAbarrotes(),
      ),
      CardData(
        imageUrl: 'https://w1.pngwing.com/pngs/372/112/png-transparent-school-line-art-paper-stationery-school-drawing-paper-clip-cartoon-pen.png',
        title: 'Papelerias',
        subtitle: '¿Te falto la cartulina?',
        destinationPage: ListaAbarrotes(),
      ),
      CardData(
        imageUrl: 'https://e7.pngegg.com/pngimages/757/30/png-clipart-ice-cream-cake-torte-chocolate-cake-nice-cream-cake-cream-food.png',
        title: 'Pastelerías',
        subtitle: 'Un antojito de noche',
        destinationPage: ListaAbarrotes(),
      ),
      CardData(
        imageUrl: 'https://img.freepik.com/psd-premium/contador-barras-aislado-fondo-transparente-png_1073071-7930.jpg',
        title: 'Bares',
        subtitle: 'Shot shot!',
        destinationPage: ListaAbarrotes(),
      ),
      CardData(
        imageUrl: 'https://photoshop-kopona.com/uploads/posts/2019-02/1551097402_coffee_cup9.jpg',
        title: 'Cafeterias',
        subtitle: 'Que mejor manera de empezar el día',
        destinationPage: ListaAbarrotes(),
      ),
      CardData(
        imageUrl: 'https://images.rappi.com.mx/restaurants_background/22-1719586023473.jpg',
        title: 'Pizzerías',
        subtitle: 'Otro antojito',
        destinationPage: ListaAbarrotes(),
      ),
      CardData(
        imageUrl: 'https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/76CA0351-4470-4532-882B-0D0EAF6FCFEA/Derivates/f991d9c3-0180-4e7e-853f-36dd7ba8c7b4.jpg',
        title: 'Tortilleria',
        subtitle: '15 courses',
        destinationPage: ListaAbarrotes(),
      ),
      CardData(
        imageUrl: 'https://img.freepik.com/foto-gratis/vegetal-vista-frontal_140725-103355.jpg',
        title: 'Verduleria',
        subtitle: 'Las más frescas',
        destinationPage: ListaAbarrotes(),
      ),
      CardData(
        imageUrl: 'https://w7.pngwing.com/pngs/415/39/png-transparent-roast-chicken-chicken-food-meat-thumbnail.png',
        title: 'Pollería',
        subtitle: 'Pio pio',
        destinationPage: ListaAbarrotes(),
      ),// Agrega más categorías según necesites
    ];

    return Scaffold(
      drawer: MenuDrawer(),
      body: Column(
        children: [
          // Sección superior con AppBar personalizado
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
              color: Colors.purple.shade900,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Barra superior con ícono de menú hamburguesa
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) {
                        return IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        // Lógica para el botón de notificaciones
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Hola,\nMe agrada verte de nuevo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Busca tu local favorito",
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.mic,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Aquí agregamos el scroll solo para las tarjetas
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),  // Para tener un efecto de rebote en el scroll
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: cardDataList.length,
                itemBuilder: (context, index) {
                  final cardData = cardDataList[index];
                  return GestureDetector(
                    onTap: () {
                      // Navegación al presionar la tarjeta
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => cardData.destinationPage),
                      );
                    },
                    child: CategoryCard(
                      imageUrl: cardData.imageUrl,
                      title: cardData.title,
                      subtitle: cardData.subtitle,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const CategoryCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                imageUrl,
                height: 150.0,  // Altura fija para la imagen
                width: double.infinity,  // Se ajusta al ancho de la tarjeta
                fit: BoxFit.contain,  // Ajusta la imagen para que cubra toda la tarjeta
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple.shade900,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Image.network('https://cdn-icons-png.flaticon.com/512/5087/5087579.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'Usuario',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.business_center),
            title: Text('Categorias'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuraciones'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
            onTap: () async {
              await _cerrarSesion();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
