class AuthSendModel{
  String userName ;
  String password ;
  String confirmPassword ;
  String companyName ;
  String phone ;
  String email ;


  AuthSendModel({this.userName, this.password, this.confirmPassword,
      this.companyName, this.phone , this.email});

  Map<String,String> toJson(){
    Map<String, String> data = new Map();
    if(this.userName != null) data['user_name'] = this.userName;
    if(this.password != null) data['password'] = this.password;
    if(this.confirmPassword != null) data['password_confirmation'] = this.confirmPassword;
    if(this.companyName != null) data['company_name'] = this.companyName;
    if(this.phone != null) data['phone'] = this.phone;
    if(this.email != null) data['email'] = this.email;

    return data ;
  }
}