import Vapor
import Foundation

public final class VaporTrailMiddleware: Middleware, Service, ServiceType {
  public func respond(to request: Request, chainingTo next: Responder) throws -> Future<Response> {
    let logger = try request.make(ConsoleLogger.self)

    let method = request.http.method
    let path = request.http.uri.path

    // not using string interpolation:
    // https://twitter.com/nicklockwood/status/971506873387143168
    var reqString = method.debugDescription + "@" + path
    if let query = request.http.uri.query {
      reqString += " with query:\(query)"
    }

    let start = Date()

    // FIXME: better response error handling
    return try next.respond(to: request).map(to: Response.self) { res in
        let end = Date()
        // `end - start` is the length of the request handling, if no error was thrown
        let sec = end.timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate
        reqString = sec.description + "s: " + reqString
        logger.console.output(reqString, style: .init(color: .red))
        return res
    }
  }

  public static func makeService(for worker: Container) throws -> Self {
    return .init()
  }
}
