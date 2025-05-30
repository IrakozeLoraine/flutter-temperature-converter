import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temperature_converter/widgets/clear_history.dart';
import '../constants/conversion_formulas.dart';
import '../constants/conversion_type.dart';
import '../models/conversion_history.dart';
import '../utils/animations.dart';
import '../widgets/conversion_card.dart';
import '../widgets/result_card.dart';
import '../widgets/history_section.dart';

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  State<TemperatureConverterScreen> createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen>
    with TickerProviderStateMixin {
  
  final TextEditingController _temperatureController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  ConversionType _selectedConversionType = ConversionType.fahrenheitToCelsius;
  double? _convertedValue;
  final List<ConversionHistory> _conversionHistory = [];
  
  late AnimationController _resultAnimationController;
  late Animation<double> _resultScaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _resultAnimationController = AnimationHelper.createResultAnimationController(this);
    _resultScaleAnimation = AnimationHelper.createResultScaleAnimation(_resultAnimationController);
  }

  @override
  void dispose() {
    _temperatureController.dispose();
    _resultAnimationController.dispose();
    super.dispose();
  }

  void _performConversion() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final inputText = _temperatureController.text.trim();
    final inputValue = double.tryParse(inputText);

    if (inputValue == null) {
      _showErrorSnackBar('Please enter a valid number');
      return;
    }

    double convertedValue;
    switch (_selectedConversionType) {
      case ConversionType.fahrenheitToCelsius:
        convertedValue = fahrenheitToCelsius(inputValue);
        break;
      case ConversionType.celsiusToFahrenheit:
        convertedValue = celsiusToFahrenheit(inputValue);
        break;
    }

    setState(() {
      _convertedValue = convertedValue;
      _conversionHistory.insert(
        0,
        ConversionHistory(
          type: _selectedConversionType,
          inputValue: inputValue,
          outputValue: convertedValue,
          timestamp: DateTime.now(),
        ),
      );
    });

    _resultAnimationController.forward();
    HapticFeedback.lightImpact();
    _temperatureController.clear();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _clearHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ClearHistory(onHistoryCleared: () {
          setState(() {
            _conversionHistory.clear();
            _convertedValue = null;
          });
          _resultAnimationController.reset();
          Navigator.of(context).pop();
          HapticFeedback.mediumImpact();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temperature Converter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_conversionHistory.isNotEmpty)
            IconButton(
              onPressed: _clearHistory,
              icon: const Icon(Icons.clear_all),
              tooltip: 'Clear History',
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConversionCard(
                formKey: _formKey,
                temperatureController: _temperatureController,
                selectedConversionType: _selectedConversionType,
                onConversionTypeChanged: (ConversionType? value) {
                  setState(() {
                    _selectedConversionType = value!;
                    _convertedValue = null;
                  });
                  _resultAnimationController.reset();
                },
                onConvert: _performConversion,
              ),
              const SizedBox(height: 24),
              ResultCard(
                convertedValue: _convertedValue,
                inputValue: _temperatureController.text,
                conversionType: _selectedConversionType,
                scaleAnimation: _resultScaleAnimation,
              ),
              const SizedBox(height: 24),
              HistorySection(
                conversionHistory: _conversionHistory,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
