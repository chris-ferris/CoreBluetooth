This iOS app demonstrates mobile BLE connectivity in Swift using the Core Bluetooth framework, and includes code reuse via dependence on the SUB11.framework, and unit & UI testing using XCTest. It connects an iOS device with a BLE heart rate sensor, and enables the user to view their heart rate both numerically and visually. An AppPreview.mov is included with the source.

The file structure is

MODEL:
CentralManager.swift
HeartRatePeripheral.swift

VIEW:
CentralView.swift
HeartRateView.swift

CONTROLLER:
CentralController.swift
HeartRateController.swift
