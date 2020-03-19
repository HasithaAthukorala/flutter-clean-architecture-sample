import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture_with_bloc_app/injection_container.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/domain/usecases/change_password.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/presentation/blocs/change_password/bloc.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/presentation/page/change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockChangePasswordBloc extends Mock implements ChangePasswordBloc {}

class MockChangePassword extends Mock implements ChangePassword {}

main() {
  var bloc = MockChangePasswordBloc();
  final Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: new ChangePasswordPage()));

  setUp(() {
    sl.allowReassignment = true;
    sl.registerSingleton<ChangePasswordBloc>(bloc);
    when(bloc.state).thenAnswer((_) => InitialState());
  });

  testWidgets('Test the initial state of the page',
      (WidgetTester tester) async {
    whenListen(bloc, Stream.fromIterable([InitialState()]));

    await tester.pumpWidget(testWidget);

    expect(find.byKey(Key('changePassword')), findsOneWidget);
  });

  testWidgets('Tap the chage password button',
      (WidgetTester tester) async {
    whenListen(bloc, Stream.fromIterable([InitialState()]));

    await tester.pumpWidget(testWidget);
    await tester.tap(find.byKey(Key('changePassword')));
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
  });
}
