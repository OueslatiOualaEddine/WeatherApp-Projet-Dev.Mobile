import 'package:flutter/material.dart';
import 'package:weatherapp/models/city.dart';
import 'package:weatherapp/models/constants.dart';
import 'package:weatherapp/ui/home.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    List<City> allCities = City.citiesList.where((city) => city.isDefault == false).toList();
    List<City> nonFavoriteCities = allCities.where((city) => !city.isFavorite).toList();
    List<City> favoriteCities = City.getFavoriteCities();
    List<City> selectedCities = City.getSelectedCities();

    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: myConstants.secondaryColor,
        foregroundColor: Colors.white,
        title: Text('${selectedCities.length} City(ies) Selected'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          if (favoriteCities.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only( top: 20, left: 20 ),
                  child: Text(
                    'Favorite Cities',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: myConstants.primaryColor,
                    ),
                  ),
                ),
                Divider(),
                ...favoriteCities.map((city) => _buildCityRow(city, size, myConstants)).toList(),
              ],
            ),
          Padding(
            padding: const EdgeInsets.only( top: 20, left: 20 ),
            child: Text(
              'All Cities',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: myConstants.primaryColor,
              ),
            ),
          ),
          Divider(),
          ...nonFavoriteCities.map((city) => _buildCityRow(city, size, myConstants)).toList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myConstants.secondaryColor,
        child: const Icon(Icons.pin_drop),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        },
      ),
    );
  }

  Widget _buildCityRow(City city, Size size, Constants myConstants) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: size.height * .08,
      width: size.width,
      decoration: BoxDecoration(
        border: city.isSelected == true
            ? Border.all(
          color: myConstants.secondaryColor.withOpacity(.6),
          width: 2,
        )
            : Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: myConstants.primaryColor.withOpacity(.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    city.isSelected = !city.isSelected;
                  });
                },
                child: Image.asset(
                  city.isSelected ? 'assets/checked.png' : 'assets/unchecked.png',
                  width: 30,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${city.city}, ${city.country}',
                style: TextStyle(
                  fontSize: 16,
                  color: city.isSelected ? myConstants.primaryColor : Colors.black54,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                city.isFavorite = !city.isFavorite;
              });
            },
            child: Image.asset(
              city.isFavorite ? 'assets/favorite.png' : 'assets/normal.png',
              width: 30,
            ),
          ),
        ],
      ),
    );
  }
}
