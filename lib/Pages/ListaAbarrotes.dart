import 'package:LBF/Pages/Home.dart';
import 'package:LBF/Pages/InfoLocal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ListaAbarrotes());
}

class ListaAbarrotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AbarrotesScreen(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple.shade900,
      ),
    );
  }
}

class AbarrotesScreen extends StatelessWidget {
  // Lista de datos personalizados para las mini tarjetas
  final List<Map<String, String>> miniCardsData = [
    {
      'title': "Pizzas",
      'iconUrl': "https://images.rappi.com/restaurants_background/16-1672432365975.jpg"
    },
    {
      'title': "Hamburguesas",
      'iconUrl': "https://s1.elespanol.com/2019/03/04/ciencia/nutricion/nutricion_380722770_117009517_1706x1280.jpg"
    },
    {
      'title': "Alitas y Pollo",
      'iconUrl': "https://content.skyscnr.com/m/2dcd7d0e6f086057/original/GettyImages-186142785.jpg"
    },
  ];

  // Lista de datos personalizados para las tarjetas grandes
  final List<Map<String, dynamic>> groceryCardsData = [
    {
      'imageUrl': "https://content.skyscnr.com/m/2dcd7d0e6f086057/original/GettyImages-186142785.jpg",
      'title': "Alitas y Snacks Kings",
      'rating': 4.1,
      'openingTime': "6:00 PM",
      'discount': "Ahorra hasta un 60%"
    },
    {
      'imageUrl': "https://www.aceiteideal.com/wp-content/uploads/2020/08/PORTADA-garnachas.png",
      'title': "Hamburguesas El Rey",
      'rating': 4.5,
      'openingTime': "5:00 PM",
      'discount': "2x1 en combos"
    },
    {
      'imageUrl': "https://images.rappi.com/restaurants_background/16-1672432365975.jpg",
      'title': "Pizzas Express",
      'rating': 4.0,
      'openingTime': "12:00 PM",
      'discount': "Ahorra hasta un 30%"
    },
    {
      'imageUrl': "https://www.elsoldemexico.com.mx/metropoli/cdmx/xn6i62-feria-de-la-garnacha-2024.png/alternates/LANDSCAPE_560/Fer%C3%ADa%20de%20la%20Garnacha%202024.png",
      'title': "Garnachitas",
      'rating': 4.0,
      'openingTime': "11:00 AM",
      'discount': "Ahorra hasta un 30%"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alitas y pollo",
          style: TextStyle(color: Colors.white), // Color de letra en blanco
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white, // Icono en blanco
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );// Regresar
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white, // Icono en blanco
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.purple.shade900, // Fondo en purple.shade900
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Sección de mini tarjetas arriba
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: miniCardsData.map((data) {
                  return MiniCard(
                    title: data['title']!,
                    iconUrl: data['iconUrl']!,
                  );
                }).toList(),
              ),
            ),
            // Sección de tarjetas grandes
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: groceryCardsData.length, // Número de tarjetas en la lista
              itemBuilder: (context, index) {
                final cardData = groceryCardsData[index];
                return GroceryCard(
                  imageUrl: cardData['imageUrl'],
                  title: cardData['title'],
                  rating: cardData['rating'],
                  openingTime: cardData['openingTime'],
                  discount: cardData['discount'],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InfoLocal()),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MiniCard extends StatelessWidget {
  final String title;
  final String iconUrl;

  MiniCard({required this.title, required this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Tamaño consistente para todas las mini tarjetas
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              iconUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover, // Ajusta la imagen para que no se deforme
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(color: Colors.purple.shade900),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class GroceryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double rating;
  final String openingTime;
  final String discount;
  final VoidCallback onTap;

  GroceryCard({
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.openingTime,
    required this.discount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Imagen de la tarjeta
            Container(
              width: 100,
              height: 100,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Abre a las $openingTime",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Información de la tarjeta
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        SizedBox(width: 4.0),
                        Text(
                          "$rating (30+)",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      discount,
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

