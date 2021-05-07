import 'package:flutter/material.dart';

import '../slider.dart';

class FeaturedAdsSliderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Featured ads in cars',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          FeaturesSlider(3, "", "", "", ""),
        ],
      ),
    );
  }
}

// class FeaturedAdsSliderSection extends StatefulWidget {
//   @override
//   _FeaturedAdsSliderSectionState createState() =>
//       _FeaturedAdsSliderSectionState();
// }
//
// class _FeaturedAdsSliderSectionState extends State<FeaturedAdsSliderSection> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 400,
//       child: Swiper(
//         itemHeight: 150,
//         autoplay: false,
//         itemBuilder: (BuildContext context, int index) {
//           return new FeaturedAdsSliderItem();
//         },
//         itemCount: 6,
//         pagination: new SwiperPagination(
//           builder: new DotSwiperPaginationBuilder(
//             size: 0,
//             activeSize: 0,
//           ),
//         ),
//         loop: false,
//         index: 0,
//         itemWidth: 100,
//
//
//       ),
//     );
//   }
// }
