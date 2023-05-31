class UserMoel {
  UserMoel({
     this.id,
     this.username,
     this.userNick,
     this.pwd,
     this.role,
     this.idCardNumber,
     this.workPermitNum,
     this.department,
     this.loginState,
     this.allowedLogin,
     this.createTime,
     this.updatetime,
  });

  factory UserMoel.fromJson(Map json) {
    return UserMoel(
      id: json['id'],
      username: json['username'],
      userNick: json['user_nick'],
      pwd: json['pwd'],
      role: json['role'],
      idCardNumber: json['id_card_number'],
      workPermitNum: json['WorkPermitNum'],
      department: json['Department'],
      loginState: json['LoginState'],
      allowedLogin: json['AllowedLogin'],
      createTime: json['create_time'],
      updatetime: json['updatetime'],
    );
  }

  final int? id;
  final String ? username;
  final String ? userNick;
  final String ? pwd;
  final int ?role;
  final String? idCardNumber;
  final String? workPermitNum;
  final String? department;
  final int? loginState;
  final int? allowedLogin;
  final int? createTime;
  final int? updatetime;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'user_nick': userNick,
      'pwd': pwd,
      'role': role,
      'id_card_number': idCardNumber,
      'WorkPermitNum': workPermitNum,
      'Department': department,
      'LoginState': loginState,
      'AllowedLogin': allowedLogin,
      'create_time': createTime,
      'updatetime': updatetime,
    };
  }

  UserMoel copyWith({
    int? id,
    String? username,
    String? userNick,
    String? pwd,
    int? role,
    String? idCardNumber,
    String? workPermitNum,
    String? department,
    int? loginState,
    int? allowedLogin,
    int? createTime,
    int? updatetime,
  }) {
    return UserMoel(
      id: id ?? this.id,
      username: username ?? this.username,
      userNick: userNick ?? this.userNick,
      pwd: pwd ?? this.pwd,
      role: role ?? this.role,
      idCardNumber: idCardNumber ?? this.idCardNumber,
      workPermitNum: workPermitNum ?? this.workPermitNum,
      department: department ?? this.department,
      loginState: loginState ?? this.loginState,
      allowedLogin: allowedLogin ?? this.allowedLogin,
      createTime: createTime ?? this.createTime,
      updatetime: updatetime ?? this.updatetime,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserMoel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          userNick == other.userNick &&
          pwd == other.pwd &&
          role == other.role &&
          idCardNumber == other.idCardNumber &&
          workPermitNum == other.workPermitNum &&
          department == other.department &&
          loginState == other.loginState &&
          allowedLogin == other.allowedLogin &&
          createTime == other.createTime &&
          updatetime == other.updatetime;

  @override
  int get hashCode => Object.hashAll([
        id,
        username,
        userNick,
        pwd,
        role,
        idCardNumber,
        workPermitNum,
        department,
        loginState,
        allowedLogin,
        createTime,
        updatetime,
      ]);
}
