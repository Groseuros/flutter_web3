part of 'wallet_connect.dart';

@JS()
@anonymous
class _QrcodeModalOptionsImpl {
  external factory _QrcodeModalOptionsImpl({List<String> mobileLinks});

  external List<String> get mobileLinks;
}

@JS()
@anonymous
class _RequestArgumentsImpl {
  external factory _RequestArgumentsImpl({
    required String method,
    dynamic params,
  });

  external String get method;

  external dynamic get params;
}

@JS('default')
class _WalletConnectProviderImpl {
  external _WalletConnectProviderImpl(
    _WalletConnectProviderOptionsImpl options,
  );

  external List<String> get accounts;

  external String get chainId;

  external bool get connected;

  external bool get isConnecting;

  external String get rpcUrl;

  external _WalletMetaImpl get walletMeta;

  external int listenerCount([String? eventName]);

  external List<dynamic> listeners(String eventName);

  external void removeAllListeners([String? eventName]);
}

@JS()
@anonymous
class _WalletConnectProviderOptionsImpl {
  external factory _WalletConnectProviderOptionsImpl({
    String? infuraId,
    dynamic rpc,
    String? bridge,
    bool? qrCode,
    String? network,
    int? chainId,
    int? networkId,
    _QrcodeModalOptionsImpl? qrcodeModalOptions,
  });

  external String? get bridge;

  external int? get chainId;

  external String? get infuraId;

  external String? get network;

  external bool? get qrCode;

  external _QrcodeModalOptionsImpl? get qrcodeModalOptions;

  external dynamic get rpc;
}

@JS()
@anonymous
class _WalletMetaImpl {
  external String get description;

  external List<dynamic> get icons;

  external String get name;

  external String get url;
}

@JS('WalletConnectEthereumProvider')
class _WalletConnectEthereumProviderImpl {
  external static Future<_WalletConnectEthereumProviderImpl> init(_WalletConnectEthereumProviderOptionsImpl options);

  external List<String> get accounts;

  external int get chainId;

  external bool get connected;

  external bool get isConnecting;

  external String get rpcUrl;

  external int listenerCount([String? eventName]);

  external List<dynamic> listeners(String eventName);

  external void removeAllListeners([String? eventName]);
}

@JS()
@anonymous
class _WalletConnectEthereumProviderOptionsImpl {
  external factory _WalletConnectEthereumProviderOptionsImpl({
    String projectId,
    List<int> chains,
    List<int>? optionalChains,
    dynamic rpcMap,
    bool? showQrModal,
  });

  external String projectId;
  external List<int> chains;
  external List<int>? optionalChains;
  external List<String>? methods;
  external dynamic rpcMap;
  external bool? showQrModal;

// qrModalOptions?: QrModalOptions;
// optionalMethods?: string[];
// events?: string[];
// optionalEvents?: string[];
// metadata?: Metadata;
}

@JS()
@anonymous
class ConnectOps {
  external List<int>? chains;
  external List<int>? optionalChains;
  external Map<int, String>? rpcMap;
  external String? pairingTopic;
}

@JS()
@anonymous
class _EthereumChainParameterImpl {
  external factory _EthereumChainParameterImpl({
    required String chainId,
  });

  external String get chainId;
}
