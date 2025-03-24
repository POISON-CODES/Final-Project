part of 'custom_global_widgets.dart';

class SearchMultiSelectField extends FormFields {
  final void Function(List<String>) onChanged;
  final List<String>? initialValues;
  final String? searchHint;

  const SearchMultiSelectField({
    super.key,
    super.fieldType = FieldType.multiselect,
    required super.label,
    required super.dropDownItemsList,
    required this.onChanged,
    this.initialValues,
    this.searchHint,
    super.isRequired = true,
  });

  @override
  State<SearchMultiSelectField> createState() => _SearchMultiSelectFieldState();
}

class _SearchMultiSelectFieldState extends State<SearchMultiSelectField> {
  final List<String> _selectedItems = [];
  bool _isExpanded = false;
  final GlobalKey _dropdownKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialValues != null) {
      _selectedItems.addAll(widget.initialValues!);
    }
    _filteredItems = widget.dropDownItemsList ?? [];

    // Set up a listener to close the dropdown when focus is lost
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isExpanded) {
        setState(() {
          _removeOverlay();
          _isExpanded = false;
        });
      }
    });

    // Add listener for search text changes
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _removeOverlay();
    _focusNode.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }

    if (query.isEmpty) {
      _filteredItems = widget.dropDownItemsList ?? [];
    } else {
      _filteredItems = (widget.dropDownItemsList ?? [])
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    }
  }

  void _removeOverlay() {
    _searchController.clear();
    _filteredItems = widget.dropDownItemsList ?? [];
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
      builder: (outerContext) => StatefulBuilder(
        builder: (context, setOverlayState) {
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
                            maxHeight: 350,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Search Box
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  // Prevent tap from closing the overlay
                                  onTap: () {
                                    // Intercept the tap to prevent closing
                                  },
                                  child: TextField(
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      hintText:
                                          widget.searchHint ?? "Search...",
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ),

                              // Dropdown Items List
                              Flexible(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: NotificationListener<
                                      OverscrollIndicatorNotification>(
                                    onNotification: (overscroll) {
                                      overscroll.disallowIndicator();
                                      return true;
                                    },
                                    child: ListView.builder(
                                      controller: _scrollController,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: _filteredItems.length,
                                      itemBuilder: (context, index) {
                                        final item = _filteredItems[index];
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
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
                    // Display selected items as chips inside the container
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 58, 12),
                      child: _selectedItems.isEmpty
                          ? Text(
                              "${widget.label}${widget.isRequired ? ' *' : ''}",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: _selectedItems.map((item) {
                                return Chip(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: Colors.blue.shade100,
                                  labelPadding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  padding: const EdgeInsets.all(0),
                                  label: Text(
                                    item,
                                    style: TextStyle(
                                      color: Colors.blue.shade800,
                                      fontSize: 14,
                                    ),
                                  ),
                                  deleteIcon: Icon(
                                    Icons.cancel,
                                    size: 16,
                                    color: Colors.blue.shade800,
                                  ),
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
                    // Dropdown and clear icons
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
      ],
    );
  }
}
