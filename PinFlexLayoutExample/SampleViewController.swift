//
//  SampleViewController.swift
//  PinFlexLayoutExample
//
//  Created by 조성재 on 7/11/24.
//

import FlexLayout
import PinLayout
import Then
import UIKit

class SampleViewController: UIViewController {
  
  let rootContainer: UIView = UIView()
  lazy var button: UIButton = UIButton().then {
    $0.setTitle("POP!", for: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.backgroundColor = .white
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.cornerRadius = 10
    $0.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    self.addViews()
    self.setUpFlexItem()
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    rootContainer.pin.all(view.pin.safeArea)
    // FlexLayout의 모든 계산을 수행하고 View의 Frame을 설정
    // 이 과정에서 모든 하위 View의 크기와 위치가 결정됨
    rootContainer.flex.layout()
    // FlexLayout의 모든 계산을 마친 후에 Button의 최종 크기를 알 수 있기 때문에 
    // flex.layout 이 후에 pin.vCenter를 해주는 것이다.
    button.pin.vCenter().hCenter()
  }
  
  
  @objc func tapOnButton() {
    print("POP IT!")
    let samplePopUpVC = SamplePopUpViewController()
    samplePopUpVC.modalPresentationStyle = .overCurrentContext
    samplePopUpVC.modalTransitionStyle = .crossDissolve
    
    self.present(samplePopUpVC, animated: true)
  }
  
  func addViews() {
    view.addSubview(rootContainer)
    rootContainer.addSubview(button)
  }
  
  func setUpFlexItem() {
    rootContainer.flex.define { flex in
      flex.addItem(button).width(UIScreen.main.bounds.width / 2)
    }
  }
  
}
