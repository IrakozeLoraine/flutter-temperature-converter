/// Converts Fahrenheit to Celsius using the formula: °C = (°F - 32) × 5/9
double fahrenheitToCelsius(double fahrenheit) {
  return (fahrenheit - 32) * 5 / 9;
}

/// Converts Celsius to Fahrenheit using the formula: °F = °C × 9/5 + 32
double celsiusToFahrenheit(double celsius) {
  return celsius * 9 / 5 + 32;
}
