import 'package:test/test.dart';
import 'package:list_ext/list_ext.dart';
import 'package:tuple/tuple.dart';

void main() {
  group('Iterable', () {
    test('count of elements with property value', () {
      final list = [
        _E(strVal: 'OK'),
        _E(strVal: 'not OK'),
        _E(),
        _E(strVal: 'OK'),
        _E(boolVal: true)
      ];

      expect(list.countWhere((e) => e.strVal == 'OK'), 2);
    });

    test('isNullOrEmpty/isNotNullOrEmpty for null iterable', () {
      Iterable list;

      expect(list.isNullOrEmpty, true);
      expect(list.isNotNullOrEmpty, false);
    });

    test('isNullOrEmpty/isNotNullOrEmpty for empty iterable', () {
      Iterable list = [];

      expect(list.isNullOrEmpty, true);
      expect(list.isNotNullOrEmpty, false);
    });

    test('isNullOrEmpty/isNotNullOrEmpty for not empty iterable', () {
      final list = [1];

      expect(list.isNullOrEmpty, false);
      expect(list.isNotNullOrEmpty, true);
    });

    test('join of object field', () {
      final list = [_E(strVal: 'first'), _E(strVal: 'second')];

      expect(list.joinOf((e) => e.strVal, ', '), 'first, second');
    });

    test('split into chunks', () {
      final list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

      expect(list.chunks(3), [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
        [10]
      ]);
    });

    test('get map from iterable', () {
      final list = [1, 2, 3];

      expect(
          list.toMap(
            (e) => 'K${e}',
            (e) => 'V${e}',
          ),
          {
            'K1': 'V1',
            'K2': 'V2',
            'K3': 'V3',
          });
    });

    test('firstWhereOrNull should return first if exist', () {
      final needle = _E(intVal: 1, strVal: 'first');
      final list = [needle, _E(intVal: 2), _E(intVal: 1, strVal: 'second')];

      expect(list.firstWhereOrNull((e) => e.intVal == 1), needle);
    });

    test('firstWhereOrNull should return null if not exist', () {
      final list = [_E(intVal: 2), _E(intVal: 3)];

      expect(list.firstWhereOrNull((e) => e.intVal == 1), null);
    });

    test('unordered equivalent true if has same elements', () {
      final list = [1, 2, 3];
      final other = [2, 1, 3];

      expect(list.isUnorderedEquivalent(other), true);
    });

    test('unordered equivalent false if has different elements', () {
      final list = [1, 2, 3];
      final other = [1, 2, 4];

      expect(list.isUnorderedEquivalent(other), false);
    });

    test('unordered equivalent false if has different length', () {
      final list = [1, 2, 3];
      final other = [1, 2];

      expect(list.isUnorderedEquivalent(other), false);
    });

    group('math', () {
      // Sum
      test('sum of int elements property', () {
        final list = [_E(intVal: 1), _E(intVal: 3)];

        expect(list.sumOf((e) => e.intVal), 4);
      });

      test('sum of double elements property', () {
        final list = [_E(doubleVal: 1.5), _E(doubleVal: 3.1)];

        expect(list.sumOfDouble((e) => e.doubleVal), 4.6);
      });

      // Average
      test('ceil avg of int elements property', () {
        final list = [_E(intVal: 1), _E(intVal: 3)];

        expect(list.avgOf((e) => e.intVal), 2);
      });

      test('float avg of int elements property', () {
        final list = [_E(intVal: 1), _E(intVal: 4)];

        expect(list.avgOf((e) => e.intVal), 2.5);
      });

      test('avg of int with negative', () {
        final list = [_E(intVal: 1), _E(intVal: -3)];

        expect(list.avgOf((e) => e.intVal), -1);
      });

      test('avg of empty', () {
        final list = [];

        expect(list.avgOf((e) => e.intVal), 0);
      });

      test('avg of double elements property', () {
        final list = [_E(doubleVal: 1.5), _E(doubleVal: 3.2)];

        expect(list.avgOfDouble((e) => e.doubleVal), 2.35);
      });

      test('avg of double with negative', () {
        final list = [_E(doubleVal: 2.1), _E(doubleVal: -1.1)];

        expect(list.avgOfDouble((e) => e.doubleVal), .5);
      });

      test('avg of double empty', () {
        final list = [];

        expect(list.avgOfDouble((e) => e.doubleVal), 0);
      });
    });
  });

  group('Iterable of int', () {
    test('sum elements', () {
      final list = [1, 2, 5];

      expect(list.sum(), 8);
    });

    group('avg()', () {
      final data = <Tuple3<String, Iterable<int>, double>>[
        Tuple3('simple', [1, 3, 5], 3),
        Tuple3('negative', [3, -2, 5], 2),
        Tuple3('float', [5, 4], 4.5),
        Tuple3('empty', [], 0),
      ];

      for (final d in data) {
        test('average elements: ${d.item1}', () {
          final list = d.item2;

          expect(list.avg(), d.item3);
        });
      }
    });
  });

  group('Iterable of double', () {
    test('sum elements', () {
      final list = [1.5, 2.3, 5.7];

      expect(list.sum(), 9.5);
    });

    group('avg()', () {
      final data = <Tuple3<String, Iterable<double>, double>>[
        Tuple3('simple', [1.6, 2.3, 5.7], 3.2),
        Tuple3('negative', [1.3, 2.3, -5.7], -.7),
        Tuple3('empty', [], 0),
      ];

      for (final d in data) {
        test('average elements: ${d.item1}', () {
          final list = d.item2;

          expect(list.avg(), closeTo(d.item3, .00001));
        });
      }
    });
  });
}

class _E {
  final int intVal;
  final double doubleVal;
  final String strVal;
  final bool boolVal;

  _E({this.intVal, this.doubleVal, this.strVal, this.boolVal});

  @override
  String toString() {
    return '_E{intVal: $intVal, doubleVal: $doubleVal, strVal: $strVal, boolVal: $boolVal}';
  }
}
