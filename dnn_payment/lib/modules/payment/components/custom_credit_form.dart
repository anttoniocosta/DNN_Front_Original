import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CustomCardForm extends StatefulWidget {
  const CustomCardForm({
    super.key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    this.obscureCvv = false,
    this.obscureNumber = false,
    required this.onCreditCardModelChange,
    this.cardHolderDecoration = const InputDecoration(
      labelText: 'Nome impresso no cartão',
    ),
    this.cardNumberDecoration = const InputDecoration(
      labelText: 'Número do cartão',
      hintText: '0000 0000 0000 0000',
    ),
    this.expiryDateDecoration = const InputDecoration(
      labelText: 'Dt. de validade',
      hintText: '00/00',
    ),
    this.cvvCodeDecoration = const InputDecoration(
      labelText: 'CVV',
      hintText: '000',
    ),
    this.cardNumberKey,
    this.cardHolderKey,
    this.expiryDateKey,
    this.cvvCodeKey,
    this.isHolderNameVisible = true,
    this.isCardNumberVisible = true,
    this.isExpiryDateVisible = true,
    this.enableCvv = true,
    this.autovalidateMode,
    this.cardNumberValidator,
    this.expiryDateValidator,
    this.cvvValidator,
    this.cardHolderValidator,
    this.onFormComplete,
    this.disableCardNumberAutoFillHints = false,
  });

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final void Function(CreditCardModel) onCreditCardModelChange;
  final bool obscureCvv;
  final bool obscureNumber;
  final bool isHolderNameVisible;
  final bool isCardNumberVisible;
  final bool enableCvv;
  final bool isExpiryDateVisible;
  final Function? onFormComplete;
  final GlobalKey<FormFieldState<String>>? cardNumberKey;
  final GlobalKey<FormFieldState<String>>? cardHolderKey;
  final GlobalKey<FormFieldState<String>>? expiryDateKey;
  final GlobalKey<FormFieldState<String>>? cvvCodeKey;
  final InputDecoration? cardNumberDecoration;
  final InputDecoration? cardHolderDecoration;
  final InputDecoration? expiryDateDecoration;
  final InputDecoration? cvvCodeDecoration;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? cardNumberValidator;
  final String? Function(String?)? expiryDateValidator;
  final String? Function(String?)? cvvValidator;
  final String? Function(String?)? cardHolderValidator;
  final bool disableCardNumberAutoFillHints;

  @override
  _CustomCardFormState createState() => _CustomCardFormState();
}

class _CustomCardFormState extends State<CustomCardForm> {
  late String cardNumber;
  late String expiryDate;
  late String cardHolderName;
  late String cvvCode;
  bool isCvvFocused = false;
  late Color themeColor;

  late void Function(CreditCardModel) onCreditCardModelChange;
  late CreditCardModel creditCardModel;

  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');

  FocusNode cvvFocusNode = FocusNode();
  FocusNode expiryDateNode = FocusNode();
  FocusNode cardHolderNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber;
    expiryDate = widget.expiryDate;
    cardHolderName = widget.cardHolderName;
    cvvCode = widget.cvvCode;

    creditCardModel = CreditCardModel(
        cardNumber, expiryDate, cardHolderName, cvvCode, isCvvFocused);
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    _cardNumberController.text = widget.cardNumber;
    _expiryDateController.text = widget.expiryDate;
    _cardHolderNameController.text = widget.cardHolderName;
    _cvvCodeController.text = widget.cvvCode;

    onCreditCardModelChange = widget.onCreditCardModelChange;

