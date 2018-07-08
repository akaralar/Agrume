//
//  Copyright © 2018 Schnaub. All rights reserved.
//

import UIKit

protocol AgrumeOverlayViewDelegate: AnyObject {
  func agrumeOverlayViewWantsToClose(_ view: AgrumeOverlayView)
}

final class AgrumeOverlayView: UIView {
  
  weak var delegate: AgrumeOverlayViewDelegate?

  private lazy var navigationBar: UINavigationBar = {
    let navigationBar = UINavigationBar()
    navigationBar.usesAutoLayout(true)
    navigationBar.backgroundColor = .clear
    navigationBar.shadowImage = UIImage()
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationBar.items = [navigationItem]
    return navigationBar
  }()
  
  private lazy var navigationItem: UINavigationItem = {
    let navigationItem = UINavigationItem(title: "")
    navigationItem.leftBarButtonItem = leftBarButtonItem
    return navigationItem
  }()
  
  private lazy var leftBarButtonItem: UIBarButtonItem = {
    let item = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
    return item
  }()
  
  init(closeButton: UIBarButtonItem?) {
    super.init(frame: .zero)
    addSubview(navigationBar)
    
    NSLayoutConstraint.activate([
      navigationBar.topAnchor.constraint(equalTo: portableSafeTopInset),
      navigationBar.widthAnchor.constraint(equalTo: widthAnchor),
      navigationBar.centerXAnchor.constraint(equalTo: centerXAnchor)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    if let view = super.hitTest(point, with: event), view != self {
      return view
    }
    return nil
  }
  
  @objc
  private func close() {
    delegate?.agrumeOverlayViewWantsToClose(self)
  }
  
}
