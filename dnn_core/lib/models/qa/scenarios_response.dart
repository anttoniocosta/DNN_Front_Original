class ScenariosResponse {
  String? id;
  MemberModel? user;
  String? title;
  String? description;
  String? tag;
  String? userPrefix;
  List<MemberModel>? members;

  ScenariosResponse(
      {this.id,
      this.user,
      this.title,
      this.description,
      this.tag,
      this.userPrefix,
      this.members});

  ScenariosResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new MemberModel.fromJson(json['user']) : null;
    title = json['title'];
    description = json['description'];
    tag = json['tag'];
    userPrefix = json['userPrefix'];
    if (json['members'] != null) {
      members = <MemberModel>[];
      json['members'].forEach((v) {
        members!.add(new MemberModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['title'] = this.title;
    data['description'] = this.description;
    data['tag'] = this.tag;
    data['userPrefix'] = this.userPrefix;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MemberModel {
  String? id;
  String? name;
  String? email;
  String? role;
  String? login;
  String? password;

  MemberModel(
      {this.id, this.name, this.email, this.role, this.login, this.password});

  MemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    login = json['login'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['login'] = this.login;
    data['password'] = this.password;
    return data;
  }

  bool get isSeller => role!.toLowerCase() == 'vendedor';
  bool get isManager => role!.toLowerCase() == 'gerente';
  bool get isDirector => role!.toLowerCase() == 'diretor';
  bool get isCliente => role!.toLowerCase() == 'cliente';
  bool get isCompany => role!.toLowerCase() == 'empresa';
  bool get isAdmin => role!.toLowerCase() == 'administrador';

  bool get isPartner => isSeller || isManager || isDirector;
}
