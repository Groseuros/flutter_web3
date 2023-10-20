import 'package:flutter_web3/src/ethereum/ethereum.dart';
import 'package:flutter_web3/src/utils/chains.dart';

extension EtherumChainExt on Ethereum {
  /// Use `Ethereum.walletSwitchChain` function with [chain] information. RPC Url list in [chain] will be overridden if [rpcs] is not `null`.
  Future<void> walletSwitchChainByChains(Chains chain, [List<String>? rpcs]) => walletSwitchChain(
        chain.chainId,
        () => walletAddChain(
          chainId: chain.chainId,
          chainName: chain.name,
          nativeCurrency: chain.nativeCurrency,
          rpcUrls: rpcs ?? chain.rpc,
          blockExplorerUrls: chain.explorers,
        ),
      );
}
