import '../constants/conversion_type.dart';

class TemperatureValidator {
  static String? validateTemperatureInput(String? value, ConversionType conversionType) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a temperature value';
    }
    
    final numericValue = double.tryParse(value.trim());
    if (numericValue == null) {
      return 'Please enter a valid number';
    }
    
    // Check for extreme temperature values (basic validation)
    if (conversionType == ConversionType.fahrenheitToCelsius) {
      if (numericValue < -459.67) {
        return 'Temperature cannot be below absolute zero (-459.67°F)';
      }
    } else {
      if (numericValue < -273.15) {
        return 'Temperature cannot be below absolute zero (-273.15°C)';
      }
    }
    
    return null;
  }
}