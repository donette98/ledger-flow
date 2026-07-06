class TeamMember {
  final String id;
  final String userId;
  final String email;
  final String name;
  final String role; // 'admin', 'editor', 'viewer'
  final String status; // 'active', 'invited', 'inactive'
  final DateTime joinedAt;
  final DateTime? invitedAt;
  final String companyId;
  final List<String> permissions;

  TeamMember({
    required this.id,
    required this.userId,
    required this.email,
    required this.name,
    required this.role,
    required this.status,
    required this.joinedAt,
    this.invitedAt,
    required this.companyId,
    this.permissions = const [],
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? 'viewer',
      status: json['status'] as String? ?? 'active',
      joinedAt: json['joinedAt'] is DateTime
          ? json['joinedAt']
          : DateTime.parse(json['joinedAt'] as String? ?? DateTime.now().toIso8601String()),
      invitedAt: json['invitedAt'] != null
          ? json['invitedAt'] is DateTime
              ? json['invitedAt']
              : DateTime.parse(json['invitedAt'] as String)
          : null,
      companyId: json['companyId'] as String? ?? '',
      permissions: List<String>.from(json['permissions'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'email': email,
      'name': name,
      'role': role,
      'status': status,
      'joinedAt': joinedAt.toIso8601String(),
      'invitedAt': invitedAt?.toIso8601String(),
      'companyId': companyId,
      'permissions': permissions,
    };
  }

  TeamMember copyWith({
    String? id,
    String? userId,
    String? email,
    String? name,
    String? role,
    String? status,
    DateTime? joinedAt,
    DateTime? invitedAt,
    String? companyId,
    List<String>? permissions,
  }) {
    return TeamMember(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
      invitedAt: invitedAt ?? this.invitedAt,
      companyId: companyId ?? this.companyId,
      permissions: permissions ?? this.permissions,
    );
  }

  bool canEditTransactions() => role == 'admin' || role == 'editor';
  bool canDeleteTransactions() => role == 'admin';
  bool canManageTeam() => role == 'admin';
}
