class OnboardingContent {
  String image;
  String title;
  String description;
  OnboardingContent({required this.description,required this.image,required this.title});
}
List<OnboardingContent>contents=[
  OnboardingContent(description: 'Where fresh is your taste', image: 'android/assets/images/screen2.png', title: 'Welcome to Soko-Fresh'),
    OnboardingContent(description: 'and connect with them', image: 'android/assets/images/farmeron.jpg', title: 'Search to find your farmer'),
    OnboardingContent(description: 'Because you love fresh', image: 'android/assets/images/happy.jpg', title: 'Enjoy our app')

];