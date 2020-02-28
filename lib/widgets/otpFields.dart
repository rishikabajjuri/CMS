import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpFields extends StatefulWidget {
  final length;
  final List<TextEditingController> controllers;
  final GlobalKey formKey;

  const OtpFields(
      {Key key,
        @required this.length,
        this.controllers,
        this.formKey,
        })
      : super(key: key);

  @override
  _OtpFieldsState createState() => _OtpFieldsState();
}

class _OtpFieldsState extends State<OtpFields> {
//  final formKey=GlobalKey<FormState>();
//  final List<TextEditingController> controllers;
//  final List<FocusNode> focusNodes;
  final List<FocusNode> focusNodes=List<FocusNode>();
//  _OtpFieldsState(this.controllers, this.focusNodes);
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.length; i++) {
      focusNodes.add(FocusNode());
      widget.controllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Row(
        children: List.generate(
          widget.length,
              (int i) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  validator: (text) => text.length == 1 ? null : '',
                  controller: widget.controllers[i],
                  focusNode: focusNodes[i],
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'X', hintStyle: TextStyle(color: Colors.black87)),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    if (i == widget.length - 1) {
                      focusNodes[i].unfocus();
                      return;
                    }
                    switch (value.length) {
                      case 0:
                        focusNodes[i].previousFocus();
                        break;
                      case 2:
                        widget.controllers[i].clear();
                        break;
                      default:
                        focusNodes[i + 1].nextFocus();
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}