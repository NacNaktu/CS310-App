import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/models/notification_card.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:flutter/material.dart';


class Not extends StatefulWidget {
  @override
  _NotState createState() => _NotState();
}

class _NotState extends State<Not> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text('Notifications'),
          centerTitle: true,
          backgroundColor: AppColors.appBarColour,
        ),
        bottomNavigationBar: BottomBar(index: 3),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: GridView.builder(
                    itemCount: nots.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 4,
                    ),
                    itemBuilder: (context, index) => NotCard(
                      notif: nots[index],
                    )),
              ),
            ),
          ],
        ));
  }
}
