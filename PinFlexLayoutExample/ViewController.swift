//
//  ViewController.swift
//  PinFlexLayoutExample
//
//  Created by 조성재 on 7/11/24.
//

import PinLayout
import FlexLayout
import UIKit
import Then

class ViewController: UIViewController {
  
  // flex container 생성
  let rootFlexContainer: UIView = UIView()
  
  let label1 = UILabel().then {
    $0.text = "LABEL"
    $0.backgroundColor = .yellow
  }
  let label2 = UILabel().then {
    $0.text = "LABEL2"
    $0.backgroundColor = .green
  }
  let label3 = UILabel().then {
    $0.text = "LABEL3"
    $0.backgroundColor = .blue
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .gray
    view.addSubview(rootFlexContainer)
    
    // StackView의 addArrangedSubView()와 같은 역할
    paddingLayout()
  }
  
  
  // 수동 layout 하기 때문에, viewDidLayoutSubviews() OR layoutSubview() 사용
  // flexContainer 위치 설정 (pin layout, children layout 잡기)
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    rootFlexContainer.pin.all(view.pin.safeArea)
    rootFlexContainer.flex.layout()
  }
  
  func simpleLayout() {
    // direction의 default -> Column
    // direction -> .column, .columnReverse, .row, .rowReverse
    rootFlexContainer.flex.direction(.column).define { flex in
      flex.addItem(label1)
      flex.addItem(label2)
      flex.addItem(label3)
    }
  }
  
  // 주의 : container 기준이므로 하단 view 중첩 주의
  func topLayout() {
    rootFlexContainer.flex.direction(.column).define { flex in
      flex.addItem(label1).top(10)
      flex.addItem(label2)
      flex.addItem(label3)
    }
  }
  
  func paddingLayout() {
    rootFlexContainer.flex.define { flex in
      flex.addItem(label1).paddingTop(20) // 내부 간격 조정
      flex.addItem(label2).width(100)
      flex.addItem(label3)
    }
  }
  
  func marginLayout() {
    rootFlexContainer.flex.direction(.column).define { flex in
      flex.addItem(label1).marginTop(10)
      flex.addItem(label2)
      flex.addItem(label3).height(30)
    }
  }
  
  func alignLayout() {
    // alignItems (.stretch가 기본 값)
    //        rootFlexContainer.flex.alignItems(.start).define { flex in
    //            flex.addItem(label1).width(40)
    //            flex.addItem(label2).height(70)
    //            flex.addItem(label3)
    //        }
    
    // justifyContent
    rootFlexContainer.flex.justifyContent(.start).define { flex in
      flex.addItem(label1).width(100)
      flex.addItem(label2).height(70)
      flex.addItem(label3)
    }
  }
}

