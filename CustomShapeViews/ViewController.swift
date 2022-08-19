    //
    //  ViewController.swift
    //  CustomShapeViews
    //
    //  Created by Webappclouds on 8/17/22.
    //

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var custView: UIView!
    @IBOutlet weak var centerView: UIView!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    //Use (2/number of slices u need)
    //0.01 to make slice particion
    let startAnglesArr:[CGFloat] = [.pi,          (1.21 * .pi), (1.41 * .pi), (1.61 * .pi), (1.81 * .pi), (2.01 * .pi), (2.21 * .pi), (2.41 * .pi), (2.61 * .pi), (2.81 * .pi)]
    let endAnglesArr:[CGFloat] =   [(1.2 * .pi), (1.4 * .pi),  (1.6 * .pi), (1.8 * .pi),  (2.0 * .pi), (2.20 * .pi), (2.4 * .pi), (2.6 * .pi), (2.8 * .pi), (2.99 * .pi)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        buildAnimatedView()
        view.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count == 1 {
            for touch in touches {
                var point = touch.location(in: touch.view)
                print(point)
                //to get point in super.view
                //point = touch.view?.convert(point, to: nil) ?? CGPoint.zero
                //print(point)
                
//                var layer = (view.layer.presentation() as? CALayer)?.hitTest(point)
//                print(layer?.name)
//                var layerN = layer?.model() as! CAShapeLayer
//                print("")
//                layerN.fillColor = UIColor.green.cgColor
                
                var layer = (view.layer.presentation() as? CALayer)?.hitTest(point)
                print("")
            }
        }
    }
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //       func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        print("touch began")
        if touches.count == 1 {
            for touch in touches {
                var point = touch.location(in: touch.view)
                print(point)
                //point = touch.view?.convert(point, to: nil) ?? CGPoint.zero
                //print(point)
                
                
                var layer = (view.layer.presentation() as? CALayer)?.hitTest(point)
                print(layer?.name)
                var layerN = layer?.model() as! CAShapeLayer
                layerN.fillColor = UIColor.green.cgColor
                
                //Detect touch
                if let custViewSubLayers = custView.layer.sublayers {
                    
                    for caShapeLayer in custViewSubLayers {
                        //let caShapeLayer = subLayer as! CAShapeLayer
                        
                        if caShapeLayer.contains(point) {
                            let caShapeLayer1 = caShapeLayer as! CAShapeLayer
                            caShapeLayer1.fillColor = UIColor.green.cgColor
                        }
                    }
                    
                }
                //Detect touch
                
                
                

//                var layer = (view.layer.presentation() as? CALayer)?.hitTest(point)
//                print(layer?.name)
//                layer = layer?.model()
//                layer?.opacity = 0.5
            }
        }
    }
    */
    
    
    
}

extension ViewController {
    
    private func setupVC() {
        custView.backgroundColor = .clear
        bgView.layer.cornerRadius = 160
        centerView.layer.cornerRadius = 60
        custView.layer.borderColor = UIColor.red.cgColor
        custView.layer.borderWidth = 3
    }
    
    private func buildAnimatedView() {
        for tag in (0 ..< startAnglesArr.count) {
            custView.layer.name = "Sree"
            custView.layer.addSublayer(
                getOutherGrayCircle(WithTag: tag, WithStartAngle: startAnglesArr[tag], WithEndAngle: endAnglesArr[tag]))
            
        }
    }
    
    private func getOutherGrayCircle(WithTag tag: Int, WithStartAngle startAngle: CGFloat, WithEndAngle endAngle: CGFloat) -> CAShapeLayer {
        let center = CGPoint(x: 150, y: 150)
        let beizerPath = UIBezierPath()
        beizerPath.move(to: center)
        beizerPath.addArc(withCenter: center,
                          radius: 150,
                          startAngle: startAngle,
                          endAngle: endAngle,
                          clockwise: true)
        beizerPath.close()
        let innerGrayCircle = CAShapeLayer()
        innerGrayCircle.name = "\(tag)"
        innerGrayCircle.path = beizerPath.cgPath
        innerGrayCircle.fillColor = UIColor.gray.cgColor
        
        return innerGrayCircle
    }
    
