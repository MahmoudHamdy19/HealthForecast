import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:math' as math show sin, pi;
import 'App Colors.dart';
import 'App Textstyle.dart';
import 'Responsive.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CustomFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: selected
                ? BorderSide.none
                : const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  )),
        color: selected ? AppColors.greenYellow : Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                    color: selected ? Colors.white : Colors.grey.shade500,
                    height: 0.9,
                    fontSize: selected ? 14 : 12,
                    fontWeight: selected ? null : FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.color = Colors.grey,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Material(
        color: color,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: padding,
            color: Colors.transparent,
            child: child,
          ),
        ),
      ),
    );
  }
}

bool validateStructure(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

class TextFieldTemplate extends StatefulWidget {
  final String name;
  final String titel;
  final String? initialValue;
  final String? label;
  TextEditingController? textEditingController;
  final IconData? leadingIcon;
  final TextInputType inputType;
  final bool enableFocusBorder;
  bool boolleadingIcon;
  final TextEditingController? controller;

  final Color? leadingIconColor;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final bool enabled;
  final void Function(String?)? onChanged;

   TextFieldTemplate({
    super.key,
    required this.name,
    this.titel = "",
    this.initialValue,
    this.controller,
    this.label,
    this.textEditingController,
    this.leadingIcon,
    this.inputType = TextInputType.text,
    this.enableFocusBorder = true,
    this.leadingIconColor,
    this.maxLines = 1,
    this.minLines = 1,
    this.validator,
    this.enabled = true,
    this.onChanged,
    this.boolleadingIcon = false,
  });
  @override
  State<TextFieldTemplate> createState() => _TextFieldTemplateState();
}

class _TextFieldTemplateState extends State<TextFieldTemplate> {
  final focusNode = FocusNode();
  late bool _isObscure;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {});
    });

    _isObscure = widget.inputType == TextInputType.visiblePassword;
  }

  void _toggleObscure() => setState(() => _isObscure = !_isObscure);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.titel == null ? SizedBox() : Text(widget.titel),
        const SizedBox(
          height: 3,
        ),
        FormBuilderField<String>(
          name: widget.name,
          initialValue: widget.initialValue,
          onChanged: widget.onChanged,
          builder: (field) {
            final isEmpty = field.value?.isEmpty ?? true;
            return CustomInputDecorator(
              disableTapRippleEffect: true,
              onTap: () => focusNode.requestFocus(),

              focused: focusNode.hasFocus && widget.enableFocusBorder,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),

              // leadingIcon: widget.leadingIcon,
              leadingIconColor: widget.leadingIconColor ??
                  (isEmpty
                      ? AppColors.black.withOpacity(0.40)
                      : AppColors.black),
              body: TextFormField(
                controller: widget.controller,
                enabled: widget.enabled,
                initialValue: widget.initialValue,
                focusNode: focusNode,
                onChanged: field.didChange,
                validator: widget.validator,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                keyboardType: widget.inputType,
                obscureText:
                    widget.inputType == TextInputType.visiblePassword &&
                        _isObscure,
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 14,
                  height: 1,
                ),
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    hintText: widget.label,
                    hintStyle: AppTextStyles.titleText2.copyWith(
                        fontSize: 12,
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.w600)),
              ),
              trailing: widget.boolleadingIcon == true
                  ? Icon(
                      widget.leadingIcon,
                      size: 22,
                      color: AppColors.blue,
                    )
                  : widget.inputType == TextInputType.visiblePassword
                      ? InkResponse(
                          onTap: _toggleObscure,
                          child: Icon(
                            _isObscure ? Iconsax.eye_slash : Iconsax.eye,
                            size: 24,
                            color: AppColors.blue,
                          ),
                        )
                      : null,
            );
          },
        ),
      ],
    );
  }
}

class CustomBottomNavigationBarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final IconData coloredIcon;
  final bool selected;

  const CustomBottomNavigationBarItem({
    super.key,
    required this.label,
    required this.icon,
    required this.coloredIcon,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selected)
            Stack(
              children: [
                Icon(
                  size: 30,
                  coloredIcon,
                  color: AppColors.white,
                ),
                Icon(
                  icon,
                  size: 30,
                  color: AppColors.blue,
                ),
              ],
            )
          else
            Icon(
              icon,
              size: 30,
              color: AppColors.darkGrey.withOpacity(0.5),
            ),
          const SizedBox(height: 4),
          Text(label,
              style: selected
                  ? AppTextStyles.titleText.copyWith(
                      color: Colors.grey.shade800,
                      fontSize: 11,
                      fontWeight: FontWeight.w200)
                  : AppTextStyles.subTitle.copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;
  final List<CustomBottomNavigationBarItem> items;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        width: MediaQueryHelper.sizeFromWidth(context, 1),
        height: 85,
        decoration: const BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey,
              blurRadius: 20,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (int index = 0; index < items.length; index++)
              GestureDetector(
                onTap: () => onTap(index),
                child: items[index],
              ),
          ],
        ),
      ),
    );
  }
}

class TextFieldButton extends StatelessWidget {
  final String loginKey;
  final IconData icon;
  final String hitText;
  final TextEditingController textEditingController;
  final void Function() function;
  final bool obscureText;
  final bool isTrue;
  final BoxConstraints constraints;

  const TextFieldButton({
    super.key,
    required this.loginKey,
    required this.icon,
    required this.hitText,
    required this.textEditingController,
    required this.function,
    required this.obscureText,
    required this.isTrue,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: constraints.maxHeight * 0.17,
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(constraints.maxHeight * 0.05),
      ),
      child: TextFormField(
        key: Key(loginKey),
        controller: textEditingController,
        validator: (value) {
          if (value.toString().isEmpty) {
            return "Please Enter Your The Email or Password ";
          }
          return null;
        },
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xff428DFC), width: 2, style: BorderStyle.solid),
            ),
            prefixIcon: Icon(icon),
            hintText: hitText,
            suffixIcon: isTrue == true
                ? IconButton(
                    icon: obscureText == true
                        ? Icon(
                            Icons.visibility_off,
                            size: constraints.maxHeight * 0.05,
                            color: Colors.grey,
                          )
                        : Icon(
                            Icons.visibility,
                            size: constraints.maxHeight * 0.05,
                            color: Colors.grey,
                          ),
                    onPressed: function,
                  )
                : null,
            hintStyle: GoogleFonts.ptSans(
              textStyle: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  letterSpacing: .5,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            )),
        obscureText: obscureText,
        style: GoogleFonts.ptSans(
            fontSize: 17, fontWeight: FontWeight.w500, color: Colors.grey[900]),
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  final String svgAsset;
  final String? title;
  final String? body;

  const MessageCard({
    super.key,
    required this.svgAsset,
    this.title,
    this.body,
  }) : assert(title != null || body != null);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 20,
      ),
      color: Colors.grey.shade100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Icon(
            Icons.medical_services_outlined,
            color: AppColors.blue,
            size: 36,
          )),
          const SizedBox(width: 26),
          Expanded(
            child: Column(
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (body != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        body!,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ShadowButton extends StatelessWidget {
  const ShadowButton(
      {super.key,
      required this.onPressed,
      required this.color,
      required this.child,
      this.width,
      this.height,
      this.borderColor});

  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final double? height;
  final double? width;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: MediaQueryHelper.sizeFromHeight(context, 150),
            left: MediaQueryHelper.sizeFromWidth(context, 70),
          ),
          child: Container(
            height: height ?? MediaQueryHelper.sizeFromHeight(context, 16),
            width: width ?? MediaQueryHelper.sizeFromWidth(context, 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: color),
          ),
        ),
        MaterialButton(
          onPressed: onPressed,
          minWidth: width,
          height: height,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side:
                  BorderSide(color: borderColor ?? AppColors.red, width: 2.5)),
          child: child,
        ),
      ],
    );
  }
}

