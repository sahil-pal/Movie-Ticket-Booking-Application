import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../config/themes/mytheme.dart';

class OffersCarousel extends StatelessWidget {
  
  List<String> slideImagesURL = [
    'assets/carousel/offer1.jpeg',
    'assets/carousel/offer2.jpeg',
    'assets/carousel/offer3.jpeg',
    'assets/carousel/offer4.jpeg',
    'assets/carousel/offer5.jpeg',
  ];

  OffersCarousel();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180.0,
        autoPlayAnimationDuration: Duration(seconds: 10),
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        autoPlay: true,
        //enlargeCenterPage: true
      ),
      items: slideImagesURL.map((imageURL) {
        double devicewidth = MediaQuery.of(context).size.width;
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Container(
                  width: devicewidth,
                  margin: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 2),
                  decoration: const BoxDecoration(
                    color: MyTheme.splash
                  ),
                  child: Image.asset(imageURL,height: 180,fit: BoxFit.fill,)
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: MyTheme.splash.withOpacity(0.8),
                      
                    ),
                    onPressed: (){},
                    child: Text('View Offer'.toUpperCase(),style: const TextStyle(fontSize: 12),),
                  ),
                )

              ]
            );
          },
        );
      }).toList(),
    );
  }
}