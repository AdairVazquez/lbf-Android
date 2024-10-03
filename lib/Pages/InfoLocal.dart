import 'package:flutter/material.dart';

class InfoLocal extends StatelessWidget {
  const InfoLocal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Información del Local',
          style: TextStyle(
            color: Colors.white, // Cambia el color aquí (puedes usar otros como Colors.red o Colors.blue)
          ),
        ),
        backgroundColor: Colors.purple.shade900,
      ),
        body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.purple.shade900,
                      child: const Icon(
                        Icons.store,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Nombre del Local',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Categoría del local',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Información del local
              infoSection(
                icon: Icons.location_on,
                title: 'Dirección:',
                content: 'Av. Principal #123, Ciudad',
              ),
              const SizedBox(height: 16),
              infoSection(
                icon: Icons.phone,
                title: 'Teléfono:',
                content: '+1 234 567 890',
              ),
              const SizedBox(height: 16),
              infoSection(
                icon: Icons.access_time,
                title: 'Horario:',
                content: 'Lunes - Viernes: 9:00 AM - 6:00 PM',
              ),
              const SizedBox(height: 16),
              infoSection(
                icon: Icons.email,
                title: 'Email:',
                content: 'contacto@local.com',
              ),

              const SizedBox(height: 32),

              // Botón de contacto
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade900,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // Acción al presionar el botón
                  },
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.location_on_rounded, // Cambia el ícono aquí (puedes usar otros como Icons.email o Icons.chat)
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Agrega aquí la lógica para manejar el evento del botón
                            // Por ejemplo, puedes abrir una pantalla de contacto o realizar una llamada.
                          },
                        ),
                        Text(
                          'Ir a Google Maps', // Agrega aquí el texto que deseas mostrar debajo del ícono
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    )


                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget personalizado para las secciones de información
  Widget infoSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.purple.shade900),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade900,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
