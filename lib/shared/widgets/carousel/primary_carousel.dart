import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../etx/view_extensions.dart';

import '../../../data/resources/colors.dart';
import '../image/primary_image.dart';

class PrimaryCarousel extends StatefulWidget {
  final List<String>? data;
  final List<Widget>? customData;
  final Duration? duration;
  final double aspectRatio;
  final double? height;
  final double? viewportFraction;
  final Color? backgroundColor;
  final bool autoPlay;
  final bool showIndicator;
  final BoxFit fit;

  const PrimaryCarousel(
      {Key? key,
      this.data,
      this.duration = const Duration(seconds: 4),
      this.aspectRatio = 16 / 9,
      this.height,
      this.autoPlay = true,
      this.fit = BoxFit.contain,
      this.showIndicator = true,
      this.customData,
      this.viewportFraction,
      this.backgroundColor})
      : super(key: key);

  @override
  State<PrimaryCarousel> createState() => _PrimaryCarouselState();
}

class _PrimaryCarouselState extends State<PrimaryCarousel> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.customData ??
              widget.data
                  ?.map(
                    (e) => Container(
                      padding: const EdgeInsets.all(0),
                      color: widget.backgroundColor,
                      child: PrimaryNetworkImage(
                          width: double.infinity, imageUrl: e, fit: widget.fit),
                    ),
                  )
                  .toList(),
          options: CarouselOptions(
              autoPlay: widget.data?.length == 1 ? false : widget.autoPlay,
              height: widget.height,
              enlargeCenterPage: false,
              enlargeFactor: 0.5,
              aspectRatio: widget.aspectRatio,
              autoPlayInterval: const Duration(seconds: 4),
              enlargeStrategy: CenterPageEnlargeStrategy.scale,

              // viewportFraction: 0.9,
              initialPage: 0,
              viewportFraction: widget.viewportFraction ?? 1,
              onPageChanged: (index, reason) {
                setState(() {
                  if (index >= 0 && index <= 9) currentIndex = index;
                });
              }),
        ),
        widget.showIndicator
            ? SizedBox(
                height: context.screenWidth * 9 / 16,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: (widget.customData ?? widget.data)!
                        .sublist(
                            0,
                            ((widget.customData?.length ??
                                            widget.data?.length) ??
                                        0) >
                                    10
                                ? 10
                                : (widget.customData?.length ??
                                    widget.data?.length))
                        .asMap()
                        .entries
                        .map((e) => AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                  color: currentIndex == e.key
                                      ? AppColor.primaryColor
                                      : AppColor.neutral5,
                                  borderRadius: BorderRadius.circular(1)),
                              curve: Curves.easeInCirc,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 16),
                              height: context.screenWidth * 9 / 16 / 60,
                              width: currentIndex == e.key
                                  ? context.screenWidth * 16 / 375 + 10
                                  : context.screenWidth * 16 / 375,
                            ))
                        .toList(),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
