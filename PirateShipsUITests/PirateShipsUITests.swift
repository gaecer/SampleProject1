//
//  PirateShipsUITests.swift
//  PirateShipsUITests
//
//  Created by Gaetano Cerniglia on 18/12/2020.
//

import XCTest

class PirateShipsUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = true
    }

    func test_backButton_pressed_when_detailViewShowed() throws {
        let app = XCUIApplication()
        app.launch()

        XCUIApplication().collectionViews.children(matching: .cell)
            .element(boundBy: 0).children(matching: .other).element.tap()

        app.navigationBars["PirateShips.PirateShipDetail"].buttons["Back"].tap()
    }

    func test_detailView_contains_labels() throws {
        let app = XCUIApplication()
        app.launch()

        XCUIApplication().collectionViews.children(matching: .cell)
            .element(boundBy: 0).children(matching: .other).element.tap()

        let titleLabel = app.staticTexts["titleLabel"]
        XCTAssertEqual(titleLabel.label, "How misty. You ransack like an ale.")

        let descriptionLabel = app.staticTexts["descriptionLabel"]
        XCTAssertEqual(descriptionLabel.label,
                       "Anchors scream on yellow fever at haiti! How sunny. You haul like a cloud.")
    }

    func test_detailView_actions_triggered() throws {
        let app = XCUIApplication()
        app.launch()

        XCUIApplication().collectionViews.children(matching: .cell)
            .element(boundBy: 0).children(matching: .other).element.tap()

        let greetingButton = app.buttons["greetingButton"]
        greetingButton.tap()

        app.alerts["Ahoi!"].scrollViews.otherElements.staticTexts["Ahoi!"].tap()
    }

    func test_cell_contain_values() throws {
        let app = XCUIApplication()
        app.launch()
        let cel = XCUIApplication().collectionViews.cells

        XCTAssert(cel.staticTexts["How misty. You ransack like an ale."].exists)
        XCTAssert(cel.staticTexts["£34.00"].exists)
    }
}
