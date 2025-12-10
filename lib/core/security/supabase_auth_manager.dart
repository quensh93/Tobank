import '../helpers/logger.dart';
import 'secure_config_storage.dart';

/// Mock user class for authentication
class MockUser {
  final String uid;
  final String? email;
  final String? displayName;
  final bool emailVerified;

  MockUser({
    required this.uid,
    this.email,
    this.displayName,
    this.emailVerified = false,
  });

  Future<String> getIdToken([bool forceRefresh = false]) async {
    // Return a mock token
    return 'mock_token_${uid}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> updateDisplayName(String displayName) async {
    // Mock implementation
  }

  Future<void> sendEmailVerification() async {
    // Mock implementation
  }
}

/// Mock Supabase authentication manager
///
/// Provides authentication functionality without Supabase dependencies.
/// This is a temporary implementation for development when Supabase is disabled.
class SupabaseAuthManager {
  /// Singleton instance
  static final SupabaseAuthManager instance = SupabaseAuthManager._();

  /// Private constructor
  SupabaseAuthManager._();

  /// Mock current user
  MockUser? _currentUser;

  /// Mock user roles storage
  final Map<String, Map<String, dynamic>> _userRoles = {};

  /// Secure storage for tokens
  final SecureConfigStorage _storage = SecureConfigStorage.instance;



  /// Current user stream (mock implementation)
  Stream<MockUser?> get authStateChanges => Stream.value(_currentUser);

  /// Current user
  MockUser? get currentUser => _currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  // ==================== Authentication Methods ====================

  /// Sign in with email and password
  ///
  /// Returns the authenticated user or throws an exception.
  Future<MockUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      AppLogger.i('🔐 Signing in user: $email');

      // Mock authentication logic
      if (email.isEmpty || password.isEmpty) {
        throw AuthException('Email and password are required');
      }

      // For demo purposes, accept any email/password combination
      // In a real implementation, this would validate against a backend
      final user = MockUser(
        uid: 'mock_${email.hashCode}',
        email: email,
        displayName: email.split('@').first,
        emailVerified: true,
      );

      _currentUser = user;

      // Store auth token securely
      final token = await user.getIdToken();
      await _storage.saveAuthToken(token);

