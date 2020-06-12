import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLObjectProvider{

  static ValueNotifier<GraphQLClient> client;
  //MARK:- For Subscription through web socket
  final admin_secret_key = "UrkVSqvsZYToekRx";

  ValueNotifier<GraphQLClient> graphQlConnection(){
    HttpLink httpLink =
    HttpLink(uri: 'https://gql.attendance.rajwafers.anant.io/v1/graphql', headers: {
       'x-hasura-admin-secret': admin_secret_key,
    });

    final WebSocketLink websocketLink = WebSocketLink(
      url: 'ws://gql.attendance.rajwafers.anant.io/v1/graphql',
      config: SocketClientConfig(
          initPayload: () async {
            return {
              "headers": {"x-hasura-admin-secret": admin_secret_key},
            };
          },
          autoReconnect: true,inactivityTimeout: Duration(seconds: 15)),
    );

    Link link = httpLink as Link;

    Link webSocketLink = link.concat(websocketLink);

    client = ValueNotifier(
      GraphQLClient(
        cache: InMemoryCache(),
//        cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
        link: webSocketLink,
      ),
    );
    return client;
  }
}

GraphQLObjectProvider graphQLObjectProvider = GraphQLObjectProvider();