class MyIconButton extends StatelessWidget {
  const MyIconButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.height,
      this.width});

  final Widget child;
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
            BoxShadow(
                blurRadius: 6,
                spreadRadius: 1.5,
                offset: const Offset(0, 5),
                color: Colors.black.withOpacity(.25))
          ]),
          child: MaterialButton(
            onPressed: onPressed,
            elevation: 8,
            height: height,
            minWidth: width,
            padding: EdgeInsets.zero,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: child,
          ),
        ),
      ],
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .5,
      width: MediaQueryHelper.sizeFromWidth(context, 1),
      color: Colors.grey.withOpacity(.5),
    );
  }
}

class CloseComponent extends StatelessWidget {
  const CloseComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.close,
        size: 28,
        color: Colors.black,
      ),
    );
  }
}

////////////////////////
bool validatePassword(String value) {
  RegExp regex =
      RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()\-=+{};:,<.>]).*$');
  return regex.hasMatch(value);
}

bool containsOnlyDigits(String input) {
  RegExp digitRegExp = RegExp(r'^[0-9]+$');
  return digitRegExp.hasMatch(input);
}

// Define regular expressions for validation
final RegExp accountNameRegex = RegExp(r'^[A-Za-z\s]+$');
final RegExp bankNameRegex = RegExp(r'^[A-Za-z\s]+$');
final RegExp accountNumberRegex = RegExp(
    r'^\d{10}$'); // You can adjust the pattern to your specific account number format
final RegExp ibanRegex = RegExp(
    r'^[A-Z]{2}\d{2}[A-Z0-9]{4}\d{7}([A-Z0-9]?){0,16}$'); // You can adjust the IBAN pattern as needed

class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  const ClipShadowPath({
    Key? key,
    required this.shadow,
    required this.clipper,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: clipper,
        shadow: shadow,
      ),
      child: ClipPath(clipper: clipper, child: child),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ButtonTemplate extends StatelessWidget {
  ButtonTemplate({
    Key? key,
    required this.color,
    this.isLoading = false,
    this.colorText = AppColors.primaryColor,
    required this.text1,
    required this.onPressed,
    this.icon,
    this.width = 318,
    this.minheight = 60,
    this.fontSize = 18,
  }) : super(key: key);
  Color color;
  Color colorText;
  String text1;
  final bool isLoading;
  double width;
  double minheight;
  double fontSize;
  IconData? icon;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: minheight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon == null
                  ? SizedBox()
                  : Center(
                      child: Icon(icon, size: 21, color: AppColors.white),
                    ),
              SizedBox(
                width: 5,
              ),
              isLoading
                  ? LoadingWidget(
                      type: LoadingType.threeBounce,
                      color: AppColors.white,
                      size: 18,
                    )
                  : Center(
                      child: Text(text1,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.titleText
                              .copyWith(color: colorText, fontSize: 20)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

enum LoadingType {
  threeBounce,
  doubleBounce,
}

class LoadingWidget extends StatelessWidget {
  final LoadingType type;
  final Color color;
  final double size;

  const LoadingWidget({
    super.key,
    this.type = LoadingType.doubleBounce,
    this.color = AppColors.greenYellow,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      LoadingType.threeBounce => SpinKitThreeBounce(
          color: color,
          size: size,
        ),
      LoadingType.doubleBounce => SpinKitDoubleBounce(
          color: color,
          size: size,
        ),
    };
  }
}

class SpinKitDoubleBounce extends StatefulWidget {
  const SpinKitDoubleBounce({
    Key? key,
    this.color,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 2000),
    this.controller,
  })  : assert(
            !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
                !(itemBuilder == null && color == null),
            'You should specify either a itemBuilder or a color'),
        super(key: key);

  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  State<SpinKitDoubleBounce> createState() => _SpinKitDoubleBounceState();
}

class _SpinKitDoubleBounceState extends State<SpinKitDoubleBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      })
      ..repeat(reverse: true);
    _animation = Tween(begin: -1.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: List.generate(2, (i) {
          return Transform.scale(
            scale: (1.0 - i - _animation.value.abs()).abs(),
            child: SizedBox.fromSize(
                size: Size.square(widget.size), child: _itemBuilder(i)),
          );
        }),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: widget.color!.withOpacity(0.6)));
}

