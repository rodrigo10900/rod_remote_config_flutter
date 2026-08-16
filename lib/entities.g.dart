// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// IsarCollectionGenerator rod
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRemoteConfigDataEntCollection on Isar {
  IsarCollection<RemoteConfigDataEnt> get remoteConfigDataEnts =>
      this.collection();
}

const RemoteConfigDataEntSchema = CollectionSchema(
  name: r'RemoteConfigDataEnt',
  id: -5416125260790628635,
  properties: {
    r'data': PropertySchema(id: 0, name: r'data', type: IsarType.string),
    r'timestamp': PropertySchema(
      id: 1,
      name: r'timestamp',
      type: IsarType.long,
    ),
  },

  estimateSize: _remoteConfigDataEntEstimateSize,
  serialize: _remoteConfigDataEntSerialize,
  deserialize: _remoteConfigDataEntDeserialize,
  deserializeProp: _remoteConfigDataEntDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _remoteConfigDataEntGetId,
  getLinks: _remoteConfigDataEntGetLinks,
  attach: _remoteConfigDataEntAttach,
  version: '3.3.2',
);

int _remoteConfigDataEntEstimateSize(
  RemoteConfigDataEnt object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.data;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _remoteConfigDataEntSerialize(
  RemoteConfigDataEnt object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.data);
  writer.writeLong(offsets[1], object.timestamp);
}

RemoteConfigDataEnt _remoteConfigDataEntDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RemoteConfigDataEnt();
  object.data = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.timestamp = reader.readLongOrNull(offsets[1]);
  return object;
}

P _remoteConfigDataEntDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _remoteConfigDataEntGetId(RemoteConfigDataEnt object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _remoteConfigDataEntGetLinks(
  RemoteConfigDataEnt object,
) {
  return [];
}

void _remoteConfigDataEntAttach(
  IsarCollection<dynamic> col,
  Id id,
  RemoteConfigDataEnt object,
) {
  object.id = id;
}

extension RemoteConfigDataEntQueryWhereSort
    on QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QWhere> {
  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RemoteConfigDataEntQueryWhere
    on QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QWhereClause> {
  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension RemoteConfigDataEntQueryFilter
    on
        QueryBuilder<
          RemoteConfigDataEnt,
          RemoteConfigDataEnt,
          QFilterCondition
        > {
  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'data'),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'data'),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  dataEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'data',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  dataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'data',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  dataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'data',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  dataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'data',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  dataStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'data',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  dataEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'data',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  dataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'data',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  dataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'data',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  dataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'data', value: ''),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  dataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'data', value: ''),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  timestampIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'timestamp'),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  timestampIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'timestamp'),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  timestampEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timestamp', value: value),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  timestampGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timestamp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  timestampLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timestamp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterFilterCondition>
  timestampBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timestamp',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension RemoteConfigDataEntQueryObject
    on
        QueryBuilder<
          RemoteConfigDataEnt,
          RemoteConfigDataEnt,
          QFilterCondition
        > {}

extension RemoteConfigDataEntQueryLinks
    on
        QueryBuilder<
          RemoteConfigDataEnt,
          RemoteConfigDataEnt,
          QFilterCondition
        > {}

extension RemoteConfigDataEntQuerySortBy
    on QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QSortBy> {
  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterSortBy>
  sortByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterSortBy>
  sortByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterSortBy>
  sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterSortBy>
  sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension RemoteConfigDataEntQuerySortThenBy
    on QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QSortThenBy> {
  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterSortBy>
  thenByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterSortBy>
  thenByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterSortBy>
  thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QAfterSortBy>
  thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension RemoteConfigDataEntQueryWhereDistinct
    on QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QDistinct> {
  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QDistinct>
  distinctByData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'data', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QDistinct>
  distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension RemoteConfigDataEntQueryProperty
    on QueryBuilder<RemoteConfigDataEnt, RemoteConfigDataEnt, QQueryProperty> {
  QueryBuilder<RemoteConfigDataEnt, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RemoteConfigDataEnt, String?, QQueryOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data');
    });
  }

  QueryBuilder<RemoteConfigDataEnt, int?, QQueryOperations>
  timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
