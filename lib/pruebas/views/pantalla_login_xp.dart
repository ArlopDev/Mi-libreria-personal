import 'dart:math';
import 'package:flutter/material.dart';

// ============================================================
// LoginScreen - estilo "escritorio de inicios de los 2000s"
// Pantalla de bienvenida con selección de cuenta + cuadro de
// contraseña brillante, al estilo de los clásicos sistemas
// operativos de esa época.
// ============================================================
class PantallaLoginXp extends StatefulWidget {
  const PantallaLoginXp({super.key});

  @override
  State<PantallaLoginXp> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<PantallaLoginXp> {
  final TextEditingController _passwordController = TextEditingController();

  String? _usuarioSeleccionado;
  bool _mostrarPassword = false;

  final List<Map<String, dynamic>> _cuentasDemo = [
    {'nombre': 'Admin', 'color': const Color(0xFF42A5F5)},
    {'nombre': 'Usuario', 'color': const Color(0xFF66BB6A)},
    {'nombre': 'Invitado', 'color': const Color(0xFFBDBDBD)},
  ];

  final List<String> _passwordsDemo = [
    '123456',
    'Max',
    '16/03/1990',
    '********',
  ];

  // Selecciona una cuenta y pasa a la pantalla de contraseña,
  // autocompletando una contraseña de demostración aleatoria
  void _seleccionarCuenta(String nombre) {
    final random = Random();
    setState(() {
      _usuarioSeleccionado = nombre;
      _mostrarPassword = true;
      _passwordController.text = _passwordsDemo[random.nextInt(_passwordsDemo.length)];
    });
  }

  void _volverASeleccion() {
    setState(() {
      _mostrarPassword = false;
      _usuarioSeleccionado = null;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildFondo(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _mostrarPassword
                    ? _buildPantallaPassword()
                    : _buildPantallaSeleccion(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  

  

  // Pantalla de selección de cuenta: "haz clic en tu nombre para empezar"
  Widget _buildPantallaSeleccion() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLogoGel(),
        const SizedBox(height: 24),
        const Text(
          'Selecciona tu usuario para comenzar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(color: Colors.black38, blurRadius: 4, offset: Offset(0, 2)),
            ],
          ),
        ),
        const SizedBox(height: 32),
        ..._cuentasDemo.map(
          (cuenta) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: _buildCuentaTile(cuenta['nombre'], cuenta['color']),
          ),
        ),
      ],
    );
  }

  

  Widget _buildCuentaTile(String nombre, Color color) {
    return InkWell(
      onTap: () => _seleccionarCuenta(nombre),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color.withValues(alpha: 0.9), color],
                ),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: Text(
                  nombre[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Text(
              nombre,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Cuadro de contraseña, simulando un diálogo brillante clásico
  Widget _buildPantallaPassword() {
    return Container(
      width: 340,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBarraTitulo(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Hola, $_usuarioSeleccionado',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 6),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contraseña autocompletada por comodidad',
                    style: TextStyle(fontSize: 10, color: Colors.black45, fontStyle: FontStyle.italic),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _volverASeleccion,
                      child: const Text('Cambiar de usuario'),
                    ),
                    const SizedBox(width: 8),
                    _buildBotonFlechaVerde(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarraTitulo() {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF1976D2), Color(0xFF64B5F6)]),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Iniciar sesión',
            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.close, color: Colors.white, size: 14),
        ],
      ),
    );
  }

  Widget _buildBotonFlechaVerde() {
    return InkWell(
      onTap: () {
        // Lógica de inicio de sesión
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Iniciando sesión...')),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF9CCC65), Color(0xFF558B2F)],
          ),
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
      ),
    );
  }
}

// Pinta unas colinas verdes onduladas con un degradado simple,
// como referencia genérica a los fondos de pantalla paisajísticos
// típicos de esa época (no reproduce ninguna imagen real específica)
class _ColinasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF7CB342), Color(0xFF33691E)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path()
      ..moveTo(0, size.height * 0.55)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.3, size.width * 0.5, size.height * 0.45)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.6, size.width, size.height * 0.35)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildLogoGel() {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 98, 159, 195)],
        ),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds){
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(190, 184, 207, 1), // Tu primer color ajustado al formato estándar
                Color.fromRGBO(15, 3, 33, 1),
              ],
            ).createShader(bounds);
          },
          child: Icon(
            Icons.door_back_door_rounded,
            size: 45,
            color: Colors.white
          ),
        )
      ),
    );
  }

// Fondo degradado azul con franjas de luz diagonales y colinas
  // abajo, inspirado en los fondos de escritorio típicos de la época
  Widget _buildFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
        ),
      ),
      child: Stack(
        children: [
          ..._buildFranjasDeLuz(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 180,
              child: CustomPaint(painter: _ColinasPainter()),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFranjasDeLuz() {
    return [
      Positioned(
        top: -100,
        left: -50,
        child: Transform.rotate(
          angle: -0.4,
          child: Container(
            width: 500,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(60),
            ),
          ),
        ),
      ),
      Positioned(
        top: 60,
        left: -150,
        child: Transform.rotate(
          angle: -0.4,
          child: Container(
            width: 600,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
      ),
    ];
  }