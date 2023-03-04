import 'package:flutter/material.dart';
import 'package:newsapp/modules/shop_app/login/shop_login_screen.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<boarding> boardingModel = [
    boarding(
      title: 'Step 1',
      image: 'assets/images/on_board1.png',
      body:
          'Log in to the Antar store to learn about our distinguished products and our beautiful prices',
    ),
    boarding(
      title: 'Step 2',
      image: 'assets/images/on_baord_2.jpg',
      body:
          'After logging in now, you can browse all the products you want to get and add them to the cart',
    ),
    boarding(
      title: 'Step 3',
      image: 'assets/images/on_board_3.jpeg',
      body:
          'Now, after adding the product to the cart, all you have to do is fill in your data and wait for the product to come to you',
    ),
  ];

  bool isLast = false;
  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if(value)
      {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ShopLoginScreen(),
            ),
                (route) => false);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(
              'SKIP',
              style: TextStyle(
                color: defaultColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (int index) {
                  if (index == boardingModel.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    builedBoardingItem(boardingModel[index]),
                itemCount: boardingModel.length,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  effect: CustomizableEffect(
                    dotDecoration: DotDecoration(
                      width: 24,
                      height: 12,
                      color: Colors.grey,
                      verticalOffset: 0,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    activeDotDecoration: DotDecoration(
                      width: 32,
                      height: 12,
                      color: defaultColor,
                      rotationAngle: 180,
                      verticalOffset: -10,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  count: boardingModel.length,
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: defaultColor,
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget builedBoardingItem(boarding model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                '${model.image}',
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      );
}

class boarding {
  final String title;
  final String image;
  final String body;
  boarding({required this.title, required this.image, required this.body});
}
