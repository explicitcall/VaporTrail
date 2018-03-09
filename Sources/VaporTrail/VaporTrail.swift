import Vapor

final class VaporTrail: Middleware, Service, ServiceType {
  func respond(to request: Request, chainingTo next: Responder) throws -> Future<Response> {
    let logger = try request.make(ConsoleLogger.self)

    let method = request.http.method
    let path = request.http.uri.path

    // not using string interpolation:
    // https://twitter.com/nicklockwood/status/971506873387143168
    var reqString = method.debugDescription + "@" + path
    if let query = request.http.uri.query {
      reqString += " with query:\(query)"
    }

    logger.console.output(reqString, style: .init(color: .red))
    return try next.respond(to: request)
  }

  static func makeService(for worker: Container) throws -> Self {
    return .init()
  }
}
