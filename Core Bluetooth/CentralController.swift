// CentralController.swift
// Core Bluetooth
// Created by John Christopher Ferris
// Copyright © 2019 sub11 LLC. All rights reserved.

import SUB11

class CentralController: UIViewController, CentralManagerDelegate, UITableViewDataSource, UITableViewDelegate {
  private let heading = "BLE Heart Rate Sensors"
  private let centralManager = CentralManager()
  private let centralView = CentralView()

  override func loadView() {
    super.loadView()
    title = heading
    view = centralView
    centralManager.delegate = self
    centralView.peripheralTable.dataSource = self
    centralView.peripheralTable.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    centralView.peripheralTable.reloadData()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return centralManager.peripheralCount()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let tableViewCell = SUB11.tableViewCell(style: .value1, identifier: nil)
    tableViewCell.textLabel?.text = centralManager.peripheralNameAt(indexPath.row)
    if centralManager.peripheralIsConnectedAt(indexPath.row) { tableViewCell.detailTextLabel?.text = heartUnicode }
    tableViewCell.accessoryType = .disclosureIndicator
    return tableViewCell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    centralManager.connectPeripheralAt(indexPath.row)
    let heartRateController = HeartRateController(peripheral: centralManager.peripheralAt(indexPath.row))
    self.navigationController?.pushViewController(heartRateController, animated: true)
  }

  func didDiscoverPeripheral() {
    centralView.peripheralTable.reloadData()
  }

  func alert(title: String, message: String?) {
    let alertController = SUB11.alertController(title: title, message: message)
    self.present(alertController, animated: true, completion: nil)
  }
}
