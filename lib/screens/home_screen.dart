import 'package:flutter/material.dart';
import '../models/currency.dart';
import '../utils/currency_data.dart';
import '../widgets/currency_dropdown.dart';

// Main screen of the app - handles currency conversion UI and logic
// Stateful widget because we need to manage changing amounts and currencies

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // The amount user wants to convert - starts with 1.0 as default
  double amount = 1.0;
  
  // The calculated converted amount
  double convertedAmount = 0.0;
  
  // Source currency - starts with first currency in list (USD)
  Currency fromCurrency = CurrencyData.currencies.first;
  
  // Target currency - starts with second currency in list (EUR)
  Currency toCurrency = CurrencyData.currencies[1];

  // Called when the screen is first created
  // We calculate initial conversion so screen shows values immediately
  @override
  void initState() {
    super.initState();
    _calculateConversion();
  }

  // Calculates the converted amount and updates the UI
  void _calculateConversion() {
    setState(() {
      // Use our CurrencyData utility to perform the conversion
      convertedAmount = CurrencyData.convert(amount, fromCurrency, toCurrency);
    });
  }

  // Swaps the from and to currencies when user presses swap button
  void _swapCurrencies() {
    setState(() {
      // Temporary variable to hold fromCurrency during swap
      final temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
      
      // Recalculate conversion with swapped currencies
      _calculateConversion();
    });
  }

  // Builds the entire UI layout for the home screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Light grey background for the whole screen
      backgroundColor: Colors.grey[50],
      
      // App bar with app title and styling
      appBar: AppBar(
        title: const Text(
          "QuickConvert",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,  // Center the title text
        backgroundColor: Colors.blue[700],  // Dark blue background
        elevation: 0,  // Remove shadow
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),  // Rounded bottom corners
          ),
        ),
      ),
      
      // Scrollable content area
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),  // Space around all content
          child: Column(
            children: [
              // ===== AMOUNT INPUT CARD =====
              Card(
                elevation: 4,  // Shadow effect
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),  // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,  // Left-align content
                    children: [
                      // Section title
                      Text(
                        "Amount to Convert",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,  // Medium weight
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 12),  // Space between title and input
                      
                      // Text input field for amount
                      TextField(
                        keyboardType: TextInputType.numberWithOptions(decimal: true),  // Number keyboard with decimal
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,  // Large bold numbers
                        ),
                        decoration: InputDecoration(
                          hintText: "0.00",  // Placeholder text
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,  // No border line
                          ),
                          filled: true,  // Fill with background color
                          fillColor: Colors.grey[100],  // Light grey background
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(left: 12, right: 8),
                            child: Text(
                              fromCurrency.symbol,  // Show currency symbol like $
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        // Called every time user types in the field
                        onChanged: (value) {
                          // Convert text to number, use 0 if invalid
                          amount = double.tryParse(value) ?? 0;
                          // Recalculate conversion with new amount
                          _calculateConversion();
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),  // Space between cards

              // ===== CURRENCY SELECTION CARD =====
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Horizontal row for From/To currencies and swap button
                      Row(
                        children: [
                          // FROM CURRENCY SELECTION
                          Expanded(  // Takes available horizontal space
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "From",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Custom dropdown for selecting source currency
                                CurrencyDropdown(
                                  selectedCurrency: fromCurrency,
                                  onChanged: (Currency newCurrency) {
                                    setState(() {
                                      fromCurrency = newCurrency;
                                      _calculateConversion();  // Update conversion
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),  // Space between from and swap
                          
                          // SWAP BUTTON
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: IconButton(
                              onPressed: _swapCurrencies,  // Calls swap function
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.blue[50],  // Light blue background
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: Icon(
                                Icons.swap_vert,
                                color: Colors.blue[700],
                                size: 24,
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 16),  // Space between swap and to
                          
                          // TO CURRENCY SELECTION  
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "To",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Custom dropdown for selecting target currency
                                CurrencyDropdown(
                                  selectedCurrency: toCurrency,
                                  onChanged: (Currency newCurrency) {
                                    setState(() {
                                      toCurrency = newCurrency;
                                      _calculateConversion();  // Update conversion
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),  // Space before result card

              // ===== CONVERSION RESULT CARD =====
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.blue[50],  // Light blue background
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Result title
                      Text(
                        "Converted Amount",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Main result display with symbol and amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,  // Align text baselines
                        children: [
                          // Target currency symbol
                          Text(
                            toCurrency.symbol,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(width: 4),  // Small space between symbol and amount
                          
                          // Converted amount (formatted to 2 decimal places)
                          Text(
                            convertedAmount.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 36,  // Large font for emphasis
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      // Target currency code below the amount
                      Text(
                        toCurrency.code,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),  // Space before conversion rate info

              // ===== CONVERSION RATE INFORMATION =====
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],  // Medium blue background
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Shows the direct conversion rate between the two currencies
                    Text(
                      "1 ${fromCurrency.code} = ${(1 / fromCurrency.rateToUSD * toCurrency.rateToUSD).toStringAsFixed(4)} ${toCurrency.code}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}