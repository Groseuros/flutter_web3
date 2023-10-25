import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

/// Dart Class for ERC721 Contract, A standard API for non-fungible tokens within smart contracts.
///
/// Implements both IERC721 IERC721Metadata base interfaces.
class ContractERC721 {
  /// Minimal abi interface of ERC721.
  static const abi = [
    'function name() external view returns (string)',
    'function symbol() external view returns (string)',
    'function tokenURI(uint256 tokenId) external view returns (string)',
    'function balanceOf(address owner) external view returns (uint256)',
    'function ownerOf(uint256 tokenId) external view returns (address)',
    'function safeTransferFrom(address from, address to, uint256 tokenId, bytes data) external payable',
    'function safeTransferFrom(address from, address to, uint256 tokenId) external payable',
    'function transferFrom(address from, address to, uint256 tokenId) external payable',
    'function approve(address approved, uint256 tokenId) external payable',
    'function setApprovalForAll(address operator, bool approved) external',
    'function getApproved(uint256 tokenId) external view returns (address)',
    'function isApprovedForAll(address owner, address operator) external view returns (bool)',
    'event Transfer(address indexed from, address indexed to, uint256 indexed tokenId)',
    'event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId)',
    'event ApprovalForAll(address indexed owner, address indexed operator, bool approved)',
  ];

  /// Ethers Contract object.
  late Contract contract;

  String _name = '';
  String _symbol = '';
  String _tokenUri = '';

  /// Instantiate ERC721 Contract.
  ContractERC721(String address, dynamic providerOrSigner, [dynamic abi])
      : assert(providerOrSigner != null, 'providerOrSigner should not be null'),
        assert(address.isNotEmpty, 'address should not be empty'),
        assert(
          EthUtils.isAddress(address),
          'address should be in address format',
        ) {
    final fullABI = (abi != null && (abi is List<String> || abi is String))
        ? abi is List<String>
            ? [...ContractERC721.abi, ...abi]
            : [...ContractERC721.abi, abi]
        : ContractERC721.abi;

    contract = Contract(
      address,
      fullABI,
      providerOrSigner,
    );
  }

  /// `true` if connected to [Provider], `false` if connected to [Signer].
  bool get isReadOnly => contract.isReadOnly;

  /// Returns the name of the token. If token doesn't have name, return empty string.
  Future<String> get name async {
    try {
      if (_name.isEmpty) _name = await contract.call<String>('name');
    } catch (error) {
      debugPrint(error.toString());
    }
    return _name;
  }

  /// Returns the symbol of the token, usually a shorter version of the name.
  Future<String> get symbol async {
    try {
      if (_symbol.isEmpty) _symbol = await contract.call<String>('symbol');
    } catch (error) {
      debugPrint(error.toString());
    }
    return _symbol;
  }

  /// Returns the tokenURI of the token.
  Future<String> tokenUri(BigInt tokenId) async {
    try {
      if (_tokenUri.isEmpty) _tokenUri = await contract.call<String>('tokenURI', []);
    } catch (error) {
      debugPrint(error.toString());
    }
    return _tokenUri;
  }

  /// Returns the amount of tokens owned by [address].
  Future<BigInt> balanceOf(String address) async => contract.call<BigInt>('balanceOf', [address]);

  /// Returns the address that owns the [tokenId].
  Future<String> ownerOf(BigInt tokenId) async => contract.call<String>('ownerOf', [tokenId]);

  /// Transfers [tokenId] token from [from] to [to]. Emits `Transfer` event when called.
  Future<TransactionResponse> safeTransferFromWithData(String from, String to, BigInt tokenId, String data) async =>
      contract.send('safeTransferFrom', [from, to, tokenId, data]);

  /// Transfers [tokenId] token from [from] to [to]. Emits `Transfer` event when called.
  Future<TransactionResponse> safeTransferFrom(String from, String to, BigInt tokenId) async =>
      contract.send('safeTransferFrom', [from, to, tokenId]);

  /// Transfers [tokenId] token from [from] to [to]. Emits `Transfer` event when called.
  Future<TransactionResponse> transferFrom(String from, String to, BigInt tokenId) async =>
      contract.send('transferFrom', [from, to, tokenId]);

