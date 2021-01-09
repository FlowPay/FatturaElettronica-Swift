import XCTest
import NIO
@testable import FatturaElettronica

final class LibraryTests: XCTestCase {
    
    var loop: EventLoop!
    
    override func setUp() {
        self.loop = MultiThreadedEventLoopGroup.init(numberOfThreads: System.coreCount).next()
    }
    
    func downloadFile(_ file: String) -> EventLoopFuture<Data>{
        let promise = self.loop.makePromise(of: Data.self)
        self.loop.execute{
            let url = URL(string: file)!
            
            let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
                if let localURL = localURL {
                    if let data = try? Data(contentsOf: localURL) {
                        promise.succeed(data)
                    }else{
                        promise.fail(error!)
                    }
                }
            }
            
            task.resume()
        }
        return promise.futureResult
    }
    
    func testFPA01() throws{
        
        let exp = expectation(description: "Testing FPA01")
        //        let path = Bundle.main.path(forResource: "./mock/PA02", ofType: "xml")!
        //        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let url = "https://www.fatturapa.gov.it/export/documenti/fatturapa/v1.2/IT01234567890_FPA01.xml"
        
        let handle = self.downloadFile(url).flatMap{
            XMLHandler().handle($0, type: .xml)
        }
        
        handle.whenSuccess{
            print($0)
            exp.fulfill()
        }
        
        handle.whenFailure{
            print($0.localizedDescription)
        }
        waitForExpectations(timeout: 5)
        
    }
    
    func testZIP() throws {
        let exp = expectation(description: "Testing ZIP")
        
        let promise = downloadFile("file://.Tests/AppTests/mock/mocktest.zip")
            .flatMap{
                XMLHandler().handle($0, type: .zip)
            }
        promise.whenSuccess{
            print($0)
            exp.fulfill()
        }
        
        promise.whenFailure{
            XCTFail($0.localizedDescription)
        }
        waitForExpectations(timeout: 500)
        
    }
    
    static var allTests = [
        ("testExample", testFPA01),
    ]
}
