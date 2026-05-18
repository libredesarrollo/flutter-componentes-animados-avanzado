import 'package:flutter/material.dart';
import 'main.dart'; // Para acceder a MyApp.of

class AccessibilityThemePage extends StatelessWidget {
  const AccessibilityThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accesibilidad y Tema'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Accesibilidad (Semantics)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'El siguiente elemento está optimizado para lectores de pantalla:',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const ThemePreviewCard(),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Control de Tema',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Tema del sistema'),
              leading: const Icon(Icons.brightness_auto),
              onTap: () => MyApp.of(context).setThemeMode(ThemeMode.system),
            ),
            ListTile(
              title: const Text('Tema claro'),
              leading: const Icon(Icons.brightness_high),
              onTap: () => MyApp.of(context).setThemeMode(ThemeMode.light),
            ),
            ListTile(
              title: const Text('Tema oscuro'),
              leading: const Icon(Icons.brightness_4),
              onTap: () => MyApp.of(context).setThemeMode(ThemeMode.dark),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemePreviewCard extends StatelessWidget {
  const ThemePreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Semantics(
      label: 'Vista previa del tema ${isDark ? "oscuro" : "claro"}',
      child: Card(
        elevation: isDark ? 4 : 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isDark ? Icons.nights_stay : Icons.wb_sunny,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Tema ${isDark ? "Oscuro" : "Claro"} activo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Este es un ejemplo de texto con el tema actual. El contraste debe ser legible tanto de día como de noche.',
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  Chip(
                    label: const Text('Primary'),
                    backgroundColor: colorScheme.primaryContainer,
                    labelStyle: TextStyle(color: colorScheme.onPrimaryContainer),
                  ),
                  Chip(
                    label: const Text('Secondary'),
                    backgroundColor: colorScheme.secondaryContainer,
                    labelStyle: TextStyle(color: colorScheme.onSecondaryContainer),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
