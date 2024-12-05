import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Utils/customColors.dart';

/// A selectable service item that displays either an icon or SVG asset with a label.
/// Used for service selection in menus or navigation.
class ServiceItem extends StatelessWidget {
  const ServiceItem({
    super.key,
    this.icon,
    this.svgAsset,
    required this.label,
    this.isSelected = false,
    this.isDisabled = false,
    this.onTap,
  }) : assert(icon != null || svgAsset != null,
            'Either icon or svgAsset must be provided');

  final IconData? icon;
  final String? svgAsset;
  final String label;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Material(
        borderRadius: BorderRadius.circular(15.0),
        elevation: 2,
        child: InkWell(
          onTap: isDisabled ? null : onTap,
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            decoration: BoxDecoration(
              color: isDisabled 
                  ? Colors.grey[300] 
                  : isSelected 
                      ? CustomColors.primaryColor 
                      : Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: 24,
                    color: isDisabled 
                        ? Colors.grey[600]
                        : isSelected 
                            ? Colors.white 
                            : Colors.black87,
                  )
                else if (svgAsset != null)
                  SvgPicture.asset(
                    svgAsset!,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      isDisabled 
                          ? Colors.grey[600]! 
                          : isSelected 
                              ? Colors.white 
                              : Colors.black87,
                      BlendMode.srcIn,
                    ),
                  ),
                const SizedBox(width: 12.0),
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: isDisabled 
                            ? Colors.grey[600]
                            : isSelected 
                                ? Colors.white 
                                : Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}