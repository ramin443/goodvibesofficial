import 'package:flutter/material.dart';

class StreamBuilder2<A, B> extends StatelessWidget {
  StreamBuilder2(
      this.first,
      this.second, {
        Key key,
        this.firstInitialValue,
        this.secondInitialValue,
        this.builder,
      }) : super(key: key);

  final Stream<A> first;
  final Stream<B> second;
  final A firstInitialValue;
  final B secondInitialValue;
  final Widget Function(BuildContext context, A a, B b) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<A>(
      stream: first,
      initialData: firstInitialValue,
      builder: (_, a) {
        return StreamBuilder<B>(
          stream: second,
          initialData: secondInitialValue,
          builder: (context, b) {
            return builder(context, a.data, b.data);
          },
        );
      },
    );
  }
}

class StreamBuilder3<A, B, C> extends StatelessWidget {
  StreamBuilder3(
      this.first,
      this.second,
      this.third, {
        Key key,
        this.firstInitialValue,
        this.secondInitialValue,
        this.thirdInitialValue,
        this.builder,
      }) : super(key: key);

  final Stream<A> first;
  final Stream<B> second;
  final Stream<C> third;
  final A firstInitialValue;
  final B secondInitialValue;
  final C thirdInitialValue;
  final Widget Function(BuildContext context, A a, B b, C c) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<A>(
      stream: first,
      initialData: firstInitialValue,
      builder: (_, a) {
        return StreamBuilder<B>(
          stream: second,
          initialData: secondInitialValue,
          builder: (_, b) {
            return StreamBuilder<C>(
              stream: third,
              initialData: thirdInitialValue,
              builder: (context, c) {
                return builder(context, a.data, b.data, c.data);
              },
            );
          },
        );
      },
    );
  }
}
