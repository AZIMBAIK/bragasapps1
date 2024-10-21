
import 'package:flutter/material.dart';
import 'package:bragasapps1/core.dart';
import '../view/kasut2_view.dart';

class Kasut2Controller extends State<Kasut2View> {
    static late Kasut2Controller instance;
    late Kasut2View view;

    @override
    void initState() {
        instance = this;
        super.initState();
    }

    @override
    void dispose() => super.dispose();

    @override
    Widget build(BuildContext context) => widget.build(context, this);
}
        
    