      AppLogger.i('✅ User signed in successfully: ${user.uid}');
      return user;
    } catch (e, stackTrace) {
      AppLogger.e('❌ Sign in error', e, stackTrace);
      if (e is AuthException) rethrow;
      throw AuthException('Authentication failed: ${e.toString()}');
    }
  }

  /// Sign up with email and password
  ///
  /// Creates a new user account and returns the authenticated user.
  Future<MockUser> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      AppLogger.i('📝 Creating new user account: $email');

      // Mock user creation logic
      if (email.isEmpty || password.isEmpty) {
        throw AuthException('Email and password are required');
      }

      if (password.length < 6) {
        throw AuthException('Password must be at least 6 characters');
      }

      final user = MockUser(
        uid: 'mock_${email.hashCode}',
        email: email,
        displayName: displayName ?? email.split('@').first,
        emailVerified: false,
      );

      _currentUser = user;

      // Store auth token securely
      final token = await user.getIdToken();
      await _storage.saveAuthToken(token);

      // Initialize user role (default: regular user, not admin)
      await _initializeUserRole(user.uid);

      AppLogger.i('✅ User account created: ${user.uid}');
      return user;
    } catch (e, stackTrace) {
      AppLogger.e('❌ Sign up error', e, stackTrace);
      if (e is AuthException) rethrow;
      throw AuthException('User creation failed: ${e.toString()}');
    }
  }

  /// Sign out current user
  ///
  /// Clears authentication tokens and signs out.
  Future<void> signOut() async {
    try {
      AppLogger.i('👋 Signing out user');

      _currentUser = null;
      await _storage.clearAuthTokens();

      AppLogger.i('✅ User signed out successfully');
    } catch (e, stackTrace) {
      AppLogger.e('❌ Sign out error', e, stackTrace);
      rethrow;
    }
  }

  /// Send password reset email
  ///
  /// Sends a password reset link to the user's email.
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      AppLogger.i('📧 Sending password reset email to: $email');

      // Mock implementation - in real app this would send actual email
      if (email.isEmpty || !email.contains('@')) {
        throw AuthException('Invalid email address');
      }

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      AppLogger.i('✅ Password reset email sent (mock)');
    } catch (e, stackTrace) {
      AppLogger.e('❌ Password reset error', e, stackTrace);
      if (e is AuthException) rethrow;
      throw AuthException('Password reset failed: ${e.toString()}');
    }
  }

  /// Refresh authentication token
  ///
  /// Gets a fresh ID token and stores it securely.
  Future<String?> refreshToken() async {
    try {
      final user = currentUser;
      if (user == null) {
        AppLogger.w('⚠️ Cannot refresh token: No user signed in');
        return null;
      }

      AppLogger.d('🔄 Refreshing auth token');

      final token = await user.getIdToken(true); // Force refresh
      await _storage.saveAuthToken(token);
      AppLogger.d('✅ Token refreshed successfully');

      return token;
    } catch (e, stackTrace) {
      AppLogger.e('❌ Token refresh error', e, stackTrace);
      return null;
    }
  }

  /// Get current ID token
  ///
  /// Returns the current user's ID token, or null if not authenticated.
  Future<String?> getIdToken() async {
    try {
      final user = currentUser;
      if (user == null) return null;

      return await user.getIdToken();
    } catch (e, stackTrace) {
      AppLogger.e('❌ Error getting ID token', e, stackTrace);
      return null;
    }
  }

  // ==================== Role Management ====================

  /// Check if current user is admin
  ///
  /// Returns true if the user has admin role, false otherwise.
  Future<bool> isAdmin() async {
    final user = currentUser;
    if (user == null) return false;

    return await isUserAdmin(user.uid);
  }

  /// Check if a specific user is admin
  ///
  /// Returns true if the user has admin role, false otherwise.
  Future<bool> isUserAdmin(String userId) async {
    try {
      final roleData = _userRoles[userId];
      if (roleData == null) return false;

      return roleData['admin'] == true;
    } catch (e, stackTrace) {
      AppLogger.e('❌ Error checking admin role', e, stackTrace);
      return false;
    }
  }

  /// Set user admin role
  ///
  /// Grants or revokes admin privileges for a user.
  /// Only admins can call this method.
  Future<void> setUserAdmin(String userId, bool isAdmin) async {
    try {
      // Check if current user is admin
      final currentUserIsAdmin = await this.isAdmin();
      if (!currentUserIsAdmin) {
        throw UnauthorizedException(
          'Only admins can modify user roles',
        );
      }

      AppLogger.i('👤 Setting admin role for user $userId: $isAdmin');

      _userRoles[userId] = {
        'admin': isAdmin,
        'updated_at': DateTime.now().toIso8601String(),
        'updated_by': currentUser?.uid,
      };

      AppLogger.i('✅ Admin role updated successfully');
    } catch (e, stackTrace) {
      AppLogger.e('❌ Error setting admin role', e, stackTrace);
      rethrow;
    }
  }

  /// Initialize user role
  ///
  /// Creates a role document for a new user (default: not admin).
  Future<void> _initializeUserRole(String userId) async {
    try {
      _userRoles[userId] = {
        'admin': false,
        'created_at': DateTime.now().toIso8601String(),
      };
    } catch (e, stackTrace) {
      AppLogger.e('❌ Error initializing user role', e, stackTrace);
      // Don't throw - role initialization failure shouldn't block sign up
    }
  }

  /// Get user role information
  ///
  /// Returns role data for a user, or null if not found.
  Future<Map<String, dynamic>?> getUserRole(String userId) async {
    try {
      return _userRoles[userId];
    } catch (e, stackTrace) {
      AppLogger.e('❌ Error getting user role', e, stackTrace);
      return null;
    }
  }

  // ==================== Utility Methods ====================

  /// Verify user has admin access
  ///
  /// Throws [UnauthorizedException] if user is not admin.
  Future<void> requireAdmin() async {
    if (!isAuthenticated) {
      throw UnauthorizedException('Authentication required');
    }

    final isAdminUser = await isAdmin();
    if (!isAdminUser) {
      throw UnauthorizedException('Admin access required');
    }
  }

  /// Verify user is authenticated
  ///
  /// Throws [UnauthorizedException] if user is not authenticated.
  void requireAuth() {
    if (!isAuthenticated) {
      throw UnauthorizedException('Authentication required');
    }
  }



  /// Get user display name
  String? get displayName => currentUser?.displayName;

  /// Get user email
  String? get email => currentUser?.email;

  /// Get user ID
  String? get userId => currentUser?.uid;

  /// Check if email is verified
  bool get isEmailVerified => currentUser?.emailVerified ?? false;

  /// Send email verification
  Future<void> sendEmailVerification() async {
    try {
      final user = currentUser;
      if (user == null) {
        throw AuthException('No user signed in');
      }

      if (user.emailVerified) {
        AppLogger.i('ℹ️ Email already verified');
        return;
      }

      AppLogger.i('📧 Sending email verification');
      await user.sendEmailVerification();
      AppLogger.i('✅ Verification email sent (mock)');
    } catch (e, stackTrace) {
      AppLogger.e('❌ Error sending verification email', e, stackTrace);
      rethrow;
    }
  }
}

/// Exception thrown when authentication fails
class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

/// Exception thrown when user lacks required permissions
class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);

  @override
  String toString() => 'UnauthorizedException: $message';
}

/// Timeout exception
class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);

  @override
  String toString() => 'TimeoutException: $message';
}
