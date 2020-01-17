//
//  MainViewController.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 17/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Foundation
import Cocoa

class MainSplitViewController: NSSplitViewController {

   private let splitViewResorationIdentifier = "com.company.restorationId:mainSplitViewController"

   lazy var vcA = TableView()
   lazy var vcB = ImageDetailViewController()

   override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setupUI()
      setupLayout()
   }

   required init?(coder: NSCoder) {
      super.init(coder: coder)
   }

}

extension MainSplitViewController {

   private func setupUI() {

      view.wantsLayer = true

    splitView.dividerStyle = .thick
      splitView.autosaveName = splitViewResorationIdentifier
      splitView.identifier = NSUserInterfaceItemIdentifier(rawValue: splitViewResorationIdentifier)

      vcA.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
      vcB.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
   }

   private func setupLayout() {

      let sidebarItem = NSSplitViewItem(viewController: vcA)
      sidebarItem.canCollapse = true
      sidebarItem.holdingPriority = NSLayoutConstraint.Priority(NSLayoutConstraint.Priority.defaultLow.rawValue + 1)
      addSplitViewItem(sidebarItem)

      let xibItem = NSSplitViewItem(viewController: vcB)
      addSplitViewItem(xibItem)
   }
}
