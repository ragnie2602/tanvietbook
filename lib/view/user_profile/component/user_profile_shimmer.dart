import 'package:flutter/material.dart';
import '../../../data/resources/colors.dart';
import '../../../shared/widgets/container_shimmer.dart';
import '../../../shared/widgets/primary_shimmer.dart';
import 'package:shimmer/shimmer.dart';

import 'member_action_view_other.dart';

class UserProfileShimmer extends StatelessWidget {
  const UserProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double coverImageHeight = screenWidth * 9 / 16;

    return Column(
      children: [
        Stack(children: [
          Shimmer.fromColors(
            baseColor: AppColor.neutral5,
            highlightColor: Colors.white,
            period: const Duration(milliseconds: 1500),
            direction: ShimmerDirection.ltr,
            child: SizedBox(
              height: coverImageHeight,
              child: Stack(
                children: [
                  Container(
                    height: coverImageHeight,
                    width: MediaQuery.of(context).size.width,
                    color: AppColor.bgCardColor,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: coverImageHeight - 70),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      border: Border.all(color: AppColor.white, width: 4),
                    ),
                    // padding: const EdgeInsets.all(9),
                    height: 140,
                    width: 140,
                    child: const PrimaryShimmer(
                      child: CircleAvatar(
                        radius: 70,
                      ),
                    )),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 80, left: 20),
                    child: const PrimaryShimmer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContainerShimmer(
                            width: 150,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          ContainerShimmer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryShimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MemberActionViewOther(
                  onSaveContact: () {},
                  onRegister: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                const ContainerShimmer(
                  width: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: List.generate(
                    5,
                    (index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          ContainerShimmer(
                            width: 100,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: ContainerShimmer()),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const ContainerShimmer(
                  width: 150,
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: List.generate(
                    5,
                    (index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          ContainerShimmer(
                            width: 100,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: ContainerShimmer()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
