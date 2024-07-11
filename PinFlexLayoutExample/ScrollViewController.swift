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

class ScrollViewController: UIViewController {
  
  let rootContainer: UIView = UIView()
  let scrollVeiw: UIScrollView = UIScrollView()
  let scrollContentView: UIView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    self.addViews()
    
    let boxes = (0...100).map { _ in
      let view = UIView()
      view.backgroundColor = randomColor()
      return view
    }
    
    scrollContentView.flex.define { flex in
      boxes.forEach { box in
        flex.addItem(box)
          .height(100)
          .marginVertical(5)
      }
    }
  }
  
  override func viewDidLayoutSubviews() {
    rootContainer.pin.all(view.pin.safeArea)
    scrollVeiw.pin.all()
    scrollContentView.pin.all()
    
    // IMPORTANT
    // ScrollView는 무한한 크기를 가지므로, scroll 반대 방향은 크기를 고정시켜야 한다.
    scrollContentView.flex.layout(mode: .adjustHeight)
    
    // scroll이 가능하려면 내부 content 크기를 지정해줘야 함.
    scrollVeiw.contentSize = scrollContentView.frame.size
  }
  
  func addViews() {
    view.addSubview(rootContainer)
    rootContainer.addSubview(scrollVeiw)
    scrollVeiw.addSubview(scrollContentView)
  }
  
  func randomColor() -> UIColor {
    let red = CGFloat.random(in: 0...1)
    let green = CGFloat.random(in: 0...1)
    let blue = CGFloat.random(in: 0...1)
    let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    return color
  }
  
}
