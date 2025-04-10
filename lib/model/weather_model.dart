class WeatherModel {
  final String location;
  final double temparature;
  final String mainCondition;

  WeatherModel({
    required this.location,
    required this.temparature,
    required this.mainCondition,
  });
  /*
The method you are referring to is called fromJson. It is a factory constructor, meaning it is used to create an instance of the Weather class from JSON data. A regular constructor (Weather(...)) directly initializes an object.

A factory constructor (Weather.fromJson(...)) processes the input data (like a JSON map) before creating an object and can can return existing objects.
call it like this:   Weather weather = Weather.fromJson(jsonData);

Can use normal constructor but here we are modifying the values before . 

*/
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json['name'],
      temparature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}
