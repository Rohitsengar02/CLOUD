// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$upcomingBookingsHash() => r'6bfa61525c5ca5970f9876ac6b5d076c90330c89';

/// See also [upcomingBookings].
@ProviderFor(upcomingBookings)
final upcomingBookingsProvider =
    AutoDisposeProvider<List<BookingModel>>.internal(
      upcomingBookings,
      name: r'upcomingBookingsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$upcomingBookingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpcomingBookingsRef = AutoDisposeProviderRef<List<BookingModel>>;
String _$pastBookingsHash() => r'e58a56e8b8de0668aab9957d239fe425b97e191f';

/// See also [pastBookings].
@ProviderFor(pastBookings)
final pastBookingsProvider = AutoDisposeProvider<List<BookingModel>>.internal(
  pastBookings,
  name: r'pastBookingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pastBookingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PastBookingsRef = AutoDisposeProviderRef<List<BookingModel>>;
String _$bookingsHash() => r'45f655fdb93360d124d6432ada25a2dadd75fa34';

/// See also [Bookings].
@ProviderFor(Bookings)
final bookingsProvider =
    NotifierProvider<Bookings, List<BookingModel>>.internal(
      Bookings.new,
      name: r'bookingsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bookingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Bookings = Notifier<List<BookingModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
