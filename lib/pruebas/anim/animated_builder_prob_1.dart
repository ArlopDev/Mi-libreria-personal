import 'package:flutter/material.dart';

class AnimatedBuilderProb1 extends StatefulWidget {
  const AnimatedBuilderProb1({super.key});

  @override
  State<AnimatedBuilderProb1> createState() => _RotacionInfinitaState();
}

// 1. Necesitamos un TickerProvider para que Flutter sincronice la animación con la pantalla
class _RotacionInfinitaState extends State<AnimatedBuilderProb1> with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 2. El controlador es el "motor"
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this, // Sincroniza con la tasa de refresco del teléfono
    )..repeat(); // Le decimos que se repita infinitamente
  }

  @override
  void dispose() {
    _controller.dispose(); // ¡IMPORTANTE! Limpiar siempre el controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 3. AnimatedBuilder escucha al controlador y reconstruye solo lo necesario
    return AnimatedBuilder(
      animation: _controller,
      child: const Icon(Icons.refresh, size: 100, color: Colors.blue),
      builder: (context, child) {
        // 4. Transform.rotate es quien hace el movimiento físico
        return Transform.rotate(
          angle: _controller.value * 2.0 * 3.14159, // De 0 a 360 grados
          child: child,
        );
      },
    );
  }
}