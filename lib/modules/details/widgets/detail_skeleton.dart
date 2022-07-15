import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailScreenSkeleton extends StatelessWidget {
  const DetailScreenSkeleton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return ListView.separated(
      scrollDirection: Axis.vertical,
      separatorBuilder: ((context, index) => const SizedBox(width: 10,)),
      itemCount: 1,
      itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            getSkeleton(height: deviceSize.height*0.2, width: deviceSize.width*0.9),
            SizedBox(height: 20,),
            getSkeleton(height: deviceSize.height*0.02, width: deviceSize.width*0.5),
            SizedBox(height: 20,),
            getSkeleton(height: deviceSize.height*0.02, width: deviceSize.width*0.5),
            SizedBox(height: 20,),
            getSkeleton(height: deviceSize.height*0.02, width: deviceSize.width*0.3),
          ],
        ),
      );
    });
  }
  
  Widget getSkeleton({required double height,required double width}){
    return Shimmer.fromColors(
      baseColor: Colors.black12.withOpacity(0.15),
      highlightColor: Colors.white,
      loop: 10,
      child : Container(
        height: height,
        width: width,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
    )); 
  }
}

