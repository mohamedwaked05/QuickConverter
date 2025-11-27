// This file defines the Currency data model class
// A model class represents the structure of currency data in our app

class Currency {
  // Currency code like USD, EUR, GBP
  final String code;
  
  // Full currency name like US Dollar, Euro
  final String name;
  
  // Currency symbol like $, €, £
  final String symbol;
  
  // Exchange rate relative to 1 USD
  // Example: EUR rate 0.87 means 1 USD = 0.87 EUR
  final double rateToUSD;

  // Constructor - creates a Currency object with required properties
  // All fields are marked as required to ensure we always have complete data
  Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.rateToUSD,
  });
}