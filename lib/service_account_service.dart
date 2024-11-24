import 'package:googleapis_auth/auth_io.dart';

const serviceAccount = {
  "type": "service_account",
  "project_id": "joyufulapp",
  "private_key_id": "5c0aa790d99f5ebe2c6940bd9f196c929f4c73c6",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQCdl04K4AFJpcQA\nkFWEyCzyWtesgihK1jMoWUuNGbzeVdqvrfgTjbobBBbjopME2JuQLMMO+lbWIgJ6\nWHy+0yUijzUknSfXmBJ8Hm5Z3l35ZoRviA3ijOpqX8ysOL6WytiotnRvvEJTboz/\nDKNDzcjmSYvrzho4XQI7veDqM8wPwse+Bpv6rLY9OFGpJu6cxn7iso9zGILaTjBL\nRyjR3dBI+hNJJ4jF1sooIqG93tZuLi1owv8IFsqOBTrK5JYB8e4w3LcrxSn5fAgJ\nk7P06u/b8ZuKeFGnXN7P7DMLd7ze1VYSUBoK9YP+usFg1jx8ct9lIj22mpVEnoow\n1lYD5XCNAgMBAAECgf853VTKqXXPlQ5jJpxAJUBbvP90WFZzJDOknSUgqlKvUNb7\nquVsSJ4NTXMaIpfZL6/vQIBe/4zjE5nVUqh7aQw5pFvfFdWLVEt1R7c9SGk5Kmt2\niH6QsS1h4ctFcZCJzfHAAT6/yGCSQgWDoSBRxT3/UQIPk54NFBm91frABETphAhL\nGNltNPrM19XwK1qlqVii09s+NEZAoa2+8dAULMYEC9D7C344xRdgmOv4cEbQpkz+\nvWLZ9MePt/0bySSW9I2u4E9sud9TXhxouJex1Ots5xKG5Qr+NuryDYLT5xd6SMVE\nlIyY1wSXN3Z/tegWTIv6iZppoNj96GMYixO/vckCgYEAzO/YiyYfl2lGxQgG4nuN\nJmPKmE0xSoSOsK+MvqVfhLDfNDP6D9sCFBRhWgkVGzkaWYRtUreazcAdrskC8u1Z\nq3HWAmHVySGpOVH451RC7NKW2nPfvKRgeTWDFRc5ClZuBoLb57nez0FKHxm6dnVi\n/maLo7yzh2H0yCS64Drbva8CgYEAxNtxwyYZoYgru4XgnPhUmQwMwHzjFmkRY1ir\nRrSycTPUhSMsLqjAy3alO0Qlp3PqqUj9fGgQDnVmDHpTVc2Ezp/mCx5C/qjfPEL0\nqtCFqHbGVbSkpahpk3cWK+WAR0i9yJwdi7TLf9KWnZsPxpQefjIadrUv4J8+g2Yr\nVE76oIMCgYAhqaALM0brKwrJ4Iio+Rx1WtzzaXKYR+/cS+m1gxqOhDMVsxf3NMVB\noRtgm69Q2m9elucSOECAXXdCt5f5aU1aYQeDOqjQMexHExTsgqW/mtPWrEPrC6Eh\nJ84RT9A5x3qpLSOMC7bymknfk+1R+fQ5z4ROb/eZXFjF62qa3HAt1wKBgGbmUlvw\nwXsXI8z82QEUKZxqmQvQ/B8NwsIMalMmRxQ3RIJndUPagBSaqxoEsC4MwH/GoIH0\nH1h/c11YX9E9AYvEN0pegiR9f1sPoLbdEtCRbXEFYP8avj0QBa3iZCBe3J1NRYBu\ne+UP3hz6Hc/uQtYyOHUOlr0yYEntEP8b3ZQjAoGBAMZWvnN/03DEYoZejoKcHxMo\no9P/SDHZaHdoOuwd6XPx+W2viyEup/asrjgJROllGA6PP9sGFeIKiPkA6uw+07kq\nK7XIouJohBvR6GCm7hYbrxUImVLrwGlUFgVYGlFvQd6SPsNIQ4FzmUkeG775xA0Z\nKpAGToYaYtVMNJ0SL9YU\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-df7o9@joyufulapp.iam.gserviceaccount.com",
  "client_id": "105789063971127245916",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-df7o9%40joyufulapp.iam.gserviceaccount.com",
};

Future<String> getAccessToken() async {
  final accountCredentials = ServiceAccountCredentials.fromJson(serviceAccount);
  final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

  final AuthClient authClient = await clientViaServiceAccount(accountCredentials, scopes);
  final accessToken = authClient.credentials.accessToken.data;

  authClient.close();
  return accessToken;
}
