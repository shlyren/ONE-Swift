//
//  JENExtension.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/28.
//  Copyright © 2016年 任玉祥. All rights reserved.
//  类扩展

import UIKit
// MARK: - UIImageExtension
extension UIImage {
    /**
     根据一张图片返回一个裁剪后的image
     */
    func circleImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let path = UIBezierPath(ovalInRect: CGRectMake(0, 0, size.width, size.height))
        path.addClip()
        drawAtPoint(CGPointZero)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func imageWithColor(color: UIColor) -> UIImage {
        // 描述矩形
         let rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
        // 开启位图上下文
        UIGraphicsBeginImageContext(rect.size);
        // 获取位图上下文
        let context = UIGraphicsGetCurrentContext();
        // 使用color演示填充上下文
        CGContextSetFillColorWithColor(context, color.CGColor);
        // 渲染上下文
        CGContextFillRect(context, rect);
        // 从上下文中获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext();
        // 结束上下文
        UIGraphicsEndImageContext();
        return image;
    }
}

// MARK: - NSMutableAttributedStringExtension
extension NSMutableAttributedString {
    /**
     根据一个字符串返回一个格式化好的字符串
     */
    class func attributedStringWithString(str: String?) -> NSAttributedString? {
        
        guard let str = str else { return nil }
        
        var tmpStr = str as NSString
        if tmpStr.length == 0 { return nil }
        
        // <!--StartFragment-->
        var range = NSRange()
        range = tmpStr.rangeOfString("<!--StartFragment-->")
        if range.location != NSNotFound {
            tmpStr = tmpStr.stringByReplacingCharactersInRange(NSMakeRange(0, range.location + range.length), withString: "")
        }
        // 换行
        tmpStr = tmpStr.stringByReplacingOccurrencesOfString("<br>", withString: "\n")
        tmpStr = tmpStr.stringByReplacingOccurrencesOfString("<strong>", withString: "")
        tmpStr = tmpStr.stringByReplacingOccurrencesOfString("</strong>", withString: "")
        tmpStr = tmpStr.stringByReplacingOccurrencesOfString("<em>", withString: "")
        tmpStr = tmpStr.stringByReplacingOccurrencesOfString("</em>", withString: "")

        range = tmpStr .rangeOfString("<!--EndFragment-->")
        if range.location != NSNotFound  {
             tmpStr = tmpStr.stringByReplacingCharactersInRange(range, withString: "")
        }
        //<!--EndFragment-->
        
        // 设置内容格式
        let attributedString = NSMutableAttributedString(string: tmpStr as String)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4;//调整行间距
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, tmpStr.length))
        
        return attributedString
    }
}

// MARK: - UITableViewExtension
extension UITableView {
    /**
     隐藏tableview多余的分割线
     */
    func tableViewSetExtraCellLineHidden() {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        tableFooterView = view
    }
    
    /**
     没有数据是显示的信息
     */
    func tableViewWithNoData(message: String?, rowCount: Int) {
        if rowCount == 0 {
            let label = UILabel()
            label.text = message
            label.textAlignment = .Center
            label.textColor = UIColor.blackColor()
            label.sizeToFit()
            backgroundView = label
            separatorStyle = .None
        }else {
            backgroundView = nil
            separatorStyle = .SingleLine
        }
    }
}

// MARK: -  UIColorExtension
extension UIColor {
    /**
     从十六进制字符串获取颜色
     
     - parameter color: 支持"#123456"、 "0X123456"、 "123456"三种格式
     - parameter alpha: 透明度
     */
    class func colorWithHexString(color: String?, alpha: CGFloat) -> UIColor {
        guard let color = color else { return UIColor.clearColor() }
        
        //删除字符串中的空格
        var cString = color.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString as NSString
        
        if cString.length < 6 { return UIColor.clearColor() }
        
        // strip 0X if it appears
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
        if cString.hasPrefix("0X") { cString = cString.substringFromIndex(2) }
        //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
        if cString.hasPrefix("#") { cString = cString.substringFromIndex(1) }
        if cString.length != 6 { return UIColor.clearColor() }

        var range = NSMakeRange(0, 2)
        //r
        let rString = cString.substringWithRange(range)
        //g
        range.location = 2;
        let gString = cString.substringWithRange(range)
        //b
        range.location = 4;
        let bString = cString.substringWithRange(range)
        
        var r: uint = 0, g: uint = 0, b: uint = 0
        NSScanner(string:rString).scanHexInt(&r)
        NSScanner(string:gString).scanHexInt(&g)
        NSScanner(string:bString).scanHexInt(&b)
        
        return UIColor.color(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: alpha)
    }
    
    /**
     从十六进制字符串获取颜色 默认alpha为1
     
     - parameter colorStr: 支持"#123456"、 "0X123456"、 "123456"三种格式
     */
    class func colorWithHexString(colorStr: String?) -> UIColor {
        
        return UIColor.colorWithHexString(colorStr, alpha: 1)
    }
    
    
    /**
     颜色RGB
     
     - parameter r: 红色 0~255
     - parameter g: 绿色 0~255
     - parameter b: 蓝色 0~255
     - parameter a: 透明度 0.0~1.0
     */
    class func color(r r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0,
                     green: g / 255.0,
                      blue: b / 255.0,
                     alpha: a)
    }
    /**
     随机颜色
     */
    class func randomColor() -> UIColor {
        return UIColor.color(r: CGFloat(arc4random_uniform(256)),
                             g: CGFloat(arc4random_uniform(256)),
                             b: CGFloat(arc4random_uniform(256)),
                             a: 1)
    }
}

// MARK: - UIScrollViewExtension
extension UIScrollView {
    /// 内边距Top
    var insetT: CGFloat {
        get { return contentInset.top }
        set { contentInset.top = newValue }
    }
    /// 内边距Left
    var insetL: CGFloat {
        get { return contentInset.left }
        set { contentInset.left = newValue }
    }
    /// 内边距Bottom
    var insetB: CGFloat {
        get { return contentInset.bottom }
        set { contentInset.bottom = newValue }
    }
    /// 内边距Right
    var insetR: CGFloat {
        get { return contentInset.right }
        set { contentInset.right = newValue }
    }
    /// 偏移量X
    var offsetX: CGFloat {
        get { return contentOffset.x }
        set { contentOffset.x = newValue }
    }
    /// 偏移量Y
    var offsetY: CGFloat {
        get { return contentOffset.y }
        set { contentOffset.y = newValue }
    }
    /// 内容Width
    var contentW: CGFloat {
        get { return contentSize.width }
        set { contentSize.width = newValue }
    }
    /// 内容Height
    var contentH: CGFloat {
        get { return contentSize.height }
        set { contentSize.height = newValue }
    }
    
}

// MARK: - UIViewExtension
extension UIView {
    
    var x: CGFloat {
        get { return frame.origin.x }
        set { frame.origin.x = newValue }
    }
    var y: CGFloat {
        get { return frame.origin.y }
        set { frame.origin.y = newValue }
    }
    
    var width: CGFloat {
        get { return frame.size.width }
        set { frame.size.width = newValue }
    }
    var height: CGFloat {
        get { return frame.size.height  }
        set { frame.size.height = newValue }
    }
    
    var size: CGSize {
        get { return frame.size  }
        set { frame.size = newValue }
    }
    var origin: CGPoint {
        get { return frame.origin }
        set { frame.origin = newValue }
    }
    
    var centerX: CGFloat {
        get { return center.x }
        set { center.x = newValue }
    }
    var centerY: CGFloat {
        get { return center.y }
        set { center.y = newValue }
    }
}
