// CentralView.swift
// Core Bluetooth
// Created by John Christopher Ferris
// Copyright © 2019 sub11 LLC. All rights reserved.

import SUB11

class CentralView: UIView {
  let activityIndicator = SUB11.activityIndicator(identifier: "ScanningActivityIndicator")
  let peripheralTable = SUB11.tableView(identifier: "PeripheralTable")
  let infoLabel = SUB11.label(text: "Scanning for Sensors...", multiplier: 0.9, textColor: .white, identifier: "InfoLabel")

  convenience init() {
    self.init(frame: .zero)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = SUB11.backgroundColor
    let layoutGuide = UILayoutGuide()
    self.addLayoutGuide(layoutGuide)
    let margins = self.layoutMarginsGuide
    NSLayoutConstraint.activate([
      layoutGuide.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      layoutGuide.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      layoutGuide.topAnchor.constraint(equalTo: margins.topAnchor, constant: marginSmall),
      layoutGuide.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -marginLarge)])

    self.addSubview(activityIndicator)
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
      activityIndicator.topAnchor.constraint(equalTo: layoutGuide.topAnchor)])

    self.addSubview(infoLabel)
    NSLayoutConstraint.activate([
      infoLabel.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
      infoLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)])

    self.addSubview(peripheralTable)
    peripheralTable.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
    peripheralTable.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
    peripheralTable.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: marginLarge).isActive = true
    peripheralTable.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -marginLarge).isActive = true
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
