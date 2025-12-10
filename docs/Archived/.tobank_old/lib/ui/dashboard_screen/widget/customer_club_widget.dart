import 'package:flutter/material.dart';

class CustomerClub extends StatelessWidget {
  const CustomerClub({
    required this.showCustomerClubScreen,
    super.key,
  });

  final Function showCustomerClubScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          showCustomerClubScreen();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/customer_club_banner.png'),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Card(
              //       elevation: 0,
              //       color: Colors.white,
              //       margin: EdgeInsets.zero,
              //       shadowColor: Colors.transparent,
              //       shape: const RoundedRectangleBorder(
              //         borderRadius:
              //             BorderRadius.only(topRight: Radius.circular(40.0), bottomRight: Radius.circular(40.0)),
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              //         child: RichText(
              //           textAlign: TextAlign.center,
              //           text: TextSpan(
              //               text: '${getClubPoint()}\n',
              //               style: const TextStyle(
              //                 fontFamily: 'IranYekan',
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //                 color: Colors.black87,
              //               ),
              //               children: const <TextSpan>[
              //                 TextSpan(
              //                   text: 'امتیاز شما',
              //                   style: TextStyle(
              //                     color: Colors.blueGrey,
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w500,
              //                   ),
              //                 )
              //               ]),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
