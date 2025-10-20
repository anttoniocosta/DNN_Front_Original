import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';
import 'package:get/get.dart';

class ExpansionTileBuilder extends StatefulWidget {
  const ExpansionTileBuilder(
      {super.key, required this.helper, required this.title});

  final HelperModel helper;
  final String title;

  @override
  State<ExpansionTileBuilder> createState() => _ExpansionTileBuilderState();
}

class _ExpansionTileBuilderState extends State<ExpansionTileBuilder> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        iconTheme: const IconThemeData(size: 20),
      ),
      child: Column(
        children: [
          ExpansionTile(
            trailing: AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: isExpanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: widget.helper.childs!.isEmpty
                  ? const Icon(Icons.arrow_forward_ios, size: 20)
                  : const FaIcon(FontAwesomeIcons.plus),
              secondChild: const FaIcon(FontAwesomeIcons.minus),
            ),
            title: Text(
              widget.helper.name!.capitalizeFirst!,
              style: Fonts.titleLarge(context),
            ),
            collapsedIconColor: Fonts.bodyLarge(context).color,
            iconColor: Fonts.bodyLarge(context).color,
            expandedAlignment: Alignment.centerLeft,
            tilePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.helper.childs!.length,
                itemBuilder: (context, index) {
                  final e = widget.helper.childs![index];
                  return HelpersTile(
                    e: e,
                    hasLeading: false,
                    hasSubtitle: false,
                    onTap: () {
                      Get.toNamed(
                        Routes.helpersDetails,
                        arguments: {
                          'tag': e.tags!,
                          'helper': e,
                          'title': widget.title,
                        },
                      );
                    },
                  );
                },
              )
            ],
            onExpansionChanged: (val) {
              if (widget.helper.childs!.isNotEmpty) {
                setState(() {
                  isExpanded = !isExpanded;
                });
              } else {
                final e = widget.helper;
                Get.toNamed(
                  Routes.helpersDetails,
                  arguments: {
                    'tag': e.tags!,
                    'helper': e,
                    'title': widget.title,
                  },
                );
              }
            },
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }
}
