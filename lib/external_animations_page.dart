import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

class ExternalAnimationsPage extends StatefulWidget {
  const ExternalAnimationsPage({super.key});

  @override
  State<ExternalAnimationsPage> createState() => _ExternalAnimationsPageState();
}

class _ExternalAnimationsPageState extends State<ExternalAnimationsPage> with SingleTickerProviderStateMixin {
  late final AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lottie y Rive'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lottie: Animación desde JSON',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Cargando desde URL (puede tardar un momento en aparecer):',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Center(
              child: Lottie.network(
                'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',
                height: 200,
                controller: _lottieController,
                onLoaded: (composition) {
                  _lottieController.duration = composition.duration;
                  _lottieController.repeat(); // Auto play and repeat
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error_outline, size: 48, color: Colors.red);
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _lottieController.forward(),
                  child: const Text('Play'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _lottieController.stop(),
                  child: const Text('Pausar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _lottieController.reset(),
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Rive: Animación Vectorial Interactiva',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Cargando desde URL:',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 200,
              child: RiveAnimation.network(
                'https://cdn.rive.app/animations/vehicles.riv',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nota: Los ejemplos interactivos complejos de Rive requieren archivos específicos con State Machines configuradas.',
              style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
