class ApiEndpoints {
  static const baseUrl = "http://157.49.120.38:8080"; // node_gateway
  static const ragUrl = "http://localhost:8000"; // RAG microservice

  // Auth
  static const signup = "$baseUrl/signup";
  static const login = "$baseUrl/login";

  // Chat
  static const chat = "$ragUrl/callLLM/";
}
