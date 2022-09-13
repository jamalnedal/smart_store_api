import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FoodListView extends StatelessWidget {
  final bool isLoading;

  const FoodListView({this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  leading: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      color: Colors.grey[300],
                    ),
                  ),
                  title: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(height: 16.0, color: Colors.grey[300]),
                  ),
                  subtitle: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(height: 16.0, color: Colors.grey[300]),
                  ),
                  trailing: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 24.0,
                      width: 24.0,
                      color: Colors.grey[300],
                    ),
                  ),
                );
              },
              childCount: 10,
            ),
          )
        : CircularProgressIndicator();
  }
}
