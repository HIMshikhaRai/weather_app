import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_report/models/weather_response.dart';
import 'package:weather_report/utils/custom_date_utils.dart';
import 'package:weather_report/utils/status_enum.dart';
import 'package:weather_report/utils/string_constants.dart';
import 'package:weather_report/utils/suitable_icon.dart';
import 'package:weather_report/view_models/weather_view_model.dart';
import 'package:weather_report/views/animation/animated_list_view.dart';
import 'package:weather_report/views/animation/text_slide_animation.dart';
import 'package:weather_report/views/weather_time_item_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<WeatherViewModel>(
          builder: (ctx, provider, child) {
            return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext ctx, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      leading: Image.asset(
                        "assets/app_icon.jpg",
                        opacity: const AlwaysStoppedAnimation(.4),
                      ),
                      pinned: false,
                      expandedHeight: 0,
                      floating: true,
                      flexibleSpace: const FlexibleSpaceBar(
                        title: Text(appName),
                        centerTitle: true,
                      ),
                    )
                  ];
                },
                body: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _cityController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (val) {
                              return _isValid(val);
                            },
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (val) => _searchClick(),
                            style: Theme.of(context).textTheme.headlineLarge,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xffC9BBEE),
                              hintText: enterCity,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              suffixIcon: InkWell(
                                onTap: () => _searchClick(),
                                child: Container(
                                  height: 48,
                                  // margin: EdgeInsets.only(bottom: 24),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: const Icon(
                                    Icons.search,
                                    size: 32,
                                  ),
                                ),
                              ),
                              errorStyle: const TextStyle(color: Colors.red),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _getResult(provider),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }

  String? _isValid(String? val) {
    String? errorMsg;
    if (val?.isEmpty ?? false) {
      return cityFieldEmptyErrorMsg;
    }
    if ((val?.isNotEmpty ?? false) && val!.length < 4) {
      return cityFieldLengthErrorMsg;
    }
    return errorMsg;
  }

  _searchClick() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      WeatherViewModel weatherViewModel =
          Provider.of<WeatherViewModel>(context, listen: false);
      weatherViewModel.getWeather(_cityController.text.trim()).then((value) {
        if (weatherViewModel.status == Status.success) {
          _showSnackBar(forecastSuccessMsg);
        } else {
          _showSnackBar(weatherViewModel.dataError!.message, type: "error");
        }
      });
    }
  }

  _showSnackBar(String msg, {String type = "info"}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
      ),
      backgroundColor: type == "info" ? Colors.green : Colors.red,
    ));
  }

  Widget _getResult(WeatherViewModel provider) {
    if (provider.status == Status.loading) {
      return Center(
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: const CircularProgressIndicator()));
    } else {
      if (provider.weatherResponse != null) {
        return Column(
          children: [
            Container(
              color: const Color(0xffdcd8f5),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextSlideAnimation(
                textWidget: Text(
                  "Result for search ${_cityController.text.trim()}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).primaryColor, fontSize: 28),
                ),
              ),
            ),
            if (provider.todayForecast.isNotEmpty)
              Container(
                color: const Color(0xffdcd8f5),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(28),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xff5927e5).withOpacity(0.60),
                                  const Color(0xff362b48)
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 128,
                                    height: 80,
                                  ),
                                  TextSlideAnimation(
                                    textWidget: Text(
                                      "${CustomDateUtils().getTempInCel(provider.todayForecast.first.main?.temp ?? 32)} °C",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextSlideAnimation(
                                    textWidget: Text(
                                      "${provider.todayForecast.first.weather?.first.main}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      TextSlideAnimation(
                                        textWidget: Text(
                                          CustomDateUtils().getDateTime(provider
                                              .todayForecast.first.dtTxt!),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ),
                                      const Spacer(),
                                      TextSlideAnimation(
                                        textWidget: Text(
                                          today,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -30,
                          left: 30,
                          child: Image.asset(
                            SuitableIcon().getIcon(provider.todayForecast.first
                                    .weather?.first.description ??
                                Description.clearSky),
                            height: 128,
                            width: 128,
                          ),
                        ),
                      ],
                    ),
                    (() {
                      if (provider.todayForecast.length > 1) {
                        provider.todayForecast.removeAt(0);
                        return Container(
                          height: 150,
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: provider.todayForecast.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext ctx, int index) {
                                return WeatherTimeItemWidget(
                                    provider.todayForecast[index]);
                              }),
                        );
                      }
                      return Container();
                    }())
                  ],
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(top: 16),
              child: Column(
                children: provider.allWeatherForecast?.entries
                        .map((e) => AnimatedListViewItem(
                              e.key,
                              e.value,
                              duration: 2,
                            ))
                        .toList() ??
                    [],
              ),
            ),
          ],
        );
      }
      return Container();
    }
  }
}
