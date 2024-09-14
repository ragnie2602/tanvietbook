// import 'package:flutter/material.dart';
// import '../../data/resources/colors.dart';
// import '../../data/resources/themes.dart';
// // import '../../model/collab/collaborator_tree_response.dart';

// import 'custom_expansion.dart' as custom;

// class ExpansionTreeButton extends StatelessWidget {
//   const ExpansionTreeButton({
//     Key? key,
//     required this.title,
//     required this.onCollabSubItemPressed,
//     this.backgroundColor,
//     required this.hierarchicalTreeF1RpList,
//     required this.hierarchicalTreeF2RpList,
//   }) : super(key: key);

//   final String title;
//   final Color? backgroundColor;
//   // final List<CollaboratorTreeResponse> hierarchicalTreeF1RpList;
//   // final List<CollaboratorTreeResponse> hierarchicalTreeF2RpList;
//   final List<Function> onCollabSubItemPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(5),
//         child: custom.ExpansionTile(
//           // collapsedBackgroundColor: backgroundColor ?? AppColor.bgField,
//           // backgroundColor: AppColor.bgField,
//           // tilePadding: const EdgeInsets.symmetric(horizontal: 12),

//           headerBackgroundColor: AppColor.primaryColor,
//           title: Row(
//             children: [
//               Text(
//                 title,
//                 style: AppTextTheme.textButtonPrimary,
//               ),
//             ],
//           ),
//           children: [
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: hierarchicalTreeF1RpList
//                   .map(
//                     (collabF1Response) => Container(
//                       width: MediaQuery.of(context).size.width,
//                       margin: const EdgeInsets.symmetric(horizontal: 10),
//                       child: IntrinsicHeight(
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 1,
//                               color: AppColor.primaryColor,
//                             ),
//                             Container(
//                               width: 15,
//                               height: 1,
//                               color: AppColor.primaryColor,
//                             ),
//                             Expanded(
//                               child: Container(
//                                 margin: const EdgeInsets.symmetric(vertical: 5),
//                                 child: custom.ExpansionTile(
//                                   headerBackgroundColor: Colors.white,
//                                   title: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         '${collabF1Response.fullname} (${collabF1Response.username})',
//                                         style: AppTextTheme.textButtonPrimary,
//                                       ),
//                                       Text(
//                                         'Có ${collabF1Response.quantityF1} CTV',
//                                         style: AppTextTheme.textRed,
//                                       ),
//                                     ],
//                                   ),
//                                   children: [
//                                     Column(
//                                       children: collabF1Response
//                                           .hierarchicalTreeF2Rp!
//                                           .map(
//                                             (collabF2Response) => Container(
//                                               margin:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 10),
//                                               width: MediaQuery.of(context)
//                                                   .size
//                                                   .width,
//                                               child: IntrinsicHeight(
//                                                 child: Row(
//                                                   children: [
//                                                     Container(
//                                                       width: 1,
//                                                       color:
//                                                           AppColor.primaryColor,
//                                                     ),
//                                                     Container(
//                                                       width: 15,
//                                                       height: 1,
//                                                       color:
//                                                           AppColor.primaryColor,
//                                                     ),
//                                                     Expanded(
//                                                       child: ClipRRect(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(5),
//                                                         child: Container(
//                                                           decoration:
//                                                               const BoxDecoration(
//                                                                   color: AppColor
//                                                                       .bgF2Color),
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                             vertical: 10,
//                                                             horizontal: 12,
//                                                           ),
//                                                           margin:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                             vertical: 5,
//                                                           ),
//                                                           child: Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               Text(
//                                                                 '${collabF2Response.fullname} (${collabF2Response.username})',
//                                                                 style: AppTextTheme
//                                                                     .textButtonPrimary,
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 10,
//                                                               ),
//                                                               Text(
//                                                                 'Có ${collabF2Response.quantityF1} CTV',
//                                                                 style:
//                                                                     AppTextTheme
//                                                                         .textRed,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         // ExpansionTile(
//                                                         //   // backgroundColor: backgroundColor ?? AppColor.bgField,
//                                                         //   tilePadding:
//                                                         //       const EdgeInsets
//                                                         //               .symmetric(
//                                                         //           horizontal: 12),
//                                                         //   title: Row(
//                                                         //     children: [
//                                                         //       const SizedBox(
//                                                         //         width: 12,
//                                                         //       ),
//                                                         //       Text(
//                                                         //         collabF1Response
//                                                         //             .fullname
//                                                         //             .toString(),
//                                                         //         style: AppTextTheme
//                                                         //             .textButtonPrimary,
//                                                         //       ),
//                                                         //     ],
//                                                         //   ),
//                                                         // ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                           .toList(),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                   .toList(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
