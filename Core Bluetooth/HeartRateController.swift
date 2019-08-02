// HeartRateController.swift
// Core Bluetooth
// Created by John Christopher Ferris
// Copyright © 2019 sub11 LLC. All rights reserved.

import UIKit

class HeartRateController: UIViewController, HeartRatePeripheralDelegate {
  private let heading = "Heart Rate (bpm)"
  private var heartRatePeripheral: HeartRatePeripheral?
  private let heartRateView = HeartRateView()
  private var previousHeartRate = 0

  init(peripheral: HeartRatePeripheral) {
    super.init(nibName: nil, bundle: nil)
    heartRatePeripheral = peripheral
    heartRatePeripheral?.delegate = self
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func loadView() {
    super.loadView()
    title = heading
    view = heartRateView
  }

  func didUpdateHeartRate(_ heartRate: Int) {
    heartRateView.heartRateLabel.text = String(heartRate)

    // Turn off the graphical view of the previous heart rate value, and turn on the graphical view of the current heart rate value
    heartRateView.graphView[previousHeartRate].backgroundColor = .clear
    heartRateView.graphView[heartRate].backgroundColor = .red

    previousHeartRate = heartRate
  }
}
