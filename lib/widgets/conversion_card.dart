import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/conversion_type.dart';
import '../utils/validators.dart';
import 'conversion_type_selector.dart';

class ConversionCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController temperatureController;
  final ConversionType selectedConversionType;
  final ValueChanged<ConversionType?> onConversionTypeChanged;
  final VoidCallback onConvert;

  const ConversionCard({
    super.key,
    required this.formKey,
    required this.temperatureController,
    required this.selectedConversionType,
    required this.onConversionTypeChanged,
    required this.onConvert,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Convert Temperature',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ConversionTypeSelector(
                selectedType: selectedConversionType,
                onChanged: onConversionTypeChanged,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: temperatureController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
                ],
                decoration: InputDecoration(
                  labelText: 'Enter temperature value',
                  hintText: 'e.g., 32.0',
                  suffixText: selectedConversionType == ConversionType.fahrenheitToCelsius ? '°F' : '°C',
                  prefixIcon: const Icon(Icons.thermostat),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  errorMaxLines: 3,
                  fillColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.3),
                ),
                validator: (value) => TemperatureValidator.validateTemperatureInput(value, selectedConversionType),
                onFieldSubmitted: (_) => onConvert(),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onConvert,
                icon: const Icon(Icons.calculate, size: 24),
                label: const Text(
                  'Convert',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
