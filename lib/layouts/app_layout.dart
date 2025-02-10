import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/theme_provider.dart';
import '../config/locale_provider.dart';

class AppLayout extends StatelessWidget {
  final Widget child;

  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Availability'),
        actions: [
          DropdownButton<Locale>(
            value: localeProvider.locale,
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                localeProvider.setLocale(newLocale);
              }
            },
            items: const [
              DropdownMenuItem(value: Locale('pt', 'BR'), child: Text('🇧🇷 PT-BR')),
              DropdownMenuItem(value: Locale('en', 'US'), child: Text('🇺🇸 EN-US')),
            ],
          ),
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: child,
    );
  }
}
