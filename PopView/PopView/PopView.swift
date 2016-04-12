//
//  PopView.swift
//  
//
//  Created by gdj003 on 16/4/1.
//
//

import UIKit

public class PopView: UIView {
    
    public enum PopoverType {
        case Up
        case Down
    }
    // 半透明黑色背景
    private let blackControl : UIControl = UIControl()
    // 背景色
    private let blackColor = UIColor(white: 0.0, alpha: 0.2)
    // 箭头的大小
    private var arrowSize = CGSizeMake(16.0, 10.0)
    // 弹出视图的圆角
    private var cornerRadius: CGFloat = 6
    // 弹出类型
    public var popoverType = PopoverType.Up
    // 弹出视图出现需要的时间
    private var animationIn: NSTimeInterval = 0.6
    // 弹出视图消失时需要的时间
    private var animationOut: NSTimeInterval = 0.3
    // 在哪个视图中弹出
    private var containerView : UIView!
    // 将要弹出的视图
    private var contentView : UIView!
    // 箭头显示的点
    private var arrowShoePoint : CGPoint!
    
    // 根据位置弹出
    public func show(contentView : UIView, point : CGPoint){
        // 获取当前活跃的视图
        let inView = UIApplication.sharedApplication().keyWindow!
        // .FlexibleWidth自动调整view的宽度, 以保证左右边距不变
        // .FlexibleHeight自动调整view的高度, 以保证上下边距不变
        self.blackControl.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.blackControl.frame = inView.bounds
        self.blackControl.backgroundColor = self.blackColor
        self.blackControl.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)
        
        inView.addSubview(self.blackControl)
        
        self.containerView = inView
        self.contentView = contentView
        // 改变弹出框的背景颜色
        self.contentView.backgroundColor = UIColor.clearColor()
        self.contentView.layer.cornerRadius = self.cornerRadius
        self.contentView.layer.masksToBounds = true
        self.arrowShoePoint = point
        
        self.show()
        
    }
    // 弹出视图
    private func show(){
        // 调用drawRect方法
        self.setNeedsDisplay()
        switch self.popoverType{
        case .Up:
            self.contentView.frame.origin.y = 0
        case .Down:
            self.contentView.frame.origin.y = self.arrowSize.height
            
        }
        
        self.addSubview(self.contentView)
        self.containerView.addSubview(self)
        
        UIView.animateWithDuration(self.animationIn, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 3, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.transform = CGAffineTransformIdentity
        }) { _ in
            // 因为不需要参数, 所以可以省略为如上形式
        }
    
    }
    
    public func dismiss(){
        // 判断是否有父视图, 防止出错
        if self.superview != nil{
            UIView.animateWithDuration(self.animationOut, delay: 0,options: .CurveEaseInOut, animations: { () -> Void in
                self.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
            }, completion: { _ in
                self.containerView.removeFromSuperview()
                self.blackControl.removeFromSuperview()
                self.removeFromSuperview()
            })
        }
    }

}
