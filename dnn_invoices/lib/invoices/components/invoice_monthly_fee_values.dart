import 'dart:developer';

import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class InvoiceMonthlyFeeValues extends StatefulWidget {
  const InvoiceMonthlyFeeValues(
      {super.key,
      required this.order,
      required this.isOwner,
      required this.onCheck,
      required this.isChecked});

  final InvoicePaymentDetailsModel order;
  final bool isOwner;
  final void Function(bool?) onCheck;
  final bool isChecked;

  @override
  State<InvoiceMonthlyFeeValues> createState() =>
      _InvoiceMonthlyFeeValuesState();
}

class _InvoiceMonthlyFeeValuesState extends State<InvoiceMonthlyFeeValues> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          thickness: 1,
          color: !Get.isDarkMode
              ? AppColors.greyColor
              : AppColors.lighterGreyColor.withOpacity(.3),
          height: 0,
        ),
        RowInvoceHeader(
          onTap: () => setState(() {
            isOpen = !isOpen;
            log(isOpen.toString());
          }),
          order: widget.order,
          isOwner: widget.isOwner,
          onCheck: widget.onCheck,
          isChecked: widget.isChecked,
        ),
        Divider(
          thickness: 1,
          color: !Get.isDarkMode
              ? AppColors.greyColor
              : AppColors.lighterGreyColor.withOpacity(.3),
          height: 0,
        ),
        Visibility(
          visible: isOpen,
          child: Column(
            children: [
              ...widget.order.persons!.map(
                (e) => Column(
                  children: [
                    10.heightGap,
                    RowInvoceText(
                      title: e.name!.capitalize!,
                      price: e.total!,
                      needBold: true,
                    ),
                    ...e.products!.map(
                      (x) => RowInvoceText(
                        title: x.title!,
                        price: x.price!,
                        needBold: false,
                      ).paddingOnly(left: 10, right: 0, bottom: 5, top: 10),
                    )
                  ],
                ).paddingSymmetric(horizontal: 20),
              ),
              if (!widget.order.isPaid! &&
                  (widget.order.info!.billet != null ||
                      widget.order.info!.pix != null))
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => Get.toNamed(Routes.myInvoiceRecover,
                        arguments: widget.order),
                    child: Text(
                      'Alterar forma do pagamento',
                      style: Fonts.titleSmall(context)
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ).paddingSymmetric(vertical: 10, horizontal: 20),
                ),
            ],
          ),
        )
      ],
    );
  }
}

class RowInvoceText extends StatelessWidget {
  const RowInvoceText({
    super.key,
    required this.title,
    required this.price,
    required this.needBold,
    this.hasDiscount = false,
  });

  final String title;
  final double price;
  final bool needBold;
  final bool? hasDiscount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Text(title,
              style: needBold
                  ? Fonts.titleSmall(context)
                  : Fonts.bodyLarge(context)),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${hasDiscount! ? '- ' : ''}${price.formatReal()}',
            style: needBold
                ? Fonts.titleSmall(context)
                : Fonts.bodyMedium(context),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class RowInvoceHeader extends StatefulWidget {
  const RowInvoceHeader({
    super.key,
    required this.order,
    required this.onTap,
    this.isOwner = false,
    required this.onCheck,
    required this.isChecked,
  });

  final InvoicePaymentDetailsModel order;
  final VoidCallback onTap;
  final bool? isOwner;
  final void Function(bool?) onCheck;
  final bool isChecked;

  @override
  State<RowInvoceHeader> createState() => _RowInvoceHeaderState();
}

class _RowInvoceHeaderState extends State<RowInvoceHeader> {
  Color? getColor() {
    if (!widget.order.isPaid! &&
        (widget.order.info!.billet != null || widget.order.info!.pix != null)) {
      return AppColors.redColor;
    }

    if (widget.order.isPaid!) {
      return Colors.green;
    }
    return null;
  }

  bool needCheckBox() {
    if (!widget.order.isPaid! &&
        (widget.order.info!.billet != null || widget.order.info!.pix != null)) {
      return true;
    }

    if (widget.order.isPaid!) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.order.title!,
                      style: Fonts.titleSmall(context).copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: getColor(),
                      ),
                    ),
                    Text(
                      'Vencimento: ${widget.order.startDate!.formatDateFromIso()}',
                      style: Fonts.bodyMedium(context).copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              10.widthGap,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.order.total!.formatReal(),
                  style: Fonts.titleSmall(context),
                  textAlign: TextAlign.end,
                ),
              ),
              10.widthGap,
              if (widget.isOwner! == true) ...[
                if (needCheckBox())
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox.adaptive(
                      activeColor: Get.isDarkMode
                          ? AppColors.whiteColor
                          : AppColors.midBlackColor,
                      value: widget.isChecked,
                      onChanged: widget.onCheck,
                      side: BorderSide(
                        width: 1,
                        color: Get.isDarkMode
                            ? AppColors.whiteColor
                            : AppColors.midBlackColor,
                      ),
                    ),
                  ),
              ],
            ],
          ).paddingSymmetric(horizontal: 20, vertical: 10),
        ],
      ),
    );
  }
}
