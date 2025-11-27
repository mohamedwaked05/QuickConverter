import 'package:flutter/material.dart';
import '../models/currency.dart';
import '../utils/currency_data.dart';

// Custom dropdown widget for currency selection
// Displays currency symbol, code, and name in a nice format

class CurrencyDropdown extends StatelessWidget {
  // The currently selected currency to display
  final Currency selectedCurrency;
  
  // Callback function when user selects a different currency
  final Function(Currency) onChanged;

  const CurrencyDropdown({
    super.key,
    required this.selectedCurrency,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,  // White background
        borderRadius: BorderRadius.circular(12),  // Rounded corners
        border: Border.all(color: Colors.grey[300]!),  // Light grey border
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),  // Subtle shadow
            blurRadius: 4,
            offset: const Offset(0, 2),  // Shadow below the container
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(  // Hides the default underline
        child: DropdownButton<Currency>(
          isExpanded: true,  // Expands to fill available width
          value: selectedCurrency,  // Currently selected value
          icon: Icon(Icons.arrow_drop_down, color: Colors.blue[700]),  // Custom dropdown arrow
          elevation: 4,  // Shadow for dropdown menu
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
          borderRadius: BorderRadius.circular(12),  // Rounded dropdown menu
          
          // Creates dropdown items for each currency in our data
          items: CurrencyData.currencies.map((currency) {
            return DropdownMenuItem<Currency>(
              value: currency,  // The currency object this item represents
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    // Circular container showing currency symbol
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],  // Light blue circle
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          currency.symbol,  // Currency symbol like $, €
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),  // Space between symbol and text
                    
                    // Text information: code and name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Currency code (USD, EUR, etc.)
                        Text(
                          currency.code,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        // Full currency name
                        Text(
                          currency.name,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],  // Grey secondary text
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),  // Convert the map result to a list
          
          // Called when user selects a different currency
          onChanged: (value) => onChanged(value!),
        ),
      ),
    );
  }
}