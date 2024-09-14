part of 'app_button.dart';

class FabAnimationButton extends StatefulWidget {
  final bool showFab;
  final ScrollController scrollController;
  final List<Widget> children;
  const FabAnimationButton(
      {super.key,
      this.showFab = true,
      required this.scrollController,
      required this.children});

  @override
  State<FabAnimationButton> createState() => _FabAnimationButtonState();
}

class _FabAnimationButtonState extends State<FabAnimationButton> {
  late bool _showFab;

  @override
  void initState() {
    _showFab = widget.showFab;
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_showFab) {
          setState(() {
            _showFab = false;
          });
        }
      } else {
        if (!_showFab) {
          setState(() {
            _showFab = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 100),
      offset: _showFab ? Offset.zero : const Offset(0, 2),
      child: AnimatedOpacity(
        opacity: _showFab ? 1 : 0,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 300),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: widget.children),
      ),
    );
  }
}
