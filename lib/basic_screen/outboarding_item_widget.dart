import 'package:flutter/material.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';

import '../model/item-data_outboarding.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    required this.data,
    required this.courntpageindex,
    Key? key,
  }) : super(key: key);

  final ItemData data;
  final int  courntpageindex;

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.end,
                  children:[
                    Container(
                      child: Visibility(
                        visible: courntpageindex > 1,
                        replacement: TextButton(
                          child: Text('Skip'),
                          onPressed: () {
                          },
                        ),
                        child: TextButton(
                          child: Text('Start'),
                          onPressed: (){
                            Navigator.pushReplacementNamed(context,'/loginscreen');
                            SharedPrefController().showOutBoarding(showOutBo: true);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                  ]),

            const Spacer(flex: 3),
            Flexible(
              flex: 20,
              child: data.image,
            ),
            const Spacer(flex: 1),
            Text(
              data.title,
              style: TextStyle(
                color: data.titleColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
              maxLines: 1,
            ),
            const Spacer(flex: 1),
            Text(
              data.subtitle,
              style: TextStyle(
                color: data.subtitleColor,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const Spacer(flex: 10),
          ],
        ),
      );
  }
}
