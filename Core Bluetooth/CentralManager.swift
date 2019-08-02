// CentralManager.swift
// Core Bluetooth
// Created by John Christopher Ferris
// Copyright © 2019 sub11 LLC. All rights reserved.

import CoreBluetooth

protocol CentralManagerDelegate: class {
  func didDiscoverPeripheral()
  func alert(title: String, message: String?)
}

class CentralManager: NSObject, CBCentralManagerDelegate {
  weak var delegate: CentralManagerDelegate?
  var centralManager: CBCentralManager!
  var heartRatePeripheralArray = [HeartRatePeripheral]()

  override init() {
    super.init()
    centralManager = CBCentralManager(delegate: self, queue: nil)
  }

  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
      case .poweredOn:
        central.scanForPeripherals(withServices: [heartRateService], options: nil)
      case .poweredOff:
        delegate?.alert(title: "Bluetooth is Powered Off", message: "Turn on Bluetooth in Settings to enable connection to heart rate sensor.")
      case .resetting:
        delegate?.alert(title: "Bluetooth is Resetting", message: "Bluetooth is resetting on this device.")
      case .unauthorized:
        delegate?.alert(title: "Bluetooth is Unauthorized", message: "Bluetooth is unauthorized on this device.")
      case .unknown:
        delegate?.alert(title: "Bluetooth is Unknown", message: "Bluetooth is unknown on this device.")
      case .unsupported:
        delegate?.alert(title: "Bluetooth is Unsupported", message: "Bluetooth is unsupported on this device.")
      @unknown default:
        delegate?.alert(title: "Unknown Bluetooth State", message: "Bluetooth is in a state on this device that is unknown.")
    }
  }

  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    heartRatePeripheralArray.append(HeartRatePeripheral(peripheral))
    delegate?.didDiscoverPeripheral()
  }

  func peripheralCount() -> Int {
    return heartRatePeripheralArray.count
  }

  func peripheralNameAt(_ index: Int) -> String {
    return heartRatePeripheralArray[index].name()
  }

  func peripheralIsConnectedAt(_ index: Int) -> Bool {
    return heartRatePeripheralArray[index].isConnected()
  }

  func peripheralAt(_ index: Int) -> HeartRatePeripheral {
    return heartRatePeripheralArray[index]
  }

  func connectPeripheralAt(_ index: Int) {
    for i in 0..<heartRatePeripheralArray.count {
      if i != index {
        if peripheralIsConnectedAt(i) {
          centralManager.cancelPeripheralConnection(heartRatePeripheralArray[i].peripheral)
        }
      }
    }
    centralManager.connect(heartRatePeripheralArray[index].peripheral, options: nil)
  }

  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    peripheral.discoverServices([heartRateService])
  }
}
