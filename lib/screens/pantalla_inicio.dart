import 'package:flutter/material.dart';
import 'pantalla_estadisticas.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_car_wash, size: 100, color: theme.primaryColor),
              const SizedBox(height: 24),
              Text(
                'Lava App',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.hintColor,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PantallaEstadisticas(),
                    ),
                  );
                },
                icon: const Icon(Icons.login),
                label: const Text('Ingresar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
