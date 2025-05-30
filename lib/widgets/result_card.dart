import 'package:flutter/material.dart';
import '../constants/conversion_type.dart';

class ResultCard extends StatelessWidget {
  final double? convertedValue;
  final String inputValue;
  final ConversionType conversionType;
  final Animation<double> scaleAnimation;

  const ResultCard({
    super.key,
    required this.convertedValue,
    required this.inputValue,
    required this.conversionType,
    required this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    if (convertedValue == null) {
      return const SizedBox.shrink();
    }

    final inputUnit = conversionType == ConversionType.fahrenheitToCelsius ? '°F' : '°C';
    final outputUnit = conversionType == ConversionType.fahrenheitToCelsius ? '°C' : '°F';

    return ScaleTransition(
      scale: scaleAnimation,
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(
                Icons.thermostat,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                'Conversion Result',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '$inputValue $inputUnit',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  '${convertedValue!.toStringAsFixed(2)}$outputUnit',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}