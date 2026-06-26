import 'package:flutter/material.dart';

class HeroProb1 extends StatelessWidget {
  const HeroProb1({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Primera pantalla', 
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24
          )
        ),
        elevation: 6,
        shadowColor: Colors.black,
        backgroundColor: Colors.lightBlue[300],
        foregroundColor: Colors.white,
      ),

      body: Center(

        child: GestureDetector(
          onTap: () {
            // Navegamos a la segunda pantalla
            Navigator.push(
              context,
              //Este es el comportamiento/animacion por defecto
              //MaterialPageRoute(builder: (_) => HeroSegundaPantalla())

              //Comportamiento/animacion personalizada
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 600),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                reverseTransitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (context, animation, secondaryAnimation) => const HeroSegundaPantalla()
              )
            );
          },

          // AQUÍ ESTÁ EL PRIMER HERO
          child: Hero(
            tag: 'tarjeta_temporizador', // Etiqueta única
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.deepOrange[300], // Un tono pastel cálido
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26, 
                    blurRadius: 10
                  )
                ],
              ),
              child: const Icon(Icons.timer, color: Colors.white, size: 50),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroSegundaPantalla extends StatelessWidget {
  const HeroSegundaPantalla({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // Usamos un fondo claro para resaltar la tarjeta superior
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // AQUÍ ESTÁ EL SEGUNDO HERO
          Hero(
            tag: 'tarjeta_temporizador', // LA MISMA ETIQUETA
            child: Container(
              width: double.infinity,
              height: 250, // Ahora es mucho más grande y ancho
              decoration: BoxDecoration(
                color: Colors.lightBlue[300],
                // Solo redondeamos las esquinas inferiores
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10
                  )
                ]
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: const Icon(
                          Icons.arrow_back_rounded, 
                          color: Colors.white,
                          size: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Center(
                      child: Icon(Icons.timer, color: Colors.white, size: 80),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            'Sesión de Enfoque',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}