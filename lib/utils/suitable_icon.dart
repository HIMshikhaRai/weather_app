import 'package:weather_report/models/weather_response.dart';

class SuitableIcon {
  String getIcon(Description description) {
    String iconPath = "";
    switch(description){
      case Description.scatteredClouds:
        iconPath = "assets/scattered_cloud_icon.png";
        break;
      case Description.brokenClouds:
        iconPath = "assets/broken_cloud_icon.png";
        break;
      case Description.fewClouds:
        iconPath = "assets/few_clouds_icon.png";
        break;
      case Description.clearSky:
        iconPath = "assets/clear_sky_icon.png";
        break;
      case Description.overcastClouds:
        iconPath = "assets/overcast_cloud_icon.png";
        break;
      case Description.lightRain:
        iconPath = "assets/light_rain_icon.png";
        break;
    }
    return iconPath;
  }
}