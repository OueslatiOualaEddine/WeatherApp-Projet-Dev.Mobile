class City{
  bool isSelected;
  final String city;
  final String country;
  final bool isDefault;

  City({required this.isSelected, required this.city, required this.country, required this.isDefault});

  // List of Cities data
  static List<City> citiesList = [
    City(
        isSelected: false,
        city: 'Abu Dhabi',
        country: 'United Arab Emirates',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Accra',
        country: 'Ghana',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Addis Ababa',
        country: 'Ethiopia',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Algiers',
        country: 'Algeria',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Amsterdam',
        country: 'Netherlands',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Amman',
        country: 'Jordan',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Bangkok',
        country: 'Thailand',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Barcelona',
        country: 'Spain',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Beijing',
        country: 'China',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Berlin',
        country: 'Germany',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Brussels',
        country: 'Belgium',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Buenos Aires',
        country: 'Argentina',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Cairo',
        country: 'Egypt',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Casablanca',
        country: 'Morocco',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Delhi',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Doha',
        country: 'Qatar',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Dubai',
        country: 'United Arab Emirates',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Istanbul',
        country: 'Turkey',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Jeddah',
        country: 'Saudi Arabia',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Khartoum',
        country: 'Sudan',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Kuwait City',
        country: 'Kuwait',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Lagos',
        country: 'Nigeria',
        isDefault: false),
    City(
        isSelected: false,
        city: 'London',
        country: 'United Kingdom',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Manama',
        country: 'Bahrain',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Miami',
        country: 'United States',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Moscow',
        country: 'Russia',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Mumbai',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Muscat',
        country: 'Oman',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Nairobi',
        country: 'Kenya',
        isDefault: false),
    City(
        isSelected: false,
        city: 'New York',
        country: 'United States',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Paris',
        country: 'France',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Rabat',
        country: 'Morocco',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Riyadh',
        country: 'Saudi Arabia',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Rome',
        country: 'Italy',
        isDefault: false),
    City(
        isSelected: false,
        city: 'São Paulo',
        country: 'Brazil',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Seoul',
        country: 'South Korea',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Shanghai',
        country: 'China',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Sydney',
        country: 'Australia',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Tunis',
        country: 'Tunisia',
        isDefault: true),
    City(
        isSelected: false,
        city: 'Tokyo',
        country: 'Japan',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Toronto',
        country: 'Canada',
        isDefault: false),
  ];


  //Get the selected cities
  static List<City> getSelectedCities(){
    List<City> selectedCities = City.citiesList;
    return selectedCities
        .where((city) => city.isSelected == true)
        .toList();
  }
}






















