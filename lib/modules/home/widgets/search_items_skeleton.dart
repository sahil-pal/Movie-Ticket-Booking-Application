import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchItemSkeleton extends StatelessWidget {
  const SearchItemSkeleton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: ((context, index) => const SizedBox(height: 20,)),
      itemCount: 10,
      itemBuilder: (context, index) {
      return Row(
        children: [
          getSkeleton(height: 110, width: 100),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getSkeleton(height: 15, width: 150),
              const SizedBox(height:10),
              getSkeleton(height: 10, width: 110),
              const SizedBox(height:10),
              getSkeleton(height: 10, width: 110),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getSkeleton(height: 40, width: 60),
              const SizedBox(height:10),
              getSkeleton(height: 40, width: 60),
            ],
          )
        ],
      );
    });
  }
  
  Widget getSkeleton({required double height,required double width}){
    return Shimmer.fromColors(
      baseColor: Colors.black12.withOpacity(0.15),
      highlightColor: Colors.white,
      loop: 5,
      child : Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
    )); 
  }
}

