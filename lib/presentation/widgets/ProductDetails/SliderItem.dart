import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/services.dart';

Swiper imageSlider(context) {
  return new Swiper(
    autoplay: false,
    itemBuilder: (BuildContext context, int index) {
      return new Image.network(
        "https://images.unsplash.com/photo-1595445364671-15205e6c380c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=764&q=80",
        fit: BoxFit.fill,
      );
    },
    onTap: (index) => {
      // Navigator.of(context).push(new MaterialPageRoute<Null>(
      //     builder: (BuildContext context) {
      //       return new AddEntryDialog();
      //     },
      //     fullscreenDialog: true))
      showDialog(
        context: context,
        builder: (context) => SliderDialog(index, 3),
      )
    },
    loop: false,
    index: 0,
    itemWidth: MediaQuery.of(context).size.width,
    layout: SwiperLayout.DEFAULT,
    pagination: new SwiperPagination(
      alignment: Alignment.bottomCenter,
      builder: new DotSwiperPaginationBuilder(
          color: Colors.white, activeColor: Colors.orange),
    ),
    control: new SwiperControl(
      color: Colors.orange,
    ),
    itemCount: 3,
  );
}

class SliderDialog extends StatefulWidget {
  int itemsCount;
  int index;

  SliderDialog( this.index, this.itemsCount);

  @override
  _SliderDialogState createState() =>
      _SliderDialogState( index, itemsCount);
}

class _SliderDialogState extends State<SliderDialog> {
  int itemsCount;
  int index;

  _SliderDialogState( this.index, this.itemsCount);

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _dialogBuilder(context,index,itemsCount);
  }
}

Widget _dialogBuilder(BuildContext context, int index, int itemsCount) {
  return Center(
    child: new Container(
      height: MediaQuery.of(context).size.height / 2,
      // alignment: Alignment.center,
      child: Swiper(
        autoplay: false,
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "https://images.unsplash.com/photo-1595445364671-15205e6c380c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=764&q=80",
            fit: BoxFit.fitWidth,
            height: MediaQuery.of(context).size.height / 2,
          );
        },
        loop: false,
        index: index,
        itemWidth: MediaQuery.of(context).size.width,
        layout: SwiperLayout.DEFAULT,
        pagination: new SwiperPagination(
          alignment: Alignment.topCenter,
          //DotSwiperPaginationBuilder
          builder: new DotSwiperPaginationBuilder(
            size: 0,
            activeSize: 0,
          ),
        ),
        control: new SwiperControl(
          color: Colors.orange,
        ),
        itemCount: itemsCount,
      ),
    ),
  );
}
