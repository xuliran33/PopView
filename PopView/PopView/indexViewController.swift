//
//  indexViewController.swift
//  
//
//  Created by gdj003 on 16/3/30.
//
//

import UIKit

class indexViewController: UIViewController {
    
    // 弹窗样式数组
    let types = ["样式一"]

    override func viewDidLoad() {
        super.viewDidLoad()
        initButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initButton(){
        // 同时或得数组中的元素及下标
        for (index,type) in enumerate(types){
            let button = UIButton(frame: CGRectMake(Toolkit.screenWidth / 2 - 80, 200.0 + 50 * CGFloat(index), 160.0, 30.0))
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.redColor().CGColor
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
            
            button.tag = index + 88
            button.setTitle(type, forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
            button.addTarget(self, action: "buttonAction:", forControlEvents: .TouchUpInside)
            
            self.view.addSubview(button)
        
        }
    }
    
    func buttonAction(button : UIButton){
        let popView = PopView()
        
        let contantView = UIView(frame: CGRectMake(0, 0, 200, 200))
        contantView.backgroundColor = UIColor.redColor()
        let label = UILabel(frame: CGRectMake(0, 0, 100, 100))
        label.center = contantView.center
        label.backgroundColor = UIColor.yellowColor()
        contantView.addSubview(label)
 
        let point = CGPointMake(button.center.x, button.frame.maxY)
        popView.show(contantView, point: point)
    }

}
