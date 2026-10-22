import Testing
import Foundation
@testable import MeowBili

struct VideoPlaybackURLTests {
    @Test(arguments: [
        "",
        " \n ",
        "http://[",
        "https://",
        "/video.mp4",
        "解析失败",
        "{\"code\":-1,\"message\":\"failed\"}",
        "<html>Service unavailable</html>",
        "file:///tmp/video.mp4",
        "javascript:alert(1)"
    ])
    func rejectsInvalidPlaybackSources(_ link: String) {
        #expect(VideoPlaybackURL.parse(link) == nil)
    }
    
    @Test(arguments: [
        "https://example.com/video.mp4?token=a%2Fb&expires=123",
        "http://example.com/video.mp4",
        " \nhttps://example.com/video.mp4\r\n"
    ])
    func acceptsNetworkPlaybackSources(_ link: String) throws {
        let url = try #require(VideoPlaybackURL.parse(link))
        #expect(url.absoluteString == link.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