  /// Gives [address] permission to transfer [tokenId] to another account.
  ///
  /// The approval is cleared when the token is transferred. Emits `Approval` event when called.
  Future<TransactionResponse> approve(String address, BigInt tokenId) async =>
      contract.send('approve', [address, tokenId]);

  /// Approve or remove [address] as an operator for the caller.
  ///
  /// Operators can call transferFrom or safeTransferFrom for any token owned by the caller.
  ///
  /// Emits `ApprovalForAll` event when called.
  Future<TransactionResponse> setApprovalForAll(String address, {required bool approved}) async =>
      contract.send('setApprovalForAll', [address, approved]);

  /// Returns the account approved for tokenId token.
  Future<String> getApproved(BigInt tokenId) async => contract.call<String>('getApproved', [tokenId]);

  /// Returns if the [operatorAddress] is allowed to manage all of the assets of [ownerAddress].
  Future<bool> isApprovedForAll(String ownerAddress, String operatorAddress) async =>
      contract.call<bool>('isApprovedForAll', [ownerAddress, operatorAddress]);

  /// Emitted when `tokenId` is transferred from address `from` to  address `to`.
  void onTransfert(void Function(String from, String to, BigInt tokenId, Event event) callback) => contract.on(
        'Transfert',
        (String from, String to, BigInt tokenId, dynamic data) => callback(
          from,
          to,
          tokenId,
          Event.fromJS(data),
        ),
      );

  /// Emitted when `owner` enables `approved` to manage the `tokenId` token.
  void onApproval(void Function(String owner, String approved, BigInt tokenId, Event event) callback) => contract.on(
        'Approval',
        (String owner, String approved, BigInt tokenId, dynamic data) => callback(
          owner,
          approved,
          tokenId,
          Event.fromJS(data),
        ),
      );

  /// Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
  // ignore: avoid_positional_boolean_parameters
  void onApprovalForAll(void Function(String owner, String operator, bool approved, Event event) callback) =>
      contract.on(
        'ApprovalForAll',
        (String owner, String operator, bool approved, dynamic data) => callback(
          owner,
          operator,
          approved,
          Event.fromJS(data),
        ),
      );

  /// [Log] of `Transfer` events.
  Future<List<Event>> transferEvents([
    List<dynamic>? args,
    dynamic startBlock,
    dynamic endBlock,
  ]) =>
      contract.queryFilter(
        contract.getFilter('Transfer', args ?? []),
        startBlock,
        endBlock,
      );

  /// [Log] of `Approval` events.
  Future<List<Event>> approvalEvents([
    List<dynamic>? args,
    dynamic startBlock,
    dynamic endBlock,
  ]) =>
      contract.queryFilter(
        contract.getFilter('Approval', args ?? []),
        startBlock,
        endBlock,
      );

  /// [Log] of `ApprovalForAll` events.
  Future<List<Event>> approvalForAllEvents([
    List<dynamic>? args,
    dynamic startBlock,
    dynamic endBlock,
  ]) =>
      contract.queryFilter(
        contract.getFilter('ApprovalForAll', args ?? []),
        startBlock,
        endBlock,
      );
}

/// Dart Mixin for ERC721Burnable that allows token holders to destroy both their own tokens and those that they have been approved to use.
mixin ERC721Burnable on ContractERC721 {
  /// Burns (destroy) [tokenId]
  Future<TransactionResponse> burn(BigInt tokenId) => contract.send('burn', [tokenId]);
}

// /// Dart Mixin for ERC721URIStorage
// mixin ERC721URIStorage on ContractERC721 {
//   Future<TransactionResponse> setTokenUri(BigInt tokenId, String tokenUri) => contract.send('_setTokenURI', [tokenId, tokenUri]);
// }

class ContractERC721Burnable extends ContractERC721 with ERC721Burnable {
  static const burnAbi = 'function burn(uint256 tokenId) external';
  ContractERC721Burnable(String address, dynamic providerOrSigner, [dynamic abi])
      : super(
          address,
          providerOrSigner,
          (abi != null && (abi is List<String> || abi is String))
              ? abi is List<String>
                  ? [ContractERC721Burnable.burnAbi, ...abi]
                  : [ContractERC721Burnable.burnAbi, abi]
              : ContractERC721Burnable.burnAbi,
        );
}
