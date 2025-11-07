import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const SparkleLoginApp());
}

const Color _backgroundColor = Color(0xFFFF9B9B);
const Color _primaryColor = Color(0xFFFF857D);
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
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primaryColor,
          primary: _primaryColor,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: _primaryColor,
          selectionColor: Color(0x33FFA399),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w800,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
          displaySmall: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
          headlineLarge: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/signup': (_) => const SignupPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute<void>(
        builder: (_) =>
            NotFoundPage(requestedRoute: settings.name ?? 'unknown'),
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
          ),
        );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

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
                child: CustomPaint(painter: const _TopographicPatternPainter()),
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
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: const Text(
                        'Selamat Datang!',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          color: _textDark,
                          height: 1.15,
                          letterSpacing: -1.2,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _navigateToLogin,
                            borderRadius: BorderRadius.circular(30),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 28,
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [_primaryColor, _accentColor],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: _primaryColor.withValues(
                                            alpha: 0.4,
                                          ),
                                          blurRadius: 20,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text(
                                          'Lanjutkan',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
    final double panelHeight = math
        .max(size.height * 0.68, 520.0)
        .clamp(0.0, size.height);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(gradient: _backgroundGradient),
              child: Opacity(
                opacity: 0.32,
                child: CustomPaint(painter: const _TopographicPatternPainter()),
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
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: _textDark,
            letterSpacing: -0.8,
            height: 1.15,
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
            hintStyle: const TextStyle(fontSize: 15, color: Color(0x996B7078)),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 4, right: 12),
              child: Icon(Icons.mail_outline, size: 18, color: _textMuted),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            contentPadding: const EdgeInsets.only(
              left: 4,
              right: 4,
              bottom: 12,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: _dividerColor.withValues(alpha: 0.4),
              ),
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
            hintStyle: const TextStyle(fontSize: 15, color: Color(0x996B7078)),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 4, right: 12),
              child: Icon(Icons.lock_outline, size: 18, color: _textMuted),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              icon: Icon(
                _showPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
                color: _textMuted,
              ),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            contentPadding: const EdgeInsets.only(
              left: 4,
              right: 8,
              bottom: 12,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: _dividerColor.withValues(alpha: 0.4),
              ),
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
        GestureDetector(
          onTap: () {
            setState(() => _rememberMe = !_rememberMe);
          },
          child: Row(
            children: [
              Icon(
                _rememberMe ? Icons.check_circle : Icons.radio_button_unchecked,
                size: 20,
                color: _accentColor,
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
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [_primaryColor, _accentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOutCubic;
                    var tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Masuk',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_rounded, size: 18),
          ],
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
            style: TextStyle(fontSize: 15, color: _textMuted),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const SignupPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOutCubic;
                        var tween = Tween(
                          begin: begin,
                          end: end,
                        ).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: _accentColor,
            ),
            child: const Text(
              'Sign up',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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
    final double panelHeight = math
        .max(size.height * 0.7, 560.0)
        .clamp(0.0, size.height);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(gradient: _backgroundGradient),
              child: Opacity(
                opacity: 0.32,
                child: CustomPaint(painter: const _TopographicPatternPainter()),
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
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: _textDark,
            letterSpacing: -0.8,
            height: 1.15,
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
            onToggle: () =>
                setState(() => _showConfirmPassword = !_showConfirmPassword),
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
      hintStyle: const TextStyle(fontSize: 15, color: Color(0x996B7078)),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 4, right: 12),
        child: Icon(icon, size: 18, color: _textMuted),
      ),
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      suffixIcon: toggleVisible
          ? IconButton(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              icon: Icon(
                showValue
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [_primaryColor, _accentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOutCubic;
                    var tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Buat Akun',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_rounded, size: 18),
          ],
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
            style: TextStyle(fontSize: 15, color: _textMuted),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const LoginPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        const begin = Offset(-1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOutCubic;
                        var tween = Tween(
                          begin: begin,
                          end: end,
                        ).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: _accentColor,
            ),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const _HomeContent(), const ProfilePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          selectedItemColor: _primaryColor,
          unselectedItemColor: _textMuted,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent();

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  final List<String> _moods = ['🌸', '✨', '🎨', '🌺', '💫'];
  int _currentMoodIndex = 0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background dengan pattern
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _primaryColor.withValues(alpha: 0.05),
                    Colors.white,
                    _accentColor.withValues(alpha: 0.03),
                  ],
                ),
              ),
            ),
          ),
          // Floating circles decoration
          Positioned(
            top: -50,
            right: -30,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_pulseController.value * 0.1),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _primaryColor.withValues(alpha: 0.1),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 100,
            left: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _accentColor.withValues(alpha: 0.08),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTimeGreeting(),
                        const SizedBox(height: 20),
                        _buildMoodSelector(),
                        const SizedBox(height: 20),
                        _buildStatsGrid(),
                        const SizedBox(height: 20),
                        _buildQuoteCard(),
                        const SizedBox(height: 24),
                        _buildActivityTimeline(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeGreeting() {
    final hour = DateTime.now().hour;
    String greeting;
    String emoji;
    if (hour < 12) {
      greeting = 'Selamat Pagi';
      emoji = '☀️';
    } else if (hour < 15) {
      greeting = 'Selamat Siang';
      emoji = '🌤️';
    } else if (hour < 18) {
      greeting = 'Selamat Sore';
      emoji = '🌅';
    } else {
      greeting = 'Selamat Malam';
      emoji = '🌙';
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, _primaryColor.withValues(alpha: 0.05)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _primaryColor.withValues(alpha: 0.15),
                  _accentColor.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: _textDark,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Musa',
                  style: TextStyle(
                    fontSize: 14,
                    color: _textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, _primaryColor.withValues(alpha: 0.03)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bagaimana kabarmu?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _textMuted,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_moods.length, (index) {
              final isSelected = _currentMoodIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentMoodIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              _primaryColor.withValues(alpha: 0.2),
                              _accentColor.withValues(alpha: 0.15),
                            ],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(14),
                    border: isSelected
                        ? Border.all(
                            color: _primaryColor.withValues(alpha: 0.3),
                            width: 1.5,
                          )
                        : null,
                  ),
                  child: Text(
                    _moods[index],
                    style: TextStyle(fontSize: isSelected ? 30 : 26),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            value: '12',
            label: 'Hari Beruntun',
            icon: Icons.local_fire_department_rounded,
            color: const Color(0xFFFF6B6B),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            value: '47',
            label: 'Pencapaian',
            icon: Icons.emoji_events_rounded,
            color: const Color(0xFFFFD93D),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, color.withValues(alpha: 0.05)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.15), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: _textDark,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: _textMuted,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_primaryColor, _accentColor],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withValues(alpha: 0.25),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tetap semangat!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Hari yang produktif menantimu',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.85),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aktivitas',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: _textDark,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 16),
        _buildTimelineItem(
          time: '10:30',
          title: 'Menyelesaikan tugas',
          subtitle: 'Matematika Bab 5',
          color: _primaryColor,
        ),
        _buildTimelineItem(
          time: '14:15',
          title: 'Mengikuti kelas',
          subtitle: 'Pemrograman Web',
          color: const Color(0xFF6C5CE7),
        ),
        _buildTimelineItem(
          time: '16:00',
          title: 'Olahraga',
          subtitle: 'Basket dengan teman',
          color: const Color(0xFF00B894),
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String title,
    required String subtitle,
    required Color color,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      color.withValues(alpha: 0.3),
                      color.withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, color.withValues(alpha: 0.02)],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: color.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: color,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _textDark,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: _textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [_primaryColor.withValues(alpha: 0.08), Colors.white],
                ),
              ),
            ),
          ),
          // Content
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      _buildProfileCard(),
                      const SizedBox(height: 20),
                      _buildPersonalitySection(),
                      const SizedBox(height: 16),
                      _buildContactSection(),
                      const SizedBox(height: 16),
                      _buildPreferencesSection(),
                      const SizedBox(height: 20),
                      _buildActionButtons(context),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  _primaryColor.withValues(alpha: 0.03),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _primaryColor.withValues(alpha: 0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: _primaryColor.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Musa Ganteng',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: _textDark,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _primaryColor.withValues(alpha: 0.15),
                        _accentColor.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _primaryColor.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Siswa Aktif',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _primaryColor,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: _primaryColor.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [_primaryColor, _accentColor],
                    ),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalitySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              _primaryColor.withValues(alpha: 0.02),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _primaryColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tentang Saya',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _textDark,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTag('Suka Belajar', const Color(0xFF6C5CE7)),
                _buildTag('Kreatif', const Color(0xFFFF6B6B)),
                _buildTag('Aktif', const Color(0xFFFFD93D)),
                _buildTag('Fokus', const Color(0xFF00B894)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.12),
            color.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              _primaryColor.withValues(alpha: 0.02),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _primaryColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            _buildContactRow(Icons.email_rounded, 'musagwanteng@gmail.com'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            _buildContactRow(Icons.phone_rounded, '+62 851 - 6288 - 4545'),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: _primaryColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _textDark,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreferencesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              _primaryColor.withValues(alpha: 0.02),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _primaryColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengaturan',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _textDark,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 14),
            _buildPreferenceItem(Icons.dark_mode_rounded, 'Mode Gelap', false),
            const SizedBox(height: 10),
            _buildPreferenceItem(
              Icons.notifications_rounded,
              'Notifikasi',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceItem(IconData icon, String title, bool value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: _primaryColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
        ),
        Container(
          width: 44,
          height: 26,
          decoration: BoxDecoration(
            gradient: value
                ? LinearGradient(
                    colors: [_primaryColor, _accentColor],
                  )
                : null,
            color: value ? null : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(13),
            boxShadow: value
                ? [
                    BoxShadow(
                      color: _primaryColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          padding: const EdgeInsets.all(2),
          child: Align(
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildActionButton(
            'Edit Profil',
            Icons.edit_rounded,
            _primaryColor,
            () {},
          ),
          const SizedBox(height: 12),
          _buildActionButton('Keluar', Icons.logout_rounded, Colors.red, () {
            Navigator.of(context).pushAndRemoveUntil(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const SplashPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      const begin = Offset(-1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOutCubic;
                      var tween = Tween(
                        begin: begin,
                        end: end,
                      ).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                transitionDuration: const Duration(milliseconds: 500),
              ),
              (route) => false,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                color.withValues(alpha: 0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 19, color: color),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: color,
                  letterSpacing: 0.2,
                ),
              ),
            ],
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
                style: const TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                ),
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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
      ..shader = _panelGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Path _panelPath(Size size) {
  final path = Path();

  // Start from left side at about 1/5 from top
  path.moveTo(0, size.height * 0.08);

  // Create smooth wave curve across the top
  path.cubicTo(
    size.width * 0.25,
    size.height * -0.02,
    size.width * 0.45,
    size.height * 0.15,
    size.width * 0.65,
    size.height * 0.06,
  );

  path.cubicTo(
    size.width * 0.8,
    size.height * -0.01,
    size.width * 0.9,
    size.height * 0.05,
    size.width,
    size.height * 0.08,
  );

  // Complete the rectangle
  path.lineTo(size.width, size.height);
  path.lineTo(0, size.height);
  path.close();

  return path;
}

class _BottomCurveClipper extends CustomClipper<Path> {
  const _BottomCurveClipper();

  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from left side
    path.moveTo(0, size.height * 0.18);

    // Create smooth wave curve
    path.cubicTo(
      size.width * 0.25,
      size.height * 0.08,
      size.width * 0.45,
      size.height * 0.25,
      size.width * 0.65,
      size.height * 0.14,
    );

    path.cubicTo(
      size.width * 0.8,
      size.height * 0.06,
      size.width * 0.9,
      size.height * 0.12,
      size.width,
      size.height * 0.16,
    );

    // Complete the rectangle
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
      ..addOval(
        Rect.fromCenter(
          center: Offset(width * 0.27, height * 0.65),
          width: width * 0.26,
          height: height * 0.22,
        ),
      );

    final Path contourLoopB = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(width * 0.78, height * 0.24),
          width: width * 0.34,
          height: height * 0.28,
        ),
      );

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
