part of 'ethers.dart';

/// A Network represents an Ethereum network.
class Network extends Interop<_NetworkImpl> {
  const Network._(super.impl) : super.internal();

  ///The Chain ID of the network.
  int get chainId => impl.chainId;

  ///The address at which the ENS registry is deployed on this network.
  String? get ensAddress => impl.ensAddress;

  ///The human-readable name of the network, such as homestead.
  ///
  ///If the network name is unknown, this will be "unknown".
  String get name => impl.name;

  @override
  String toString() => 'Network: $name at $chainId';
}