class SpinKitThreeBounce extends StatefulWidget {
  const SpinKitThreeBounce({
    Key? key,
    this.color,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1400),
    this.controller,
  })  : assert(
            !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
                !(itemBuilder == null && color == null),
            'You should specify either a itemBuilder or a color'),
        super(key: key);

  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  State<SpinKitThreeBounce> createState() => _SpinKitThreeBounceState();
}

class _SpinKitThreeBounceState extends State<SpinKitThreeBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 2, widget.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (i) {
            return ScaleTransition(
              scale: DelayTween(begin: 0.0, end: 1.0, delay: i * .2)
                  .animate(_controller),
              child: SizedBox.fromSize(
                  size: Size.square(widget.size * 0.5), child: _itemBuilder(i)),
            );
          }),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(
          decoration:
              BoxDecoration(color: widget.color, shape: BoxShape.circle));
}

class DelayTween extends Tween<double> {
  DelayTween({double? begin, double? end, required this.delay})
      : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) =>
      super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}

class CustomInputDecorator extends StatelessWidget {
  final Widget body;
  final IconData? leadingIcon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color leadingIconColor;
  final bool focused;
  final EdgeInsets padding;
  final bool disableTapRippleEffect;

  const CustomInputDecorator({
    super.key,
    required this.body,
    this.leadingIcon,
    this.trailing,
    this.onTap,
    this.leadingIconColor = AppColors.black,
    this.focused = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    this.disableTapRippleEffect = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: AppColors.white,
      child: InkWell(
        onTap: onTap,
        overlayColor: disableTapRippleEffect
            ? MaterialStateColor.resolveWith(
                (states) => Colors.transparent,
              )
            : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.mediumGrey,
                width: 1,
                strokeAlign: 1,
              )),
          child: Row(
            children: [
              if (leadingIcon != null) ...[
                Icon(
                  leadingIcon,
                  color: leadingIconColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(child: body),
              if (trailing != null) ...[
                const SizedBox(width: 12),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabChanged;
  final Color backgroundColor;
  final Color selectedColor;
  final bool disableShadow;
  final EdgeInsets padding;
  final EdgeInsets itemPadding;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.backgroundColor = AppColors.white,
    this.selectedColor = AppColors.blue,
    this.disableShadow = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 1),
    this.itemPadding = const EdgeInsets.all(15),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQueryHelper.sizeFromWidth(context, 1),
      // height: MediaQueryHelper.sizeFromHeight(context, 13),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          if (!disableShadow)
            const BoxShadow(
              color: AppColors.grey,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < tabs.length; i++)
            CustomTabBarItem(
              padding: itemPadding,
              backgroundColor: backgroundColor,
              label: tabs[i],
              selectedColor: selectedColor,
              selected: selectedIndex == i,
              onTap: () => onTabChanged(i),
            )
        ],
      ),
    );
  }
}

class CustomTabBarItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color selectedColor;
  final EdgeInsets padding;

  const CustomTabBarItem({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.backgroundColor = AppColors.white,
    this.selectedColor = AppColors.primaryColor,
    this.padding = const EdgeInsets.all(2),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color: selected ? selectedColor : backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: padding,
            child: FittedBox(
              child: Text(
                label,
                maxLines: 1,
                style: AppTextStyles.titleText.copyWith(
                  color: selected ? AppColors.white : AppColors.mediumGrey,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
