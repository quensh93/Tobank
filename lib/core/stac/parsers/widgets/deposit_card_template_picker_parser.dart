import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';

class DepositCardTemplatePickerModel {
  const DepositCardTemplatePickerModel({
    this.selectedColorKey = 'depositCardIssue.templateColorHex',
    this.selectedFaceKey = 'depositCardIssue.templateIsFront',
  });

  final String selectedColorKey;
  final String selectedFaceKey;

  factory DepositCardTemplatePickerModel.fromJson(Map<String, dynamic> json) {
    return DepositCardTemplatePickerModel(
      selectedColorKey:
          (json['selectedColorKey'] as String?) ??
          'depositCardIssue.templateColorHex',
      selectedFaceKey:
          (json['selectedFaceKey'] as String?) ??
          'depositCardIssue.templateIsFront',
    );
  }
}

class DepositCardTemplatePickerParser
    extends StacParser<DepositCardTemplatePickerModel> {
  const DepositCardTemplatePickerParser();

  @override
  String get type => 'depositCardTemplatePicker';

  @override
  DepositCardTemplatePickerModel getModel(Map<String, dynamic> json) =>
      DepositCardTemplatePickerModel.fromJson(json);

  @override
  Widget parse(BuildContext context, DepositCardTemplatePickerModel model) {
    return _DepositCardTemplatePicker(model: model);
  }
}

class _CardColorOption {
  const _CardColorOption({required this.hex});

  final String hex;

  Color get color {
    final value = int.parse(hex.replaceFirst('#', ''), radix: 16);
    return Color(0xFF000000 | value);
  }
}

class _DepositCardTemplatePicker extends StatefulWidget {
  const _DepositCardTemplatePicker({required this.model});

  final DepositCardTemplatePickerModel model;

  @override
  State<_DepositCardTemplatePicker> createState() =>
      _DepositCardTemplatePickerState();
}

class _DepositCardTemplatePickerState extends State<_DepositCardTemplatePicker>
    with SingleTickerProviderStateMixin {
  static const List<_CardColorOption> _colors = [
    _CardColorOption(hex: '#FF8A00'),
    _CardColorOption(hex: '#95EF4D'),
    _CardColorOption(hex: '#101010'),
    _CardColorOption(hex: '#38C7D4'),
    _CardColorOption(hex: '#B7B0D9'),
    _CardColorOption(hex: '#2E52B8'),
    _CardColorOption(hex: '#E48AA7'),
    _CardColorOption(hex: '#9FA4AA'),
    _CardColorOption(hex: '#1C2A59'),
    _CardColorOption(hex: '#ED1B2F'),
    _CardColorOption(hex: '#7A1FA2'),
    _CardColorOption(hex: '#0F9D58'),
  ];

  static const double _cardWidth = 230;
  static const double _cardHeight = 336;

  late final ScrollController _colorScrollController;
  late final AnimationController _flipController;

  int _selectedIndex = 9; // red

  @override
  void initState() {
    super.initState();
    _colorScrollController = ScrollController();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 430),
      value: 0,
    );

    _syncRegistry();
  }

  @override
  void dispose() {
    _colorScrollController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  void _toggleFace() {
    final target = _flipController.value < 0.5 ? 1.0 : 0.0;
    _flipController.animateTo(
      target,
      curve: Curves.easeInOutCubic,
    );
    StacRegistry.instance.setValue(widget.model.selectedFaceKey, target < 0.5);
  }

  void _scrollColors(bool right) {
    if (!_colorScrollController.hasClients) return;

    const delta = 180.0;
    final current = _colorScrollController.offset;
    final target = right ? current + delta : current - delta;
    final max = _colorScrollController.position.maxScrollExtent;

    _colorScrollController.animateTo(
      target.clamp(0.0, max),
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  void _selectColor(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });
    _syncRegistry();
  }

  void _syncRegistry() {
    StacRegistry.instance.setValue(
      widget.model.selectedColorKey,
      _colors[_selectedIndex].hex,
    );
    StacRegistry.instance.setValue(
      widget.model.selectedFaceKey,
      _flipController.value < 0.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleColor = Theme.of(context).textTheme.titleMedium?.color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: GestureDetector(
            onTap: () {
              _toggleFace();
              _syncRegistry();
            },
            child: AnimatedBuilder(
              animation: _flipController,
              builder: (context, child) {
                final angle = _flipController.value * math.pi;
                final showFront = angle <= (math.pi / 2);

                return Transform(
                  alignment: Alignment.center,
                  transform:
                      Matrix4.identity()
                        ..setEntry(3, 2, 0.0014)
                        ..rotateY(angle),
                  child: showFront
                      ? _buildCardStack(_buildFrontCard())
                      : Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateY(math.pi),
                          child: _buildCardStack(_buildBackCard()),
                        ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: AnimatedBuilder(
            animation: _flipController,
            builder: (context, child) {
              final isFront = _flipController.value < 0.5;
              return Text(
                isFront ? 'روی کارت' : 'پشت کارت',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 26),
        Row(
          children: [
            _ArrowButton(
              icon: Icons.chevron_left,
              onTap: () => _scrollColors(false),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SingleChildScrollView(
                controller: _colorScrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(_colors.length, (index) {
                    final isSelected = index == _selectedIndex;

                    return Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 0 : 14),
                      child: GestureDetector(
                        onTap: () => _selectColor(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 170),
                          width: isSelected ? 40 : 30,
                          height: isSelected ? 40 : 30,
                          decoration: BoxDecoration(
                            color: _colors[index].color,
                            shape: BoxShape.circle,
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 22,
                                )
                              : null,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(width: 8),
            _ArrowButton(
              icon: Icons.chevron_right,
              onTap: () => _scrollColors(true),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardStack(Widget frontOrBackCard) {
    return SizedBox(
      width: 292,
      height: 404,
      child: Stack(
        children: [
          Positioned(
            left: 34,
            top: 42,
            child: _buildCardLayer(const Color(0xFFEFDCE2)),
          ),
          Positioned(
            left: 18,
            top: 58,
            child: _buildCardLayer(const Color(0xFFD0D0D4)),
          ),
          Positioned(
            left: 28,
            top: 20,
            child: frontOrBackCard,
          ),
        ],
      ),
    );
  }

  Widget _buildCardLayer(Color color) {
    return Container(
      width: _cardWidth,
      height: _cardHeight,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildFrontCard() {
    final selectedColor = _colors[_selectedIndex].color;

    return Container(
      width: _cardWidth,
      height: _cardHeight,
      decoration: BoxDecoration(
        color: selectedColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 16,
                  height: 22,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6EEDF),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const Text(
                  'TOBANK',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Text(
              'Tobank.ir',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    final selectedColor = _colors[_selectedIndex].color;

    return Container(
      width: _cardWidth,
      height: _cardHeight,
      decoration: BoxDecoration(
        color: selectedColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 22),
          Container(height: 38, color: const Color(0xFF111111)),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    '123',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Text(
              'www.tobank.ir',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: SizedBox(
        width: 28,
        height: 28,
        child: Icon(
          icon,
          size: 28,
          color: Theme.of(context).textTheme.titleMedium?.color,
        ),
      ),
    );
  }
}

void registerDepositCardTemplatePickerParser() {
  CustomComponentRegistry.instance.registerWidget(
    const DepositCardTemplatePickerParser(),
  );
}
