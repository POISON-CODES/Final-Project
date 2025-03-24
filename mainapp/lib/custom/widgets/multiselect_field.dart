part of 'custom_global_widgets.dart';

class MultiSelectField extends FormFields {
  final void Function(List<String>) onChanged;
  final List<String>? initialValues;

  const MultiSelectField({
    super.key,
    super.fieldType = FieldType.multiselect,
    required super.label,
    required super.dropDownItemsList,
    required this.onChanged,
    this.initialValues,
    super.isRequired = true,
  });

  @override
  State<MultiSelectField> createState() => _MultiSelectFieldState();
}

class _MultiSelectFieldState extends State<MultiSelectField> {
  final List<String> _selectedItems = [];
  bool _isExpanded = false;
  final GlobalKey _dropdownKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.initialValues != null) {
      _selectedItems.addAll(widget.initialValues!);
    }

    // Set up a listener to close the dropdown when focus is lost
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isExpanded) {
        setState(() {
          _removeOverlay();
          _isExpanded = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _removeOverlay();
    _focusNode.dispose();
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
        _focusNode.requestFocus();
      }
      _isExpanded = !_isExpanded;
    });
  }

  void _showOverlay() {
    RenderBox renderBox =
        _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
        builder: (outerContext) =>
            StatefulBuilder(builder: (context, setOverlayState) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _removeOverlay();
                  setState(() {
                    _isExpanded = false;
                  });
                },
                child: Container(
                  width: MediaQuery.of(outerContext).size.width,
                  height: MediaQuery.of(outerContext).size.height,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Positioned(
                        width: size.width,
                        left: offset.dx,
                        top: offset.dy + size.height,
                        child: CompositedTransformFollower(
                          link: _layerLink,
                          showWhenUnlinked: false,
                          offset: Offset(0, size.height),
                          child: Material(
                            color: Colors.white,
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: 250,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: NotificationListener<
                                    OverscrollIndicatorNotification>(
                                  onNotification: (overscroll) {
                                    overscroll.disallowIndicator();
                                    return true;
                                  },
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount:
                                        widget.dropDownItemsList?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final item =
                                          widget.dropDownItemsList![index];
                                      final isSelected =
                                          _selectedItems.contains(item);

                                      return GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          // Use setOverlayState to update the dropdown UI immediately
                                          setOverlayState(() {
                                            if (isSelected) {
                                              _selectedItems.remove(item);
                                            } else {
                                              _selectedItems.add(item);
                                            }
                                          });

                                          // Also update the parent widget's state
                                          setState(() {
                                            widget.onChanged(_selectedItems);
                                          });
                                        },
                                        child: Container(
                                          color: isSelected
                                              ? Colors.blue.shade100
                                              : Colors.transparent,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontWeight: isSelected
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                    color: isSelected
                                                        ? Colors.blue.shade800
                                                        : Colors.black87,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              if (isSelected)
                                                Icon(
                                                  Icons.check,
                                                  color: Colors.blue.shade800,
                                                  size: 20,
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));

    Overlay.of(context).insert(_overlayEntry!);
  }

  String _getDisplayText() {
    if (_selectedItems.isEmpty) {
      return "${widget.label}${widget.isRequired ? ' *' : ''}";
    } else if (_selectedItems.length == 1) {
      return _selectedItems.first;
    } else {
      return "${_selectedItems.length} items selected";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: Focus(
            focusNode: _focusNode,
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
                    if (_selectedItems.isEmpty)
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Text(
                        _selectedItems.isEmpty ? "" : _getDisplayText(),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Positioned(
                      right: 16,
                      child: Row(
                        children: [
                          if (_selectedItems.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedItems.clear();
                                  widget.onChanged(_selectedItems);
                                });
                              },
                              child: Icon(
                                Icons.clear,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                            ),
                          const SizedBox(width: 8),
                          Icon(
                            _isExpanded
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: Colors.grey.shade700,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_selectedItems.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: _selectedItems.map((item) {
                return Chip(
                  backgroundColor: Colors.blue.shade100,
                  label: Text(
                    item,
                    style: TextStyle(color: Colors.blue.shade800),
                  ),
                  deleteIcon:
                      Icon(Icons.cancel, size: 18, color: Colors.blue.shade800),
                  onDeleted: () {
                    setState(() {
                      _selectedItems.remove(item);
                      widget.onChanged(_selectedItems);
                    });
                  },
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
