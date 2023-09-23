
class AppResponse<T> {
  int errorCode = -1;
  String? errorMsg;
  T? data;


  AppResponse(this.errorCode, this.errorMsg, this.data);
}