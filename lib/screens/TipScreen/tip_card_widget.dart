import 'package:flutter/material.dart';
import 'package:tipme_front/models/post_model.dart';

import '../../utils/constants.dart';

class TipCardWidget extends StatefulWidget {
  const TipCardWidget({
    super.key,
    required this.post,
  });
  final PostModel post;

  @override
  State<TipCardWidget> createState() => _TipCardWidgetState();
}

class _TipCardWidgetState extends State<TipCardWidget> {
  late final String title;
  late final String category;
  late final int tipCount;
  late final IconData icon;
  late final Color cardColor;

  @override
  void initState() {
    title = widget.post.place;
    category = widget.post.category.name;
    tipCount = widget.post.tips.length;
    icon = Categories.getIcon(category);
    cardColor = Categories.getColor(category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 170,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(0.35),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Taebaek',
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'Taebaek',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        tipCount.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Taebaek',
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        " Tips",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