    cvvFocusNode.addListener(textFieldFocusDidChange);
  }

  @override
  void dispose() {
    cardHolderNode.dispose();
    cvvFocusNode.dispose();
    expiryDateNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Visibility(
          visible: widget.isCardNumberVisible,
          child: Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: TextFormField(
              key: widget.cardNumberKey,
              obscureText: widget.obscureNumber,
              controller: _cardNumberController,
              onChanged: (String value) {
                setState(() {
                  cardNumber = _cardNumberController.text;
                  creditCardModel.cardNumber = cardNumber;
                  onCreditCardModelChange(creditCardModel);
                });
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(expiryDateNode);
              },
              style: Fonts.bodyLarge(context),
              decoration: widget.cardNumberDecoration!.copyWith(
                contentPadding: AppConstants.contentPadding,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: Fonts.bodyLarge(context).copyWith(
                    color: Fonts.bodyLarge(context).color!.withOpacity(0.4)),
                labelStyle: Fonts.titleMedium(context),
                errorStyle: Fonts.bodyMedium(context)
                    .copyWith(color: AppColors.redColor),
                fillColor: Get.isDarkMode
                    ? AppColors.midBlackColor
                    : AppColors.lighterGreyColor,
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autofillHints: widget.disableCardNumberAutoFillHints
                  ? null
                  : const <String>[AutofillHints.creditCardNumber],
              autovalidateMode: widget.autovalidateMode,
              validator: widget.cardNumberValidator ??
                  (String? value) {
                    if (value!.isEmpty || value.length < 16) {
                      return 'Digite um número válido';
                    }
                    return null;
                  },
            ),
          ),
        ),
        10.heightGap,
        Row(
          children: <Widget>[
            Visibility(
              visible: widget.isExpiryDateVisible,
              child: Expanded(
                child: TextFormField(
                  key: widget.expiryDateKey,
                  controller: _expiryDateController,
                  onChanged: (String value) {
                    if (_expiryDateController.text
                        .startsWith(RegExp('[2-9]'))) {
                      _expiryDateController.text =
                          '0${_expiryDateController.text}';
                    }
                    setState(() {
                      expiryDate = _expiryDateController.text;
                      creditCardModel.expiryDate = expiryDate;
                      onCreditCardModelChange(creditCardModel);
                    });
                  },
                  focusNode: expiryDateNode,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(cvvFocusNode);
                  },
                  style: Fonts.bodyLarge(context),
                  decoration: widget.expiryDateDecoration!.copyWith(
                    contentPadding: AppConstants.contentPadding,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: Fonts.bodyLarge(context).copyWith(
                        color:
                            Fonts.bodyLarge(context).color!.withOpacity(0.4)),
                    labelStyle: Fonts.titleMedium(context),
                    errorStyle: Fonts.bodyMedium(context)
                        .copyWith(color: AppColors.redColor),
                    fillColor: Get.isDarkMode
                        ? AppColors.midBlackColor
                        : AppColors.lighterGreyColor,
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autofillHints: const <String>[
                    AutofillHints.creditCardExpirationDate
                  ],
                  validator: widget.expiryDateValidator ??
                      (String? value) {
                        if (value!.isEmpty) {
                          return 'Digite uma data válida';
                        }
                        final DateTime now = DateTime.now();
                        final List<String> date = value.split(RegExp(r'/'));
                        final int month = int.parse(date.first);
                        final int year = int.parse('20${date.last}');
                        final int lastDayOfMonth = month < 12
                            ? DateTime(year, month + 1, 0).day
                            : DateTime(year + 1, 1, 0).day;
                        final DateTime cardDate = DateTime(
                            year, month, lastDayOfMonth, 23, 59, 59, 999);

                        if (cardDate.isBefore(now) ||
                            month > 12 ||
                            month == 0) {
                          return 'Digite uma data válida';
                        }
                        return null;
                      },
                ),
              ),
            ),
            10.widthGap,
            Expanded(
              child: Visibility(
                visible: widget.enableCvv,
                child: TextFormField(
                  key: widget.cvvCodeKey,
                  obscureText: widget.obscureCvv,
                  focusNode: cvvFocusNode,
                  controller: _cvvCodeController,
                  onEditingComplete: () {
                    if (widget.isHolderNameVisible) {
                      FocusScope.of(context).requestFocus(cardHolderNode);
                    } else {
                      FocusScope.of(context).unfocus();
                      onCreditCardModelChange(creditCardModel);
                      widget.onFormComplete?.call();
                    }
                  },
                  style: Fonts.bodyLarge(context),
                  decoration: widget.cvvCodeDecoration!.copyWith(
                    contentPadding: AppConstants.contentPadding,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: Fonts.bodyLarge(context).copyWith(
                        color:
                            Fonts.bodyLarge(context).color!.withOpacity(0.4)),
                    labelStyle: Fonts.titleMedium(context),
                    errorStyle: Fonts.bodyMedium(context)
                        .copyWith(color: AppColors.redColor),
                    fillColor: Get.isDarkMode
                        ? AppColors.midBlackColor
                        : AppColors.lighterGreyColor,
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: widget.isHolderNameVisible
                      ? TextInputAction.next
                      : TextInputAction.done,
                  autofillHints: const <String>[
                    AutofillHints.creditCardSecurityCode
                  ],
                  onChanged: (String text) {
                    setState(() {
                      cvvCode = text;
                      creditCardModel.cvvCode = cvvCode;
                      onCreditCardModelChange(creditCardModel);
                    });
                  },
                  validator: widget.cvvValidator ??
                      (String? value) {
                        if (value!.isEmpty || value.length < 3) {
                          return 'Digite um CVV válido';
                        }
                        return null;
                      },
                ),
              ),
            ),
          ],
        ),
        10.heightGap,
        Visibility(
          visible: widget.isHolderNameVisible,
          child: Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: TextFormField(
              key: widget.cardHolderKey,
              controller: _cardHolderNameController,
              onChanged: (String value) {
                setState(() {
                  cardHolderName = _cardHolderNameController.text;
                  creditCardModel.cardHolderName = cardHolderName;
                  onCreditCardModelChange(creditCardModel);
                });
              },
              focusNode: cardHolderNode,
              style: Fonts.bodyLarge(context),
              decoration: widget.cardHolderDecoration!.copyWith(
                  contentPadding: AppConstants.contentPadding,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: Fonts.bodyLarge(context).copyWith(
                      color: Fonts.bodyLarge(context).color!.withOpacity(0.4)),
                  labelStyle: Fonts.titleMedium(context),
                  errorStyle: Fonts.bodyMedium(context)
                      .copyWith(color: AppColors.redColor),
                  fillColor: Get.isDarkMode
                      ? AppColors.midBlackColor
                      : AppColors.lighterGreyColor,
                  hintText: 'Seu nome aqui'),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              autofillHints: const <String>[AutofillHints.creditCardName],
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                onCreditCardModelChange(creditCardModel);
                widget.onFormComplete?.call();
              },
              validator: ValidatorsCustom.nameValidator,
            ),
          ),
        ),
        10.heightGap,
      ],
    );
  }
}
