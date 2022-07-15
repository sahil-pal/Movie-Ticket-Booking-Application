import 'package:bigboxo_application/modules/home/repo/play_operations.dart';
import 'package:bigboxo_application/modules/home/widgets/items_skeleton.dart';
import 'package:bigboxo_application/utils/helpers/string_helper.dart';
import 'package:flutter/material.dart';
import '../model/play.dart';

class PlayList extends StatelessWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    PlayOperations playOperations = PlayOperations.getPlayOperationInstance();
    return Container(
        height: deviceSize.height * 0.34,
        child: FutureBuilder(
            future: playOperations
                .read(), // Firebase read operation , which gives future
            builder: (BuildContext ctx, AsyncSnapshot<List<Play>> snapshot) {
              ConnectionState state = snapshot.connectionState;

              // loading
              if (state == ConnectionState.waiting) {
                return const Center(child: ItemSkeleton());
              }
              // error
              else if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Loading Error',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                );
              }
              // loaded
              else {
                return _printPlays(snapshot);
              }
            }));
  }

  _printPlays(AsyncSnapshot snapshot) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (BuildContext ctx, int i) {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10, right: 10),
          child: GestureDetector(
            onTap: () {
              //print(snapshot.data![i].name);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      snapshot.data![i].bannerURL,
                      height: 190,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 120,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.black54,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${snapshot.data![i].date}",
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ])),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: 18,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Colors.grey.shade200,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Text(
                            StringHelper
                              .convertToCategoryFormat(snapshot.data![i].category)
                              .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 10,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: 120,
                  child: Text(
                    snapshot.data![i].name,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                (snapshot.data![i].artists.length != 0)
                    ? Row(
                        children: [
                          const Icon(
                            Icons.language,
                            color: Colors.black,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            StringHelper
                              .convertToCategoryFormat(snapshot.data![i].languages),
                            style: const TextStyle(
                                fontSize: 10,
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    : (const SizedBox(
                        height: 2,
                      )),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  (snapshot.data![i].ticketprice != 0)
                      ? '₹ ${snapshot.data![i].ticketprice} onwards'
                      : ' Free ',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
