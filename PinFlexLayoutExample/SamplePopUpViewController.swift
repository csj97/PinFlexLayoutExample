//
//  SamplePopUpViewController.swift
//  PinFlexLayoutExample
//
//  Created by 조성재 on 7/11/24.
//

import FlexLayout
import PinLayout
import Then
import UIKit

class SamplePopUpViewController: UIViewController {
  
  private let rootContainer: UIView = UIView().then {
    $0.layer.cornerRadius = 10
    $0.backgroundColor = .white
  }
  private let imageView: UIImageView = UIImageView().then {
    $0.image = UIImage(systemName: "bell")
  }
  private lazy var cancelButton: UIButton = UIButton().then {
    $0.setTitle("취소", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .systemRed
    $0.layer.cornerRadius = 5
    $0.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
  }
  private lazy var confirmButton: UIButton = UIButton().then {
    $0.setTitle("확인", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .systemBlue
    $0.layer.cornerRadius = 5
    $0.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
  }
  private let textLabel: UILabel = UILabel().then {
    $0.text = "선거에 있어서 최고득표자가 2인 이상인 때에는 국회의 재적의원 과반수가 출석한 공개회의에서 다수표를 얻은 자를 당선자로 한다. 헌법개정안은 국회가 의결한 후 30일 이내에 국민투표에 붙여 국회의원선거권자 과반수의 투표와 투표자 과반수의 찬성을 얻어야 한다. 대통령의 임기가 만료되는 때에는 임기만료 70일 내지 40일전에 후임자를 선거한다.\n\n모든 국민은 보건에 관하여 국가의 보호를 받는다. 모든 국민은 인간다운 생활을 할 권리를 가진다. 광물 기타 중요한 지하자원·수산자원·수력과 경제상 이용할 수 있는 자연력은 법률이 정하는 바에 의하여 일정한 기간 그 채취·개발 또는 이용을 특허할 수 있다. 국회는 헌법개정안이 공고된 날로부터 60일 이내에 의결하여야 하며, 국회의 의결은 재적의원 3분의 2 이상의 찬성을 얻어야 한다."
    $0.textColor = .darkGray
    $0.font = UIFont.systemFont(ofSize: 16)
    $0.numberOfLines = 0
    $0.lineBreakMode = .byWordWrapping
    $0.adjustsFontSizeToFitWidth = true
    $0.minimumScaleFactor = 0.65
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .black.withAlphaComponent(0.3)
    
    self.addViews()
    self.setUpFlexItem()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    // 일단, 너비만 설정해서 중앙에 위치 시킴
    rootContainer.pin.center().width(80%)
    // FlexLayout을 이용해서 내용물 크기를 계산
    rootContainer.flex.layout(mode: .adjustHeight)
    
    let calculatedHeight = rootContainer.frame.height
    let maxHeight = view.frame.height * 0.8
    
    // rootContainer의 높이를 파악했으면, 다시 높이를 설정해준다. *dynamic
    rootContainer.pin.center()
      .width(80%)
      .height(min(calculatedHeight, maxHeight))
    rootContainer.flex.layout()
  }
  
  func addViews() {
    view.addSubview(rootContainer)
    rootContainer.addSubview(imageView)
    rootContainer.addSubview(cancelButton)
    rootContainer.addSubview(confirmButton)
    rootContainer.addSubview(textLabel)
  }
  
  func setUpFlexItem() {
    rootContainer.flex
      .justifyContent(.spaceBetween)
      .define { flex in
        flex.addItem().direction(.column).define { flex in
          // imageview 중앙 정렬
          flex.addItem().direction(.column).alignItems(.center).define { flex in
            flex.addItem(imageView).width(100).marginTop(20).aspectRatio(of: imageView)
          }
          // text label margin 지정
          flex.addItem(textLabel)
            .marginTop(15)
            .marginBottom(20)
            .marginHorizontal(15)
        }
        flex.addItem().direction(.column).define { flex in
          flex.addItem().direction(.row).justifyContent(.center)
            .marginBottom(20).marginHorizontal(15)
            .define { flex in
              flex.addItem(cancelButton).width(50%)
              flex.addItem(confirmButton).marginLeft(5).width(50%)
            }
        }
      }
  }
  
  @objc func tapOnButton() {
    self.dismiss(animated: true)
  }
  
}