    @IBAction func btnClicked2(_ sender: UIButton) {
        if let custViewSubLayers = custView.layer.sublayers {
            
            for subLayer in custViewSubLayers {
                let caShapeLayer = subLayer as! CAShapeLayer
                
                
                
                
                if subLayer.name == "0" {
                    let midPointAngle = (.pi + (.pi * 1.2)) / 2.0
                    let midPoint = CGPoint(x: 150 + 200 * cos(midPointAngle), y: 150 - 200 * sin(midPointAngle))
                    btn1.center = getMiddlePoint(firstPoint: midPoint, secondPoint: CGPoint(x: 150, y: 150))
                }
                
                if subLayer.name == "1" {
                    let midPointAngle = ((.pi * 1.21) + (.pi * 1.4)) / 2.0
                    let midPoint = CGPoint(x: 150 + 200 * cos(midPointAngle), y: 150 - 200 * sin(midPointAngle))
                    btn2.center = getMiddlePoint(firstPoint: midPoint, secondPoint: CGPoint(x: 150, y: 150))
                }
                
                if subLayer.name == "2" {
                    let midPointAngle = ((.pi * 1.41) + (.pi * 1.6)) / 2.0
                    let midPoint = CGPoint(x: 150 + 200 * cos(midPointAngle), y: 150 - 200 * sin(midPointAngle))
                    btn3.center = getMiddlePoint(firstPoint: midPoint, secondPoint: CGPoint(x: 150, y: 150))
                }
                if subLayer.name == "3" {
                    let midPointAngle = ((.pi * 1.61) + (.pi * 1.8)) / 2.0
                    let midPoint = CGPoint(x: 150 + 200 * cos(midPointAngle), y: 150 - 200 * sin(midPointAngle))
                    btn4.center = getMiddlePoint(firstPoint: midPoint, secondPoint: CGPoint(x: 150, y: 150))
                }
                if subLayer.name == "4" {
                    let midPointAngle = ((.pi * 1.81) + (.pi * 2.0)) / 2.0
                    let midPoint = CGPoint(x: 150 + 200 * cos(midPointAngle), y: 150 - 200 * sin(midPointAngle))
                    btn5.center = getMiddlePoint(firstPoint: midPoint, secondPoint: CGPoint(x: 150, y: 150))
                }
                
                
                
                if subLayer.name == "2" {
                    caShapeLayer.fillColor = UIColor.green.cgColor
                } else {
                    caShapeLayer.fillColor = UIColor.gray.cgColor
                }
            }
        }
    }
    
    func getMiddlePoint(firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
            
            var middlePoint = CGPoint()
            
            middlePoint.x = (firstPoint.x + secondPoint.x)/2
            middlePoint.y = (firstPoint.y + secondPoint.y)/2
            return middlePoint
        }
    
    @IBAction func btnClicked5(_ sender: UIButton) {
        if let custViewSubLayers = custView.layer.sublayers {
            
            for subLayer in custViewSubLayers {
                let caShapeLayer = subLayer as! CAShapeLayer
                if subLayer.name == "5" {
                    caShapeLayer.fillColor = UIColor.green.cgColor
                } else {
                    caShapeLayer.fillColor = UIColor.gray.cgColor
                }
            }
        }
    }
    
}








extension ViewController {
    
