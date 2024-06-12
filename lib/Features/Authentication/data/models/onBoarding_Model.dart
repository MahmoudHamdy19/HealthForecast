import '../../../../Core/Utils/Assets Manager.dart';

class BoardingModel {
  final String image;
  final String title;
  final String subtitle;
  final bool isShow;
  final double rate;

  BoardingModel(
      {required this.title,
      required this.image,
      required this.subtitle,
      required this.isShow,
      required this.rate});
}

List<BoardingModel> boarding = [
  BoardingModel(
      title: "What is HealthForecast?",
      image: AssetsManager.onBoarding1,
      isShow: false,
      rate: 0.35,
      subtitle:
          "HealthForecast is a comprehensive health application designed to empower users with proactive insights into their heart and diabetes risks."),
  BoardingModel(
      title: "Diagnosis Limits",
      isShow: false,
      rate: 0.65,
      image:AssetsManager.onBoarding2,
      subtitle:
          "The AI model tends to make a high confidence decision about the questions answered to classify your disease."),
  BoardingModel(
      title: "No Payments Requiered",
      isShow: true,
      rate: 1,
      image: AssetsManager.onBoarding3,
      subtitle:
          "You do not have to pay anything for the services provided. From three categories, choose the category you are targeting, answer the questions, and you will receive the results in one second."),
];
