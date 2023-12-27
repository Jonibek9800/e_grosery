import 'package:flutter/material.dart';

class SearchLineWidget extends StatelessWidget {
  final bool readOnly;
  final VoidCallback onTap;
  final ValueChanged<String>? onChange;
  final bool autofocus;

  const SearchLineWidget({
    super.key,
    required this.readOnly,
    required this.onTap,
    this.onChange,
    required this.autofocus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            // focusNode: focusNode,
            autofocus: autofocus,
            readOnly: readOnly,
            // style: const TextStyle(color: Colors.grey),
            onTap: onTap,
            onChanged: onChange,
            decoration: InputDecoration(
              filled: true,
              // fillColor: Colors.black45,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  // color: Colors.grey,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(15)),
              hintText: "Search Producs",
              hintStyle: const TextStyle(color: Colors.grey),
              isCollapsed: true,
              suffixIcon: const Icon(Icons.search),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.keyboard_voice_rounded),
          // style: ButtonStyle(
          //   backgroundColor: MaterialStateProperty.all(const Color(0xFF56AE7C)),
          // ),
          // color: Colors.white,
        ),
      ],
    );
  }
}
