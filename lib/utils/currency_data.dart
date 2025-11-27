import '../models/currency.dart';

// This utility class provides currency data and conversion functions
// It acts as our database for currency exchange rates

class CurrencyData {
  // Static list of predefined currencies with their exchange rates
  // This is our app's currency database - all rates are relative to USD
  static final List<Currency> currencies = [
    // Base currency - USD with rate 1.0 since it's our reference
    Currency(code: 'USD', name: 'US Dollar', symbol: '\$', rateToUSD: 1.0),
    
    // Other currencies with their conversion rates to USD
    Currency(code: 'EUR', name: 'Euro', symbol: '€', rateToUSD: 0.87),
    Currency(code: 'GBP', name: 'British Pound', symbol: '£', rateToUSD: 0.73),
    Currency(code: 'JPY', name: 'Japanese Yen', symbol: '¥', rateToUSD: 110.8),
    Currency(code: 'CAD', name: 'Canadian Dollar', symbol: '\$', rateToUSD: 1.25),
    Currency(code: 'AUD', name: 'Australian Dollar', symbol: '\$', rateToUSD: 1.35),
    Currency(code: 'CHF', name: 'Swiss Franc', symbol: 'Fr', rateToUSD: 0.92),
    Currency(code: 'CNY', name: 'Chinese Yuan', symbol: '¥', rateToUSD: 6.45),
    Currency(code: 'INR', name: 'Indian Rupee', symbol: '₹', rateToUSD: 74.5),
    
    // Lebanese Pound has very high rate due to economic situation bya3rif
    Currency(code: 'LBP', name: 'Lebanese Pound', symbol: 'ل.ل', rateToUSD: 89500.0),
    // kmrel chris
    Currency(code: 'NOK', name: 'Norwegian Krone', symbol: 'kr', rateToUSD: 10.23),
  ];

  // Converts an amount from one currency to another
  // Uses USD as intermediate currency for conversion
  static double convert(double amount, Currency from, Currency to) {
    // First convert the amount to USD equivalent
    double amountInUSD = amount / from.rateToUSD;
    
    // Then convert from USD to the target currency
    return amountInUSD * to.rateToUSD;
  }
}