// CoreBluetoothUnitTests.swift
// CoreBluetoothUnitTests
// Created by John Christopher Ferris
// Copyright © 2019 sub11 LLC. All rights reserved.

import XCTest
@testable import Core_Bluetooth

class CoreBluetoothUnitTests: XCTestCase, HeartRatePeripheralDelegate {
  private var heartRate: Int?
  var centralManager: CentralManager!

  override func setUp() {
    super.setUp()
    centralManager = CentralManager()
  }

  override func tearDown() {
    centralManager = nil
    super.tearDown()
  }

  func didUpdateHeartRate(_ heartRate: Int) {
    self.heartRate = heartRate
  }

  func testPeripheralConnection() {
    // Give the iOS device enough time to discover a peripheral
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
      let peripheralCount = self.centralManager.peripheralCount()
      XCTAssertGreaterThan(peripheralCount, 0)

      for index in 0..<peripheralCount {
        self.centralManager.connectPeripheralAt(index)
        // Give the iOS device enough time to connect the peripheral
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            XCTAssertTrue(self.centralManager.peripheralIsConnectedAt(index))
        }
      }

      // Give the iOS device enough time to receive heart rate data from the peripheral
      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
        XCTAssertNotNil(self.heartRate)
      }
    }
  }
}
