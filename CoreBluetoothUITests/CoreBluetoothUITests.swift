// CoreBluetoothUITests.swift
// CoreBluetoothUITests
// Created by John Christopher Ferris
// Copyright © 2019 sub11 LLC. All rights reserved.

import XCTest

class CoreBluetoothUITests: XCTestCase {
  private let heartUnicode = "\u{2764}"
  var app: XCUIApplication!

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }

  override func tearDown() {
    app = nil
    super.tearDown()
  }

  func testHeartRate() {
    let peripheralTableExpectation = XCTestExpectation(description: "Peripheral table is displayed")
    _ = XCTWaiter.wait(for: [peripheralTableExpectation], timeout: 2.0)
    let peripheralTable = app.tables["PeripheralTable"]
    XCTAssertTrue(peripheralTable.exists)
    let firstPeripheralCell = peripheralTable.cells.element(boundBy: 0)
    XCTAssertTrue(firstPeripheralCell.exists)
    firstPeripheralCell.tap()

    let heartRateExpectation = XCTestExpectation(description: "Heart rate value is displayed")
    _ = XCTWaiter.wait(for: [heartRateExpectation], timeout: 5.0)
    let heartRateLabel = app.staticTexts["HeartRateLabel"]
    XCTAssertTrue(heartRateLabel.exists)
    app.navigationBars["Heart Rate (bpm)"].buttons["BLE Heart Rate Sensors"].tap()

    let heartUnicodeExpectation = XCTestExpectation(description: "Heart unicode is displayed in the peripheral table cell detail")
    _ = XCTWaiter.wait(for: [heartUnicodeExpectation], timeout: 2.0)
    XCTAssertTrue(peripheralTable.exists)
    XCTAssertTrue(firstPeripheralCell.exists)
    let heartDetail = firstPeripheralCell.staticTexts[heartUnicode]
    XCTAssertTrue(heartDetail.exists)
  }
}
