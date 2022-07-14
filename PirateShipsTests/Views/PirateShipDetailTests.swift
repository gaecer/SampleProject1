//
//  PirateShipTests.swift
//  PirateShipsTests
//
//  Created by Gaetano Cerniglia on 29/12/2020.
//

import XCTest
@testable import PirateShips

class PirateShipDetailTests: XCTestCase {

    private var pirateShipDetail: PirateShipDetail!
    private let testShip = TestUtility.SampleStruct()
    var viewModel: MockPirateShipViewModel!

    override func setUp() {
        let model = PirateShipModel(title: testShip.title,
                                    price: testShip.price,
                                    image: testShip.image,
                                    description: testShip.description,
                                    greetingType: testShip.greetingType)
        viewModel = MockPirateShipViewModel(ship: model)
        pirateShipDetail = PirateShipDetail(viewModel: viewModel)
    }

    override func tearDown() {
        pirateShipDetail = nil
    }

    func test_downloadImageCalled_when_viewDidLoad() throws {
        XCTAssertFalse(viewModel.downloadImageCalled)
        pirateShipDetail.viewDidLoad()
        XCTAssertTrue(viewModel.downloadImageCalled)
    }

}