    private func manualDrawing() {
        
        let myColor = UIColor.red
        custView.layer.borderColor = myColor.cgColor
        custView.layer.borderWidth = 1.0
        custView.backgroundColor = .clear
        
        let layer = getOutherGrayCircle()
            //layer.path = UIBezierPath(roundedRect: CGRect(x: 64, y: 64, width: 160, height: 160), cornerRadius: 50).cgPath
            //layer.fillColor = UIColor.red.cgColor
        custView.layer.addSublayer(layer)
        
        let layer1 = getOutherGrayCircle1()
        custView.layer.addSublayer(layer1)
        custView.layer.addSublayer(getOutherGrayCircle2())
        custView.layer.addSublayer(getOutherGrayCircle3())
        custView.layer.addSublayer(getOutherGrayCircle4())
        
            //        for val in (0 ..< startAnglesArr.count) {
            //            custView.layer.addSublayer(
            //                getOutherGrayCircle(WithStartAngle: startAnglesArr[val], WithEndAngle: endAnglesArr[val]))
            //
            //        }
    }
    
    
    
    func getOutherGrayCircle() -> CAShapeLayer {
        let center = CGPoint(x: 150, y: 150)
        let beizerPath = UIBezierPath()
        beizerPath.move(to: center)
        beizerPath.addArc(withCenter: center,
                          radius: 150,
                          startAngle: .pi,
                          endAngle: 1.25 * .pi,
                          clockwise: true)
        beizerPath.close()
        let innerGrayCircle = CAShapeLayer()
        innerGrayCircle.path = beizerPath.cgPath
        innerGrayCircle.fillColor = UIColor.gray.cgColor
        return innerGrayCircle
    }
    
    func getOutherGrayCircle1() -> CAShapeLayer {
        let center = CGPoint(x: 150, y: 150)
        let beizerPath = UIBezierPath()
        beizerPath.move(to: center)
        beizerPath.addArc(withCenter: center,
                          radius: 150,
                          startAngle: 1.26 * .pi,
                          endAngle: 1.5 * .pi,
                          clockwise: true)
        beizerPath.close()
        let innerGrayCircle = CAShapeLayer()
        innerGrayCircle.path = beizerPath.cgPath
        innerGrayCircle.fillColor = UIColor.gray.cgColor
        return innerGrayCircle
    }
    
    func getOutherGrayCircle2() -> CAShapeLayer {
        let center = CGPoint(x: 150, y: 150)
        let beizerPath = UIBezierPath()
        beizerPath.move(to: center)
        beizerPath.addArc(withCenter: center,
                          radius: 150,
                          startAngle: 1.51 * .pi,
                          endAngle: 1.75 * .pi,
                          clockwise: true)
        beizerPath.close()
        let innerGrayCircle = CAShapeLayer()
        innerGrayCircle.path = beizerPath.cgPath
        innerGrayCircle.fillColor = UIColor.gray.cgColor
        return innerGrayCircle
    }
    
    func getOutherGrayCircle3() -> CAShapeLayer {
        let center = CGPoint(x: 150, y: 150)
        let beizerPath = UIBezierPath()
        beizerPath.move(to: center)
        beizerPath.addArc(withCenter: center,
                          radius: 150,
                          startAngle: 1.76 * .pi,
                          endAngle: 2.0 * .pi,
                          clockwise: true)
        beizerPath.close()
        let innerGrayCircle = CAShapeLayer()
        innerGrayCircle.path = beizerPath.cgPath
        innerGrayCircle.fillColor = UIColor.gray.cgColor
        return innerGrayCircle
    }
    
    func getOutherGrayCircle4() -> CAShapeLayer {
        let center = CGPoint(x: 150, y: 150)
        let beizerPath = UIBezierPath()
        beizerPath.move(to: center)
        beizerPath.addArc(withCenter: center,
                          radius: 150,
                          startAngle: 2.01 * .pi,
                          endAngle: 2.25 * .pi,
                          clockwise: true)
        beizerPath.close()
        let innerGrayCircle = CAShapeLayer()
        innerGrayCircle.path = beizerPath.cgPath
        innerGrayCircle.fillColor = UIColor.gray.cgColor
        return innerGrayCircle
    }
}

