// HeartRatePeripheral.swift
// Core Bluetooth
// Created by John Christopher Ferris
// Copyright © 2019 sub11 LLC. All rights reserved.

import CoreBluetooth

protocol HeartRatePeripheralDelegate: class {
  func didUpdateHeartRate(_ heartRate: Int)
}

class HeartRatePeripheral: NSObject, CBPeripheralDelegate {
  weak var delegate: HeartRatePeripheralDelegate?
  var peripheral: CBPeripheral!

  init(_ peripheral: CBPeripheral) {
    super.init()
    self.peripheral = peripheral
    self.peripheral.delegate = self
  }

  func name() -> String {
    return peripheral.name ?? "Heart Rate Sensor"
  }

  func isConnected() -> Bool {
    return peripheral.state == .connected
  }

  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    guard let services = peripheral.services else { return }
    for service in services {
      peripheral.discoverCharacteristics(nil, for: service)
    }
  }

  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
    guard let characteristics = service.characteristics else { return }
    for characteric in characteristics {
      if characteric.properties.contains(.notify) {
        peripheral.setNotifyValue(true, for: characteric)
      }
    }
  }

  func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    if characteristic.uuid == heartRateMeasurementCharacteristic {
      guard let value = characteristic.value else { return }
      let byteArray = [UInt8](value)

      // If the value of the least significant bit of the first byte is 0, heartRate is < 256 bpm (as would be expected!), and it's value is contained in the second byte;
      // otherwise, it's value is contained in a combination of the second and third bytes
      let heartRate = (Int(byteArray[0] & 0x01) == 0) ? Int(byteArray[1]) : (256 * Int(byteArray[1])) + Int(byteArray[2])

      delegate?.didUpdateHeartRate(heartRate)
    }
  }
}
