enum AuthRoutes{
  login('/login'),
  signup('/signup');

  final String path;

  const AuthRoutes(this.path);
}