part of 'custom_global_widgets.dart';

class CustomDropDown extends FormFields {
  final void Function(String?) onChanged;
  final String? initialValue;
  final List<Widget>? customItems;

  const CustomDropDown({
    super.key,
    super.fieldType = FieldType.dropdown,
    super.isRequired = true,
    required super.label,
    required super.dropDownItemsList,
    required this.onChanged,
    this.initialValue,
    this.customItems,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? _selectedItem;
  bool _isExpanded = false;
  final GlobalKey _dropdownKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialValue;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleDropdown() {
    setState(() {
      if (_isExpanded) {
        _removeOverlay();
      } else {
        _showOverlay();
      }
      _isExpanded = !_isExpanded;
    });
  }

  void _showOverlay() {
    RenderBox renderBox =
        _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 250,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: widget.customItems != null
                    ? widget.customItems!
                    : widget.dropDownItemsList?.map((item) {
                          bool isSelected = _selectedItem == item;
                          return ListTile(
                            dense: true,
                            title: Text(item),
                            trailing: isSelected
                                ? Icon(Icons.check,
                                    color: Theme.of(context).primaryColor)
                                : null,
                            onTap: () {
                              setState(() {
                                _selectedItem = item;
                                widget.onChanged(_selectedItem);

                                // Close the dropdown after selection
                                _removeOverlay();
                                _isExpanded = false;
                              });
                            },
                          );
                        }).toList() ??
                        [],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  String _getDisplayText() {
    if (_selectedItem == null) {
      return "${widget.label}${widget.isRequired ? ' *' : ''}";
    } else {
      return _selectedItem!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          width: double.infinity,
          key: _dropdownKey,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              if (_selectedItem == null)
                Positioned(
                  left: 16,
                  top: 20,
                  child: Text(
                    "${widget.label}${widget.isRequired ? ' *' : ''}",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  _selectedItem == null ? "" : _getDisplayText(),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Positioned(
                right: 16,
                child: Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.grey.shade700,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
