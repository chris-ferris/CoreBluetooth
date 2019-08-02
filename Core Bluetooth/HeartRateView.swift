// HeartRateView.swift
// Core Bluetooth
// Created by John Christopher Ferris
// Copyright © 2019 sub11 LLC. All rights reserved.

import SUB11

class HeartRateView: UIView {
  private let axisLabelMultiplier = CGFloat(0.7)
  let heartRateLabel = SUB11.label(text: "", multiplier: 10.0, textColor: .white, identifier: "HeartRateLabel")

  // Graphical view of heart rate in the form of a thermometer,
  // as an array of skinny, overlapping rectangles, one for each possible heart rate value,
  // each of which can be turned on or off by changing its color between clear or red
  var graphView = Array(repeating: UIView(), count: axisMax + 1)

  convenience init() {
    self.init(frame: .zero)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = SUB11.backgroundColor
    let layoutView = SUB11.view()
    self.addSubview(layoutView)
    let margins = self.layoutMarginsGuide
    NSLayoutConstraint.activate([
      layoutView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      layoutView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      layoutView.topAnchor.constraint(equalTo: margins.topAnchor, constant: marginMedium),
      layoutView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -marginMedium)])

    // Render the axis for the graphical view of heart rate
    let axisMaxLabel = SUB11.label(text: String(axisMax), multiplier: axisLabelMultiplier, textColor: .white, identifier: "AxisMaxLabel")
    layoutView.addSubview(axisMaxLabel)
    NSLayoutConstraint.activate([
      axisMaxLabel.leadingAnchor.constraint(equalTo: layoutView.leadingAnchor, constant: 5.0),
      axisMaxLabel.centerYAnchor.constraint(equalTo: layoutView.topAnchor)])
    let axisMinLabel = SUB11.label(text: String(axisMin), multiplier: axisLabelMultiplier, textColor: .white, identifier: "AxisMinLabel")
    layoutView.addSubview(axisMinLabel)
    NSLayoutConstraint.activate([
      axisMinLabel.trailingAnchor.constraint(equalTo: axisMaxLabel.trailingAnchor),
      axisMinLabel.centerYAnchor.constraint(equalTo: layoutView.bottomAnchor)])
    let tickCount = axisMax / 10
    for index in 1..<tickCount {
      let text = String(index * 10)
      let axisLabel = SUB11.label(text: text, multiplier: axisLabelMultiplier, textColor: UIColor.white, identifier: text + "Label")
      layoutView.addSubview(axisLabel)
      NSLayoutConstraint.activate([
        axisLabel.trailingAnchor.constraint(equalTo: axisMaxLabel.trailingAnchor),
        NSLayoutConstraint(item: axisLabel, attribute: .centerY, relatedBy: .equal, toItem: layoutView, attribute: .bottom, multiplier: CGFloat(Double(tickCount - index) / Double(tickCount)), constant: 0.0)])
    }

    // Render the graphical view of heart rate
    for index in 0...axisMax {
      graphView[index] = SUB11.view()
      layoutView.addSubview(graphView[index])
      let topConstraint = index == axisMax ?
        graphView[index].topAnchor.constraint(equalTo: layoutView.topAnchor) :
        NSLayoutConstraint(item: graphView[index], attribute: .top, relatedBy: .equal, toItem: layoutView, attribute: .bottom, multiplier: CGFloat(1.0 - Double(index)/Double(axisMax)), constant: 0.0)
      NSLayoutConstraint.activate([
        graphView[index].leadingAnchor.constraint(equalTo: axisMaxLabel.trailingAnchor, constant: 7.0),
        graphView[index].widthAnchor.constraint(equalToConstant: 8.0),
        topConstraint,
        graphView[index].bottomAnchor.constraint(equalTo: layoutView.bottomAnchor)])
    }

    // Render the numerical view of heart rate
    layoutView.addSubview(heartRateLabel)
    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: heartRateLabel, attribute: .centerX, relatedBy: .equal, toItem: layoutView, attribute: .centerX, multiplier: 1.15, constant: 0.0),
      NSLayoutConstraint(item: heartRateLabel, attribute: .centerY, relatedBy: .equal, toItem: layoutView, attribute: .centerY, multiplier: 0.75, constant: 0.0)])
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
