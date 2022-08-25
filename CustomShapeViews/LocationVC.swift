//
//  LocationVC.swift
//  CustomShapeViews
//
//  Created by Webappclouds on 8/24/22.
//

import UIKit

class LocationVC: UIViewController {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var centerView: UIView!
    
    var numberOfSlices = 4
    var startAnglesArr:[CGFloat] = [CGFloat]()
    var endAnglesArr:[CGFloat] = [CGFloat]()
    
    let layerNormalColor = UIColor(named: "layerNormalColor") ?? .clear
    let layerSelectedColor = UIColor(named: "layerSelectedColor") ?? .clear
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buildBtnClicked(_ sender: Any) {
        setupVC()
    }
    
    private func setupVC() {
        outerView.layer.cornerRadius = outerView.bounds.size.width/2
        centerView.layer.cornerRadius = centerView.bounds.size.width/2
        innerView.backgroundColor = .clear
        
        addSliceAngles()
        buildLocationLayers()
        addImages()
    }
    
    private func addSliceAngles() {
        let minAngle: CGFloat = 2.0/CGFloat(numberOfSlices)
        let sliceParticionAngle: CGFloat = 0.01
        let val:CGFloat = .pi
        
        if numberOfSlices != 0 {
            for sliceNumber in 0...numberOfSlices - 1 {
                if sliceNumber == 0 {
                    startAnglesArr.append(.pi)
                    endAnglesArr.append(((1+(minAngle * CGFloat((sliceNumber+1)))) * val))
                } else if sliceNumber == numberOfSlices - 1 {
                    startAnglesArr.append(((1+(minAngle * CGFloat((sliceNumber))) + sliceParticionAngle) * val))
                    endAnglesArr.append(((1+(minAngle * CGFloat((sliceNumber+1))) - sliceParticionAngle) * val))
                } else {
                    startAnglesArr.append(((1+(minAngle * CGFloat((sliceNumber))) + sliceParticionAngle) * val) )
                    endAnglesArr.append(((1+(minAngle * CGFloat((sliceNumber+1)))) * val))
                }
            }
        }
    }
    
    private func buildLocationLayers() {
        for tag in (0 ..< startAnglesArr.count) {
            innerView.layer.name = "innerViewCustom"
            innerView.layer.addSublayer(
                getCAShapeLayer(WithTag: tag, WithStartAngle: startAnglesArr[tag], WithEndAngle: endAnglesArr[tag]))
        }
    }
    
    private func getCAShapeLayer(WithTag tag: Int, WithStartAngle startAngle: CGFloat, WithEndAngle endAngle: CGFloat) -> CAShapeLayer {
        let center = CGPoint(x: innerView.layer.bounds.size.width/2, y: innerView.layer.bounds.size.width/2)
        
        let beizerPath = UIBezierPath()
        beizerPath.move(to: center)
        beizerPath.addArc(withCenter: center,
                          radius: innerView.layer.bounds.size.width/2,
                          startAngle: startAngle,
                          endAngle: endAngle,
                          clockwise: true)
        beizerPath.close()
        
        let layer = CAShapeLayer()
        layer.name = "\(tag)"
        layer.path = beizerPath.cgPath
        layer.fillColor = layerNormalColor.cgColor
        return layer
    }
    
    private func addImages() {
        if let innerViewSubLayers = innerView.layer.sublayers {
            for subLayer in innerViewSubLayers {
                
                let caShapeLayer = subLayer as! CAShapeLayer
                let indexIs = Int(caShapeLayer.name ?? "0") ?? 0
                let imgV = getImageView(WithTagId: indexIs)
                
                let midPointAngle = (startAnglesArr[indexIs] + endAnglesArr[indexIs]) / 2.0
                let radiusIs = innerView.layer.bounds.size.width / 2
                let midPoint = CGPoint(x: radiusIs + (radiusIs+(radiusIs*0.3)) * cos(midPointAngle), y: radiusIs - (radiusIs+(radiusIs*0.3)) * sin(midPointAngle))
                imgV.center = getMiddlePoint(firstPoint: midPoint, secondPoint: CGPoint(x: radiusIs, y: radiusIs))
            }
        }
    }
    
    private func getImageView(WithTagId tagId: Int) -> UIImageView {
        let randomInt = Int.random(in: 0..<4)
        let imageName = "\(randomInt)"
        let image = UIImage(named: imageName)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        let imageView = UIImageView(image: image!)
        
        imageView.isUserInteractionEnabled = true
        imageView.tag = tagId
        imageView.addGestureRecognizer(tapGestureRecognizer)
        innerView.addSubview(imageView)
        
        return imageView
    }
    
    @objc private func didTapImageView(_ sender: UITapGestureRecognizer) {
        let selectedLayer = "\((startAnglesArr.count - 1 - (sender.view?.tag ?? 0)))"
        didClickLayer(SelectedLayer: selectedLayer)
    }
    
    func getMiddlePoint(firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
        var middlePoint = CGPoint()
        middlePoint.x = (firstPoint.x + secondPoint.x)/2
        middlePoint.y = (firstPoint.y + secondPoint.y)/2
        return middlePoint
    }
}

// MARK: Layer selection
extension LocationVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count == 1 {
            if let touch = touches.first {
                let view = self.innerView
                let touchLocation = touch.location(in: view)
                guard let locationInView = view?.convert(touchLocation, to: nil) else { return print("failed") }
                let hitPresentationLayer = view?.layer.presentation()?.hitTest(locationInView)
                
                //Checking touch
                if hitPresentationLayer?.name == "innerViewCustom" {
                    if let subLayers = hitPresentationLayer?.sublayers {
                        var selectedLayer = ""
                        for subL in subLayers {
                            let shapeL = subL as! CAShapeLayer
                            let clickedDetected = shapeL.path?.contains(touchLocation) ?? false
                            if clickedDetected {
                                selectedLayer = shapeL.name ?? ""
                                break
                            }
                        }
                        
                        didClickLayer(SelectedLayer: selectedLayer)
                    }
                }
                //Checking touch ended
                
            }
        }
    }
    
    private func didClickLayer(SelectedLayer selectedLayer: String) {
        if !selectedLayer.isEmpty {
            if let innerViewSubLayers = innerView.layer.sublayers {
                for subLayerN in innerViewSubLayers {
                    if let caShapeLayer = subLayerN as? CAShapeLayer {
                        if caShapeLayer.name == selectedLayer {
                            caShapeLayer.fillColor = layerSelectedColor.cgColor
                        } else {
                            caShapeLayer.fillColor = layerNormalColor.cgColor
                        }
                    }
                }
                
            }
        }
    }
    
}
