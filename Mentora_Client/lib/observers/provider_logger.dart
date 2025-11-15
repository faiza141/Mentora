import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
      ProviderBase provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    print("PROVIDER UPDATED: ${provider.name ?? provider.runtimeType}");
    print("OLD → $previousValue");
    print("NEW → $newValue");
  }
}
