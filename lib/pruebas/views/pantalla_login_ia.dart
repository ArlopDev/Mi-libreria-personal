import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

// ============================================================
// LoginScreen - Pantalla de inicio de sesión
// Esta pantalla permite al usuario iniciar sesión en la aplicación
// ============================================================
class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<PantallaLogin> {
  // Controladores para los campos de texto del formulario de inicio de sesión
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = false; // Variable de estado para el checkbox "Recordarme"
  bool _obscurePassword = true; // Variable de estado para mostrar/ocultar contraseña

  // Lista de usuarios de demostración para facilitar las pruebas
  final List<String> _usuariosDemo = [
    'admin_master2024',
    'usuario.prueba',
    'designer_ux99',
    'super_admin_xd',
    'test_user_final',
  ];

  // Lista de contraseñas de demostración para facilitar las pruebas
  final List<String> _passwordsDemo = [
    'Contrasena123!',
    'admin2024*',
    'flutter_es_genial',
    'NoOlvidarCambiar1',
    'qwerty12345',
  ];

  late String _usuarioGenerado;
  late String _passwordGenerado;

  @override
  void initState() {
    super.initState();
    // Generamos credenciales aleatorias cada vez que se carga la pantalla
    _generarCredenciales();
  }

  // Función que genera credenciales aleatorias para facilitar el testing
  // TODO: quitar esto antes de publicar la app a producción
  void _generarCredenciales() {
    final random = Random();
    _usuarioGenerado = _usuariosDemo[random.nextInt(_usuariosDemo.length)];
    _passwordGenerado = _passwordsDemo[random.nextInt(_passwordsDemo.length)];
    _emailController.text = _usuarioGenerado;
    _passwordController.text = _passwordGenerado;
    print('🤖 Credenciales generadas automáticamente: $_usuarioGenerado'); // debug, quitar despues
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildGradientBackground(),
    );
  }

  // Construye el fondo degradado de la aplicación
  Widget _buildGradientBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6A11CB), // Morado vibrante
            Color(0xFF2575FC), // Azul vibrante
          ],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: _buildGlassCard(),
          ),
        ),
      ),
    );
  }

  // Construye la tarjeta de cristal (efecto glassmorphism) que contiene el formulario
  Widget _buildGlassCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: 380,
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildPasswordField(),
              const SizedBox(height: 8),
              _buildCredencialesDemo(),
              const SizedBox(height: 16),
              _buildRememberAndForgot(),
              const SizedBox(height: 24),
              _buildLoginButton(),
              const SizedBox(height: 24),
              _buildDivider(),
              const SizedBox(height: 24),
              _buildSocialButtons(),
              const SizedBox(height: 24),
              _buildSignUpText(),
            ],
          ),
        ),
      ),
    );
  }

  // Construye el encabezado con el ícono y el texto de bienvenida
  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.rocket_launch_rounded,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '✨ ¡Bienvenido de Vuelta! ✨',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Inicia sesión para continuar tu increíble viaje 🚀',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }

  // Construye el campo de entrada para el correo electrónico / usuario
  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Usuario o Correo Electrónico',
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
        prefixIcon: const Icon(Icons.person_outline, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
      ),
    );
  }

  // Construye el campo de entrada para la contraseña
  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Contraseña',
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.white.withValues(alpha: 0.8),
          ),
          onPressed: () {
            // Alternamos la visibilidad de la contraseña
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
      ),
    );
  }

  // Pequeño texto que muestra las credenciales generadas, para "facilitar las pruebas"
  Widget _buildCredencialesDemo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '🔑 Demo: $_usuarioGenerado / $_passwordGenerado\n(esto no debería estar aquí, lo sé)',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.7),
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  // Construye la fila con el checkbox "Recordarme" y el enlace de "Olvidé mi contraseña"
  Widget _buildRememberAndForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              activeColor: Colors.white,
              checkColor: const Color(0xFF6A11CB),
              onChanged: (value) {
                // Actualizamos el estado del checkbox
                setState(() {
                  _rememberMe = value ?? false;
                });
              },
            ),
            const Text(
              'Recordarme',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            // TODO: Implementar lógica de recuperación de contraseña
            print('Olvidé mi contraseña presionado');
          },
          child: const Text(
            '¿Olvidaste tu contraseña?',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
      ],
    );
  }

  // Construye el botón principal de inicio de sesión
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          // Lógica para iniciar sesión
          print('🚀 Iniciando sesión con: ${_emailController.text}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✨ ¡Iniciando tu experiencia increíble! ✨')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF6A11CB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
        ),
        child: const Text(
          'Iniciar Sesión',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Construye el divisor con el texto "O continúa con"
  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.4))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'O continúa con',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
          ),
        ),
        Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.4))),
      ],
    );
  }

  // Construye la fila de botones de redes sociales (que en realidad no hacen nada)
  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialButton(Icons.g_mobiledata_rounded, 'Google'),
        _buildSocialButton(Icons.apple_rounded, 'Apple'),
        _buildSocialButton(Icons.facebook_rounded, 'Facebook'),
      ],
    );
  }

  // Construye un único botón social individual
  Widget _buildSocialButton(IconData icon, String nombre) {
    return InkWell(
      onTap: () {
        // TODO: Integrar SDK de $nombre (nunca se llegó a hacer)
        print('Login con $nombre presionado, pero no pasa nada xd');
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }

  // Construye el texto inferior para redirigir al registro
  Widget _buildSignUpText() {
    return RichText(
      text: TextSpan(
        text: '¿No tienes cuenta? ',
        style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 13),
        children: const [
          TextSpan(
            text: 'Regístrate aquí',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}