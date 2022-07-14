//
//  NetworkFrameworkTests.swift
//  NetworkFrameworkTests
//
//  Created by Gaetano Cerniglia on 21/12/2020.
//

import XCTest
@testable import NetworkFramework

class HttpClientTests: XCTestCase {

    let url = URL(string: "http://fake_url.com")!

    var sut: HttpClientImp!

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        sut = HttpClientImp(session: session)
    }

    override  func tearDown() {
        sut = nil
    }

    func test_when_request_fails_returns_server_error() throws {
        let exp = XCTestExpectation(description: "wait for generic server error")
        URLProtocolMock.providedResponse = .error(NSError(domain: "", code: 99999, userInfo: nil))
        _ = sut.getRequest(with: url) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error == .serverError)
            } else {
                XCTAssert(false)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }

    func test_when_request_get_cancelled_returns_requestCancelled() throws {
        let exp = XCTestExpectation(description: "wait request cancelled")
        let error = NSError(domain: "", code: NSURLErrorCancelled, userInfo: nil)
        URLProtocolMock.providedResponse = .error(error)
        _ = sut.getRequest(with: url) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error == .requestCancelled)
            } else {
                XCTAssert(false)
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 10)
    }

    func test_when_request_succeed_returns_data() throws {
        let bundle = Bundle(for: HttpClientTests.self)
        let path = bundle.path(forResource: "Ships", ofType: "json")!
        guard let sampleData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            XCTFail("No Ships available")
            return
        }

        URLProtocolMock.providedResponse = .data(sampleData)
        let exp = XCTestExpectation(description: "wait for data")
        _ = sut.getRequest(with: url) { result in
            if case .success(let data) = result {
                XCTAssertTrue(data == sampleData)
                exp.fulfill()
            } else {
                XCTAssert(false)
            }
        }

        wait(for: [exp], timeout: 10)
    }

    func test_when_request_is_cancelled_returns_proper_error() throws {
        let exp = XCTestExpectation(description: "cancel request")
        URLProtocolMock.providedResponse = .data(Data())
        let receipt = sut.getRequest(with: url) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error == .requestCancelled)
                exp.fulfill()
            } else {
                XCTAssert(false)
            }
        }
        receipt?.cancel()
        wait(for: [exp], timeout: 10)
    }
}
