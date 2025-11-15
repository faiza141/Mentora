import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';  // ← ADD THIS
import 'screens/login.dart';
import 'services/theme_service.dart';
import 'providers/token_provider.dart';  // ← ADD THIS

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeService.init();

  runApp(
    ProviderScope(                      // ← REQUIRED for Riverpod
      child: const ChatbotApp(),
    ),
  );
}

class ChatbotApp extends ConsumerStatefulWidget {   // ← CHANGE THIS
  const ChatbotApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatbotApp> createState() => _ChatbotAppState();  // ← CHANGE THIS
}

class _ChatbotAppState extends ConsumerState<ChatbotApp> {        // ← CHANGE THIS
  @override
  void initState() {
    super.initState();

    /// Load app theme listener
    ThemeService.addListener(_onThemeChanged);

    /// Load tokens on app start (AUTO-LOGIN READY)
    ref.read(tokenProvider.notifier).loadTokens();   // ← ADD THIS
  }

  @override
  void dispose() {
    ThemeService.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mentora',
      debugShowCheckedModeBanner: false,
      theme: ThemeService.currentThemeData,
      home: const LoginScreen(),   // ← You can auto-skip later if tokens exist
    );
  }
}
