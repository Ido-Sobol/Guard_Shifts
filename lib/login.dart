import 'package:graphql/client.dart';
import 'package:shidts/hasura_helper.dart';

const String mutation = r"""
mutation InsertGuard($name: String!, $uid: String!) {
  insert_guard(objects: {name: $name, auth_key: $uid}, on_conflict: {constraint: guard_auth_key_key, update_columns:name}) {
    returning {
      name
    }
  }
}

""";
Future<void> login(final String uid, final String username) async {
  await getClient().mutate(
    MutationOptions(
      document: gql(mutation),
      parserFn: (data) {},
      variables: {
        "name": username,
        "uid": uid,
      },
    ),
  );
}
