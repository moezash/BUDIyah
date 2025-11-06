import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const SparkleLoginApp());
}

const Color _backgroundColor = Color(0xFFFF9B9B);
const Color _primaryColor = Color(0xFFFF857D);
const Color _primarySoft = Color(0xFFFFB6AD);
const Color _accentColor = Color(0xFFFF6F6A);
const Color _textDark = Color(0xFF1F1F1F);
const Color _textMuted = Color(0xFF6E6E73);
const Color _dividerColor = Color(0xFFFF8D86);
const LinearGradient _panelGradient = LinearGradient(
  colors: [Color(0xFFFFFFFF), Color(0xFFFFF2EE)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const LinearGradient _backgroundGradient = LinearGradient(
  colors: [Color(0xFFFF948C), Color(0xFFFF7E76)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

class SparkleLoginApp extends StatelessWidget {
  const SparkleLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sparkle Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: _backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primaryColor,
          primary: _primaryColor,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: _primaryColor,
          selectionColor: Color(0x33FFA399),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/signup': (_) => const SignupPage(),
        '/home': (_) => const HomePage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute<void>(
        builder: (_) => NotFoundPage(requestedRoute: settings.name ?? 'unknown'),
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(gradient: _backgroundGradient),
              child: Opacity(
                opacity: 0.32,
                child: CustomPaint(
                  painter: const _TopographicPatternPainter(),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: size.height * 0.45,
            child: ClipPath(
              clipper: const _BottomCurveClipper(),
              child: const DecoratedBox(
                decoration: BoxDecoration(gradient: _panelGradient),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _StatusBar(),
                  const SizedBox(height: 48),
                  const Spacer(),
                  const Text(
                    'Selamat Datang!',
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: _textDark,
                      height: 1.05,
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        foregroundColor: _textMuted,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: Text(
                              'Lanjutkan',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: _textMuted,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: _primaryColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: _primaryColor.withValues(alpha: 0.45),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(14),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const _BottomHandle(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final size = media.size;
    final bottomInset = media.padding.bottom;
    final double panelHeight = math.max(size.height * 0.68, 520.0).clamp(0.0, size.height);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(gradient: _backgroundGradient),
              child: Opacity(
                opacity: 0.32,
                child: CustomPaint(
                  painter: const _TopographicPatternPainter(),
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: const _StatusBar(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: panelHeight,
              width: double.infinity,
              child: CustomPaint(
                painter: const _CurvedPanelPainter(),
                child: ClipPath(
                  clipper: const _CurvedPanelClipper(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 44, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeading(),
                                const SizedBox(height: 28),
                                _buildEmailField(),
                                const SizedBox(height: 24),
                                _buildPasswordField(),
                                const SizedBox(height: 20),
                                _buildRememberMeRow(),
                                const SizedBox(height: 36),
                                _buildLoginButton(),
                                const SizedBox(height: 20),
                                _buildSignupLink(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const _BottomHandle(),
                        SizedBox(height: bottomInset + 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Masuk',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: _textDark,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: _primaryColor,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: _textDark,
          ),
          decoration: InputDecoration(
            hintText: 'musagwanteng@gmail.com',
            hintStyle: const TextStyle(
              fontSize: 15,
              color: Color(0x996B7078),
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 4, right: 12),
              child: Icon(
                Icons.mail_outline,
                size: 18,
                color: _textMuted,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: const EdgeInsets.only(left: 4, right: 4, bottom: 12),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _dividerColor.withValues(alpha: 0.4)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: _dividerColor, width: 1.6),
            ),
            suffixIconConstraints: const BoxConstraints(minHeight: 36),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: !_showPassword,
          textInputAction: TextInputAction.done,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: _textDark,
          ),
          decoration: InputDecoration(
            hintText: 'Masukkan Password Anda',
            hintStyle: const TextStyle(
              fontSize: 15,
              color: Color(0x996B7078),
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 4, right: 12),
              child: Icon(
                Icons.lock_outline,
                size: 18,
                color: _textMuted,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              icon: Icon(
                _showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20,
                color: _textMuted,
              ),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            contentPadding: const EdgeInsets.only(left: 4, right: 8, bottom: 12),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _dividerColor.withValues(alpha: 0.4)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: _dividerColor, width: 1.6),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRememberMeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) {
                setState(() => _rememberMe = value ?? false);
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              side: BorderSide(color: _accentColor.withValues(alpha: 0.9), width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
              activeColor: _accentColor,
              checkColor: Colors.white,
            ),
            const SizedBox(width: 8),
            const Text(
              'Ingat Saya',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _textMuted,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: _accentColor,
          ),
          child: const Text(
            'Lupa Password?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, '/home'),
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: _primarySoft.withValues(alpha: 0.4),
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text(
        'Login',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSignupLink() {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text(
            'Tidak punya akun? ',
            style: TextStyle(
              fontSize: 15,
              color: _textMuted,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/signup'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: _accentColor,
            ),
            child: const Text(
              'Sign up',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final size = media.size;
    final bottomInset = media.padding.bottom;
    final double panelHeight = math.max(size.height * 0.7, 560.0).clamp(0.0, size.height);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(gradient: _backgroundGradient),
              child: Opacity(
                opacity: 0.32,
                child: CustomPaint(
                  painter: const _TopographicPatternPainter(),
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: const _StatusBar(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: panelHeight,
              width: double.infinity,
              child: CustomPaint(
                painter: const _CurvedPanelPainter(),
                child: ClipPath(
                  clipper: const _CurvedPanelClipper(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 44, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeading(),
                                const SizedBox(height: 30),
                                _buildEmailField(),
                                const SizedBox(height: 24),
                                _buildPhoneField(),
                                const SizedBox(height: 24),
                                _buildPasswordField(),
                                const SizedBox(height: 24),
                                _buildConfirmPasswordField(),
                                const SizedBox(height: 44),
                                _buildCreateAccountButton(),
                                const SizedBox(height: 22),
                                _buildLoginLink(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const _BottomHandle(),
                        SizedBox(height: bottomInset + 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daftar',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: _textDark,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: _primaryColor,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: _textDark,
          ),
          decoration: _underlineInputDecoration(
            hintText: 'musagwanteng@gmail.com',
            icon: Icons.mail_outline,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nomor Telepon',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: _textDark,
          ),
          decoration: _underlineInputDecoration(
            hintText: '+62 851 - 6288 - 4545',
            icon: Icons.phone_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: !_showPassword,
          textInputAction: TextInputAction.next,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: _textDark,
          ),
          decoration: _underlineInputDecoration(
            hintText: 'Masukkan Password Anda',
            icon: Icons.lock_outline,
            toggleVisible: true,
            showValue: _showPassword,
            onToggle: () => setState(() => _showPassword = !_showPassword),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Confirm Password',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: !_showConfirmPassword,
          textInputAction: TextInputAction.done,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: _textDark,
          ),
          decoration: _underlineInputDecoration(
            hintText: 'Konfirmasi Password Anda',
            icon: Icons.lock_outline,
            toggleVisible: true,
            showValue: _showConfirmPassword,
            onToggle: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
          ),
        ),
      ],
    );
  }

  InputDecoration _underlineInputDecoration({
    required String hintText,
    required IconData icon,
    bool toggleVisible = false,
    bool showValue = false,
    VoidCallback? onToggle,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 15,
        color: Color(0x996B7078),
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 4, right: 12),
        child: Icon(
          icon,
          size: 18,
          color: _textMuted,
        ),
      ),
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      suffixIcon: toggleVisible
          ? IconButton(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              icon: Icon(
                showValue ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20,
                color: _textMuted,
              ),
              onPressed: onToggle,
            )
          : null,
      contentPadding: const EdgeInsets.only(left: 4, right: 8, bottom: 12),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _dividerColor.withValues(alpha: 0.4)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: _dividerColor, width: 1.6),
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, '/home'),
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: _primaryColor.withValues(alpha: 0.4),
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text(
        'Create Account',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text(
            'Sudah punya akun? ',
            style: TextStyle(
              fontSize: 15,
              color: _textMuted,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: _accentColor,
            ),
            child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _primaryColor,
        title: const Text('Sparkle Home'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Welcome to Sparkle!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
        ),
      ),
    );
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key, required this.requestedRoute});

  final String requestedRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '404',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: _textDark,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Oops! Route "$requestedRoute" tidak ditemukan.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          '9:41',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        Row(
          children: [
            Icon(Icons.signal_cellular_alt, size: 18, color: _textDark),
            SizedBox(width: 4),
            Icon(Icons.wifi, size: 18, color: _textDark),
            SizedBox(width: 4),
            Icon(Icons.battery_full, size: 20, color: _textDark),
          ],
        ),
      ],
    );
  }
}

class _BottomHandle extends StatelessWidget {
  const _BottomHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 128,
        height: 6,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.2),
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}

class _CurvedPanelClipper extends CustomClipper<Path> {
  const _CurvedPanelClipper();

  @override
  Path getClip(Size size) => _panelPath(size);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _CurvedPanelPainter extends CustomPainter {
  const _CurvedPanelPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final path = _panelPath(size);
    final paint = Paint()
      ..shader = _panelGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Path _panelPath(Size size) {
  final double startY = size.height * 0.2;
  final double control = size.height * 0.28;

  return Path()
    ..moveTo(0, startY)
    ..cubicTo(
      size.width * 0.18,
      startY - control * 0.55,
      size.width * 0.38,
      startY + control * 0.35,
      size.width * 0.62,
      startY - control * 0.2,
    )
    ..cubicTo(
      size.width * 0.82,
      startY - control * 0.6,
      size.width * 0.95,
      startY - control * 0.05,
      size.width,
      startY + control * 0.25,
    )
    ..lineTo(size.width, size.height)
    ..lineTo(0, size.height)
    ..close();
}

class _BottomCurveClipper extends CustomClipper<Path> {
  const _BottomCurveClipper();

  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, size.height * 0.34);
    path.cubicTo(
      size.width * 0.18,
      size.height * 0.18,
      size.width * 0.42,
      size.height * 0.46,
      size.width * 0.66,
      size.height * 0.24,
    );
    path.quadraticBezierTo(
      size.width * 0.86,
      size.height * 0.16,
      size.width,
      size.height * 0.26,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _TopographicPatternPainter extends CustomPainter {
  const _TopographicPatternPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final Paint mainStroke = Paint()
      ..color = Colors.white.withValues(alpha: 0.38)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final Paint subtleStroke = Paint()
      ..color = Colors.white.withValues(alpha: 0.26)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final Path ridgeA = Path()
      ..moveTo(-width * 0.1, height * 0.2)
      ..cubicTo(
        width * 0.18,
        height * 0.04,
        width * 0.32,
        height * 0.32,
        width * 0.54,
        height * 0.18,
      )
      ..cubicTo(
        width * 0.76,
        height * 0.08,
        width * 0.94,
        height * 0.16,
        width * 1.1,
        height * 0.12,
      );

    final Path ridgeB = Path()
      ..moveTo(-width * 0.08, height * 0.38)
      ..cubicTo(
        width * 0.12,
        height * 0.26,
        width * 0.34,
        height * 0.48,
        width * 0.58,
        height * 0.36,
      )
      ..cubicTo(
        width * 0.78,
        height * 0.28,
        width * 0.92,
        height * 0.32,
        width * 1.08,
        height * 0.3,
      );

    final Path ridgeC = Path()
      ..moveTo(width * 0.02, height * 0.55)
      ..cubicTo(
        width * 0.22,
        height * 0.46,
        width * 0.42,
        height * 0.68,
        width * 0.68,
        height * 0.56,
      )
      ..cubicTo(
        width * 0.84,
        height * 0.48,
        width * 0.98,
        height * 0.52,
        width * 1.1,
        height * 0.48,
      );

    final Path contourLoop = Path()
      ..addOval(Rect.fromCenter(
        center: Offset(width * 0.27, height * 0.65),
        width: width * 0.26,
        height: height * 0.22,
      ));

    final Path contourLoopB = Path()
      ..addOval(Rect.fromCenter(
        center: Offset(width * 0.78, height * 0.24),
        width: width * 0.34,
        height: height * 0.28,
      ));

    final Path accentSwirl = Path()
      ..moveTo(width * 0.46, height * 0.78)
      ..cubicTo(
        width * 0.56,
        height * 0.72,
        width * 0.72,
        height * 0.86,
        width * 0.88,
        height * 0.74,
      )
      ..quadraticBezierTo(
        width * 0.96,
        height * 0.68,
        width * 1.06,
        height * 0.76,
      );

    canvas.drawPath(ridgeA, mainStroke);
    canvas.drawPath(ridgeB, mainStroke);
    canvas.drawPath(ridgeC, subtleStroke);
    canvas.drawPath(contourLoop, subtleStroke);
    canvas.drawPath(contourLoopB, subtleStroke);
    canvas.drawPath(accentSwirl, subtleStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
