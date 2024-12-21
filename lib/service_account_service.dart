import 'package:googleapis_auth/auth_io.dart';

const serviceAccount = {
  "type": "service_account",
  "project_id": "apphen-22",
  "private_key_id": "a696789157a35a0f3c61302032980cc794d27922",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCCot3DkpvvgSfr\nIQ2A10KylPciazJ+tOoJ7jXE8quz9XxSKIEmvQDFn2pCBY91P+qKhbzk++BuBn7C\n3/WYNY8wzqz0tjyp1QNeQ7xZX4igO7t3h703Pbvu8kFyYlZsw1J/nSXmq2V5jf46\nSARCXSWtuMmPa72p+mzHXXBRdvroQHGaMuUnxREyjlLIEpEao8oWkvNajulVKfGy\n9MylgObkgNZ2KwkrduF5cuqdt3g/qxbNHkzbCLIsMJ2xSUCjHoDL0lfEg8j/rqtr\nhhw5+xjvaXvE00QjU7KOlBdAC5WeMBYpVb7XvTYeGw9M44zPqKNrC+HBpgygTN1a\nF/0diz7HAgMBAAECggEAA8pmtZ0UdJpX0S/QAilniw0IMBx825uzoCl5r/GmtShu\nEhLmJHye1XKEanlaKfnP0XMuAar5XoKbvQXd94EJBaPe9ZQwJcbDkUGqk8v83UFp\nICp1KBwyJC3YDlH3gLJuO2ZmSiThDeo73URnszvxXZ1wuSj+2ObRBJFGiBFJbeHI\n4nsQu+JBzufNHp+jXJ/I3hsQ+6NtP/O00dguRRmJEplJCxKAyF7HJWKuZQhfHZRa\ntlpQhAA9pzVeaq7J/8jruXfwe5yzr9FFGdIUSZYf4IAJ6Mx/dA0BmMigESg7vzSw\nnSOd1zjrdUZ4FGmDK4zVwWpYZ7gflCgMhky+mMRToQKBgQC3yu2KcqW6dQHU/OCi\n1VQcFZnMBc94TRB3VGTvyTNGlOczJprsdvUDqzGJPTnHMUFQThu9/wmE5RKmwHQ2\n71hjrDpr3UvyMNCwjckYOYFXHZTfw2n7oTrr+mPtdbHON1vYsoipTdfwecG+ss4S\nyUUWPDgGM74DysqNQxagnDVz0QKBgQC19bBY61//TlyE05LyrYgEzYNOL5UvsMhg\n5aycYqJStSTtQhKISFU89Yrd8BIn+eNL/NR9w+NP/muCtoO54sRAEmaz09pfmb5P\nh3fllAHW02mTxVEEliNSykZlO0FhhqFJ6rjCaSutAMCFB4n6ZeC0rqgs8fJcK5Se\nexSgMcknFwKBgCbWmhXMnlrliOqSOYIPZIO+yM5FWA9K8bTVv7KwKMa8hpLXkJtx\nk9sfnQssRf5i2TN4HgKrVz6fDa7xMl29fEcryPisPfVC/Yahn6If3MYk+SXD7KyA\n6KufMOioG1fBeQY0zA5C5ePqRtfefw+XOqM1PH2LB5dTjjQFvk1YVS9RAoGATAnW\n3uHFpRAfE5bCss0XqUIkm/jAdESBCBUSk+uX/84ZF1jkG7V2gVnu5R4cyD3h4XBP\ncBr7FAOy89XHqFd+QXQvHPjsKcU6xUtMLFE0j4ybcxgi6jK/oipLTqR7hwDWx+fh\nu8RtbweAbFchLtWCGJ9gQh/9csz3d17h2KvVbpMCgYBXOdXS7Kn9EN+Ld6HFnNdO\nWmObR7Yq5QpSCTvSulRsN11Rr8yLjHP2JGUO9kmZqKnd6XuLjjDXCJPE3/8QH8If\noXI7ZYRJPpKcLpEeHzAlhzs2WM37EXnvSItxbtZnuQ1ZaliIGQHIAzijWdt89Yhc\nQlLuNPljOnA7DDertxJ1/A==\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-uwdyd@apphen-22.iam.gserviceaccount.com",
  "client_id": "106975652459621546765",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-uwdyd%40apphen-22.iam.gserviceaccount.com",
};

Future<String> getAccessToken() async {
  final accountCredentials = ServiceAccountCredentials.fromJson(serviceAccount);
  final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

  final AuthClient authClient = await clientViaServiceAccount(accountCredentials, scopes);
  final accessToken = authClient.credentials.accessToken.data;

  authClient.close();
  return accessToken;
}
