import 'package:flutter/material.dart';

class BotonProb1 extends StatefulWidget {
  const BotonProb1({super.key});

  @override
  State<BotonProb1> createState() => _MorphingCardExampleState();
}

class _MorphingCardExampleState extends State<BotonProb1> {
  // Esta variable controla el estado de nuestra animación
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Al cambiar el estado, el AnimatedContainer hace el resto
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },

          child: AnimatedContainer(
            // 1. EL TIEMPO: Cuánto dura la transición
            duration: const Duration(milliseconds: 800),
            
            // 2. LA CURVA: La "física" o el ritmo del movimiento
            curve: Curves.bounceOut, 
            
            // 3. LAS PROPIEDADES QUE CAMBIAN
            width: _isExpanded ? 280.0 : 80.0,
            height: _isExpanded ? 120.0 : 80.0,

            decoration: BoxDecoration(
              color: _isExpanded ? Colors.grey[100] : Colors.black87,
              borderRadius: BorderRadius.circular(_isExpanded ? 16.0 : 40.0),
              boxShadow: [
                if (_isExpanded)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
              ],              
            ),
            padding: EdgeInsets.all(12),
            
            alignment: Alignment.center,

            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 1200),
              reverseDuration: const Duration(milliseconds: 200),
              
              child: Text(
                _isExpanded ? 'Interfaz Desplegada' : 'Toca',
                // Usamos un key para que AnimatedSwitcher sepa que el texto cambió
                key: ValueKey<bool>(_isExpanded), 
                style: TextStyle(
                  color: _isExpanded ? Colors.black87 : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: _isExpanded ? 18 : 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}