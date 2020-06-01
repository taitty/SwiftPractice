import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/usecase/usecase.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock implements GetConcreteNumberTrivia {}
class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}
class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(concrete: mockGetConcreteNumberTrivia,
    random: mockGetRandomNumberTrivia, inputConverter: mockInputConverter);
  });

  test('initialState should be Empty', () {
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTriviaForConcretenNumber', () {
    final tNumberString = '1';
    final tNumberParsed = int.parse(tNumberString);
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() => when(mockInputConverter.stringToUnsignedInteger(any)).thenReturn(Right(tNumberParsed));

    test(
      'should call the InputConverter to validate and convert the string to an unsigned integer', 
      () async {
        setUpMockInputConverterSuccess();
        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      }
    );

    test(
      'should emit [Error] when the input is invalid', 
      () async {
        when(mockInputConverter.stringToUnsignedInteger(any)).thenReturn(Left(InvalidInputFailure()));
        final expected = [
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
      }
    );

    test(
      'should get data from the concrete use case', 
      () async {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any)).thenAnswer((_) async => Right(tNumberTrivia));

        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockGetConcreteNumberTrivia(any));

        verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
      }
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully', 
      () async {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any)).thenAnswer((_) async => Right(tNumberTrivia));

        final expected = [
          Empty(),
          Loading(),
          Loaded(trivia: tNumberTrivia)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
      }
    );

    test(
      'should emit [Loading, Error] when getting data fails', 
      () async {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any)).thenAnswer((_) async => Left(ServerFailure()));

        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE)
        ];

        expectLater(bloc.state, emitsInOrder(expected));
        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
      }
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails', 
      () async {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any)).thenAnswer((_) async => Left(CacheFailure()));

        final expected = [
          Empty(),
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE)
        ];

        expectLater(bloc.state, emitsInOrder(expected));
        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
      }
    );
  });

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    test(
      'should get data from the random use case',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // act
        bloc.dispatch(GetTriviaForRandomNumber());
        await untilCalled(mockGetRandomNumberTrivia(any));
        // assert
        verify(mockGetRandomNumberTrivia(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(trivia: tNumberTrivia),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.dispatch(GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.dispatch(GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.dispatch(GetTriviaForRandomNumber());
      },
    );
  });
}