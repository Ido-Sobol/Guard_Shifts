import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

GraphQLClient getClient() {
  final HttpLink httpLink = HttpLink(
    "https://close-humpback-29.hasura.app/v1/graphql",
    defaultHeaders: {
      "x-hasura-admin-secret":
          "tfVwCx8N3bPrsq5mvx9i8sz0cwy9SkMh9g4WzCnLICS8ArFOSUcNrTGnLueX9e3C"
    },
  );
  final WebSocketLink webSocketLink = WebSocketLink(
    "wss://close-humpback-29.hasura.app/v1/graphql",
    config: const SocketClientConfig(initialPayload: {
      "headers": {
        "x-hasura-admin-secret":
            "tfVwCx8N3bPrsq5mvx9i8sz0cwy9SkMh9g4WzCnLICS8ArFOSUcNrTGnLueX9e3C"
      }
    }),
  );
  return GraphQLClient(
    link: Link.split(
      (final Request request) => request.isSubscription,
      webSocketLink,
      httpLink,
    ),
    cache: GraphQLCache(),
  );
}

extension MapQueryResult<A> on QueryResult<A> {
  A mapQueryResult() => (hasException
      ? throw exception!
      : data == null
          ? (throw Exception("Data returned null"))
          : parsedData!);
}

A queryResultToParsed<A>(final QueryResult<A> result) =>
    result.mapQueryResult();

extension MapSnapshot<T> on AsyncSnapshot<T> {
  V mapSnapshot<V>({
    required final V Function(T) onSuccess,
    required final V Function() onWaiting,
    required final V Function() onNoData,
    required final V Function(Object) onError,
  }) =>
      hasError
          ? onError(error!)
          : (ConnectionState.waiting == connectionState
              ? onWaiting()
              : (hasData ? onSuccess(data as T) : onNoData()));
}
