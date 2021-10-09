import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:fooderlich/models/grocery_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating;

  const GroceryItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _GroceryItemScreenState createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();

    final originalItem = widget.originalItem;

    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Grocery Item',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // TODO 24: Add callback handler
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildNameField(context),
            const SizedBox(height: 16),
            buildImportanceField(context),
            const SizedBox(height: 16),
            buildDateField(context),
            const SizedBox(height: 16),
            buildTimeField(context),
            const SizedBox(height: 16),
            buildColorPicker(context),
            const SizedBox(height: 16),
            buildQuantityField(),
            const SizedBox(height: 16),
            // TODO: 19: Add Grocery Tile
          ],
        ),
      ),
    );
  }

  Widget buildNameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item name',
          style: GoogleFonts.lato(fontSize: 28),
        ),
        TextField(
          autofocus: true,
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'E.g. Apples, Banana, 1 bag of salt',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildImportanceField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: GoogleFonts.lato(fontSize: 28),
        ),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.low,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.low;
                });
              },
              label: const Text(
                'low',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.medium,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.medium;
                });
              },
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.high,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.high;
                });
              },
              label: const Text(
                'high',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28),
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final currentDate = DateTime.now();

                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );

                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
            ),
          ],
        ),
        Text(DateFormat('dd/MM/yyyy').format(_dueDate)),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of Day',
              style: GoogleFonts.lato(fontSize: 28),
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                setState(() {
                  if (timeOfDay != null) {
                    _timeOfDay = timeOfDay;
                  }
                });
              },
            ),
          ],
        ),
        Text(_timeOfDay.format(context)),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50.0,
              width: 10.0,
              color: _currentColor,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Color',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
          ],
        ),
        TextButton(
          child: const Text('Select'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: BlockPicker(
                    pickerColor: Colors.white,
                    onColorChanged: (color) {
                      setState(() => _currentColor = color);
                    },
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.lato(fontSize: 28),
            ),
            const SizedBox(width: 16),
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18),
            ),
          ],
        ),
        Slider(
          inactiveColor: _currentColor.withOpacity(0.5),
          activeColor: _currentColor,
          value: _currentSliderValue.toDouble(),
          min: 0.0,
          max: 100.0,
          divisions: 100,
          label: _currentSliderValue.toInt().toString(),
          onChanged: (double value) {
            setState(
              () {
                _currentSliderValue = value.toInt();
              },
            );
          },
        ),
      ],
    );
  }
}
