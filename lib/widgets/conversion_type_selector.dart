import 'package:flutter/material.dart';
import '../constants/conversion_type.dart';

class ConversionTypeSelector extends StatelessWidget {
  final ConversionType selectedType;
  final ValueChanged<ConversionType?> onChanged;

  const ConversionTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Conversion Type:',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            children: [
              RadioListTile<ConversionType>(
                title: const Text('Fahrenheit to Celsius (°F → °C)'),
                subtitle: const Text('°C = (°F - 32) × 5/9'),
                value: ConversionType.fahrenheitToCelsius,
                groupValue: selectedType,
                onChanged: onChanged,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              Divider(
                height: 1,
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
              ),
              RadioListTile<ConversionType>(
                title: const Text('Celsius to Fahrenheit (°C → °F)'),
                subtitle: const Text('°F = °C × 9/5 + 32'),
                value: ConversionType.celsiusToFahrenheit,
                groupValue: selectedType,
                onChanged: onChanged,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
