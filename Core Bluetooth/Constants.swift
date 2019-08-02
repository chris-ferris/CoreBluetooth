// Constants.swift
// Core Bluetooth
// Created by John Christopher Ferris
// Copyright © 2019 sub11 LLC. All rights reserved.

import SUB11
import CoreBluetooth

let marginSmall = SUB11.margin16
let marginMedium = SUB11.margin28
let marginLarge = SUB11.margin34
let heartRateService = CBUUID(string: "0x180D")
let heartRateMeasurementCharacteristic = CBUUID(string: "2A37")
let heartUnicode = "\u{2764}"
let axisMin = 0
let axisMax = 220
