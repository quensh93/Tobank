import 'package:flutter/material.dart';
import 'package:ispect/ispect.dart' hide ISpectColumnBuilder;
import '../controllers/ispect_view_controller.dart';
import '../extensions/context.dart';
import '../utils/screen_size.dart';
import 'base_card.dart';
import 'column_builder.dart';

/// Bottom sheet for configuring log viewer settings.
/// Matches the original ISpect settings bottom sheet style exactly.
class ISpectSettingsBottomSheet extends StatefulWidget {
  const ISpectSettingsBottomSheet({
    required this.iSpectLogger,
    required this.options,
    required this.actions,
    required this.controller,
    super.key,
  });

  /// ISpectLogger implementation
  final ValueNotifier<ISpectLogger> iSpectLogger;

  /// Options for `ISpect`
  final ISpectOptions options;

  /// Actions to display in the settings bottom sheet
  final List<ISpectActionItem> actions;

  /// Controller for the ISpect view
  final ISpectViewController controller;

  Future<void> show(BuildContext context) async {
    await context.screenSizeMaybeWhen(
      phone: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        routeSettings: const RouteSettings(name: 'ISpect Logs Settings Sheet'),
        builder: (_) => this,
      ),
      orElse: () => showDialog<void>(
        context: context,
        useRootNavigator: false,
        routeSettings: const RouteSettings(name: 'ISpect Logs Settings Dialog'),
        builder: (_) => this,
      ),
    );
  }

  @override
  State<ISpectSettingsBottomSheet> createState() => _ISpectSettingsBottomSheetState();
}

class _ISpectSettingsBottomSheetState extends State<ISpectSettingsBottomSheet> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.iSpectLogger.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iSpect = ISpect.read(context);
    final settings = <Widget>[
      ISpectSettingsCardItem(
        title: context.ispectL10n.enabled,
        enabled: widget.iSpectLogger.value.options.enabled,
        backgroundColor: context.ispectTheme.cardColor,
        onChanged: (enabled) {
          (enabled
                  ? widget.iSpectLogger.value.enable
                  : widget.iSpectLogger.value.disable)
              .call();
          // Trigger UI update by calling setState
          setState(() {});
        },
      ),
      ISpectSettingsCardItem(
        canEdit: widget.iSpectLogger.value.options.enabled,
        title: context.ispectL10n.useConsoleLogs,
        backgroundColor: context.ispectTheme.cardColor,
        enabled: widget.iSpectLogger.value.options.useConsoleLogs,
        onChanged: (enabled) {
          widget.iSpectLogger.value.configure(
            options: widget.iSpectLogger.value.options.copyWith(
              useConsoleLogs: enabled,
            ),
          );
          // Trigger UI update by calling setState
          setState(() {});
        },
      ),
      ISpectSettingsCardItem(
        canEdit: widget.iSpectLogger.value.options.enabled,
        title: context.ispectL10n.useHistory,
        backgroundColor: context.ispectTheme.cardColor,
        enabled: widget.iSpectLogger.value.options.useHistory,
        onChanged: (enabled) {
          widget.iSpectLogger.value.configure(
            options: widget.iSpectLogger.value.options.copyWith(
              useHistory: enabled,
            ),
          );
          // Trigger UI update by calling setState
          setState(() {});
        },
      ),
    ];

    return context.screenSizeMaybeWhen(
      phone: () => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => _SettingsBody(
          iSpect: iSpect,
          settings: settings,
          scrollController: scrollController,
          actions: widget.actions,
        ),
      ),
      orElse: () => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: context.ispectTheme.scaffoldBackgroundColor,
        content: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.7,
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: _SettingsBody(
            iSpect: iSpect,
            settings: settings,
            scrollController: _scrollController,
            actions: widget.actions,
          ),
        ),
      ),
    );
  }
}

class _SettingsBody extends StatelessWidget {
  const _SettingsBody({
    required this.iSpect,
    required this.settings,
    required this.scrollController,
    required this.actions,
  });

  final ISpectScopeModel iSpect;
  final List<Widget> settings;
  final ScrollController scrollController;
  final List<ISpectActionItem> actions;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.ispectTheme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          interactive: true,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                sliver: SliverToBoxAdapter(
                  child: _Header(title: context.ispectL10n.settings),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(bottom: 16, top: 8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.ispectTheme.cardColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: iSpect.theme.dividerColor(context) ??
                              context.ispectTheme.dividerColor,
                        ),
                      ),
                    ),
                    child: ISpectColumnBuilder(
                      itemCount: settings.length,
                      itemBuilder: (_, index) => Column(
                        children: [
                          settings[index],
                          if (index != settings.length - 1)
                            Divider(
                              color: iSpect.theme.dividerColor(context) ??
                                  context.ispectTheme.dividerColor,
                              height: 1,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(bottom: 16),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.ispectTheme.cardColor,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: iSpect.theme.dividerColor(context) ??
                              context.ispectTheme.dividerColor,
                        ),
                      ),
                    ),
                    child: ISpectColumnBuilder(
                      itemCount: actions.length,
                      itemBuilder: (_, index) {
                        final action = actions[index];
                        return _ActionTile(
                          action: action,
                          showDivider: index != actions.length - 1,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: _HowToReachMeWidget(),
                ),
              ),
            ],
          ),
        ),
      );
}

class _HowToReachMeWidget extends StatelessWidget {
  const _HowToReachMeWidget();

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Text.rich(
              TextSpan(
                text: 'ISpect',
                style: context.ispectTheme.textTheme.titleLarge?.copyWith(
                  color: context.ispectTheme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
}

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = context.ispectTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              theme.textTheme.headlineSmall?.copyWith(color: theme.textColor),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          visualDensity: VisualDensity.compact,
          icon: Icon(Icons.close_rounded, color: theme.textColor),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.action,
    this.showDivider = true,
  });

  final ISpectActionItem action;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final iSpect = ISpect.read(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: ListTile(
            onTap: () => _onTap(context),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            dense: true,
            title: Text(
              action.title,
              style: context.ispectTheme.textTheme.bodyMedium,
            ),
            leading: Icon(action.icon, color: context.ispectTheme.textColor),
          ),
        ),
        if (showDivider)
          Divider(
            color: iSpect.theme.dividerColor(context) ??
                context.ispectTheme.dividerColor,
            height: 1,
          ),
      ],
    );
  }

  void _onTap(BuildContext context) {
    Navigator.pop(context);
    action.onTap?.call(context);
  }
}

class ISpectSettingsCardItem extends StatelessWidget {
  const ISpectSettingsCardItem({
    required this.title,
    required this.enabled,
    required this.onChanged,
    super.key,
    this.canEdit = true,
    this.subtitle,
    this.backgroundColor = const Color.fromARGB(255, 49, 49, 49),
  });

  final String title;
  final String? subtitle;
  final bool enabled;
  final Function(bool enabled) onChanged;
  final bool canEdit;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final iSpect = ISpect.read(context);
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: canEdit ? 1 : 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: ISpectBaseCard(
          padding: const EdgeInsets.symmetric(horizontal: 4).copyWith(right: 4),
          color: iSpect.theme.dividerColor(context) ??
              context.ispectTheme.dividerColor,
          backgroundColor: backgroundColor,
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              dense: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              contentPadding: EdgeInsets.zero,
              title: Text(
                title,
                style: TextStyle(
                  color: context.ispectTheme.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle!,
                      style: TextStyle(
                        color: context.ispectTheme.textColor.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    )
                  : null,
              trailing: Switch(
                value: enabled,
                onChanged: canEdit ? onChanged : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
