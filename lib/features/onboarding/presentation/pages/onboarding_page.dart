import 'package:flutter/material.dart';
import 'package:mealmate/core/ui/assets_paths.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/theme/text_styles.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/auth/presentation/pages/signup_page.dart';
import 'package:mealmate/features/onboarding/presentation/widgets/custom_intro_paint.dart';
import 'package:mealmate/features/onboarding/presentation/widgets/intro_indicator.dart';
import 'package:mealmate/features/onboarding/presentation/widgets/slide.dart';

class OnboardingPage extends StatelessWidget {
  final List<Widget> _pages = [
    Slide(
      placeImage: true,
      image: Image.asset(
        SvgPath.intro1,
      ),
    ),
    Slide(
      placeImage: true,
      image: Image.asset(SvgPath.intro2),
    ),
    Slide(
      placeImage: false,
      image: Image.asset(SvgPath.intro3),
    )
  ];
  final List<Map<String, String>> texts = [
    {'title': 'Order Ingredients', 'description': 'Order the ingredients you need quickly with a fast proccess'},
    {'title': 'Let\'s Cooking', 'description': 'Cooking based on the food recipes you find and  the food you love'},
    {'title': 'All recipes you needed', 'description': '5000+ healthy recipes made by people for your healthy life'}
  ];

  OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Intro(
      pages: _pages,
      texts: texts,
      isCircle: true,
    );
  }
}

class Intro extends StatefulWidget {
  final List<Widget> pages;
  final List texts;

  final bool isCircle;

  const Intro({Key? key, required this.pages, required this.texts, required this.isCircle}) : super(key: key);
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  List<Widget>? _pages;
  final ValueNotifier<int> _selectedItem = ValueNotifier(0);
  List? texts;
  late PageController _controllerPageView;

  @override
  void initState() {
    _pages = widget.pages;
    texts = widget.texts;
    _controllerPageView = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerPageView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 112, 185, 190),
      body: SafeArea(
        child: CustomPaint(
          painter: RPSCustomPainter(),
          size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
          child: ValueListenableBuilder(
            valueListenable: _selectedItem,
            builder: (context, value, child) {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: value != _pages!.length - 1
                          ? TextButton(
                              onPressed: () {
                                _controllerPageView.animateToPage(_pages!.length,
                                    duration: const Duration(seconds: 1), curve: Curves.ease);
                              },
                              child: const Text('Skip'),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: _controllerPageView,
                      onPageChanged: (index) {
                        _selectedItem.value = index;

                        if (index > _pages!.length - 2) {}
                      },
                      children: _pages!,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IntroIndicator(
                      isCircle: widget.isCircle,
                      index: value,
                      pageNumber: _pages!.length,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: IntroBottomContainer(
                      title: texts![value]['title'],
                      buttonText: value != _pages!.length - 1 ? 'next' : 'Get Started',
                      description: texts![value]['description'],
                      onPressed: () {
                        _controllerPageView.animateToPage(_selectedItem.value + 1,
                            duration: const Duration(seconds: 1), curve: Curves.ease);
                        if (_controllerPageView.page!.ceil() == _pages!.length - 1) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const SignUpPage();
                          }));
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class IntroBottomContainer extends StatelessWidget {
  const IntroBottomContainer({
    super.key,
    required this.description,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });

  final String title;
  final String buttonText;
  final String description;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title, style: AppTextStyles.styleWeight700(fontSize: 20)),
          Text(
            description,
            style: AppTextStyles.styleWeight400(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          MainButton(
            width: MediaQuery.of(context).size.width,
            text: buttonText,
            color: AppColors.buttonColor,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}