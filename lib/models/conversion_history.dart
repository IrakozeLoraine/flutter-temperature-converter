import 'package:temperature_converter/constants/conversion_type.dart';

class ConversionHistory {
  final ConversionType type;
  final double inputValue;
  final double outputValue;
  final DateTime timestamp;

  ConversionHistory({
    required this.type,
    required this.inputValue,
    required this.outputValue,
    required this.timestamp,
  });

  /// Returns a formatted string representation of the conversion
  String get formattedConversion {
    switch (type) {
      case ConversionType.fahrenheitToCelsius:
        return 'F to C: ${inputValue.toStringAsFixed(1)} => ${outputValue.toStringAsFixed(1)}';
      case ConversionType.celsiusToFahrenheit:
        return 'C to F: ${inputValue.toStringAsFixed(1)} => ${outputValue.toStringAsFixed(1)}';
    }
  }

  String get inputUnit {
    return type == ConversionType.fahrenheitToCelsius ? '°F' : '°C';
  }

  String get outputUnit {
    return type == ConversionType.fahrenheitToCelsius ? '°C' : '°F';
  }
}