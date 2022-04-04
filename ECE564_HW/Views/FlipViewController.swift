//
//  FlipViewController.swift
//  ECE564_HW
//
//  Created by Jonathan Browning on 2/21/22.
//  Copyright © 2022 ECE564. All rights reserved.
//

import UIKit

class FlipViewController: UIViewController {

    var displayPerson : DukePerson = DukePerson()
    let bgImgView = UIImageView()
    
    let rackets: UIView = Rackets()
    let tennisBall: UIView = TennisBall()
    
    func rallyTennisBall() {
        var sampleFrame : CGRect = self.tennisBall.frame
        sampleFrame.origin.y += 330
        sampleFrame.origin.x += 56
        
        UIView.animate(withDuration: 1.25,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
            self.tennisBall.frame = sampleFrame
        })
    }

    
    override func loadView() {
        print("HMMMMMMM")
        
        let view = UIView()
        view.backgroundColor = .systemRed
        
        self.view = view
        
        self.navigationController?.isToolbarHidden = false

        var items = [UIBarButtonItem]()
        
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil) )
        items.append( UIBarButtonItem(title: "Flip Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(flipCardBack)) ) // replace add with your function

        self.toolbarItems = items // this made the difference. setting the item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if displayPerson.netid.lowercased() == "jrb127" {
            configureView()
        }
        else {
            setAttributeTextView()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        switch detailItem {
//        case "Graphic Context":
        rallyTennisBall()
//        default:
//            break
//        }
        
    }
    
    func setLabel() {
        let fontName = "Chalkboard SE"
        
        let labelView = UITextView()
        labelView.frame = CGRect(x: 118, y: 15, width: 200, height: 50)
        labelView.backgroundColor = .clear
        
        let labelString = "Tennis Rally"
        let labelAttributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: fontName, size: 24) as Any,
            .foregroundColor: UIColor.black,
            .underlineStyle: NSUnderlineStyle.thick.rawValue
        ]
        let finalString = NSAttributedString(string: labelString, attributes: labelAttributes)
        
        labelView.attributedText = finalString
        labelView.isScrollEnabled = false
        view?.addSubview(labelView)
    }
    
    func configureView() {
//        setAttributeTextView()
        let totalWidth : CGFloat = UIScreen.main.bounds.width
        let totalHeight = UIScreen.main.bounds.height
        
        // add cheering spectators
        setImageAnimationView(xcord: 10, ycord: 240)
        setImageAnimationView(xcord: 10, ycord: 320)
        setImageAnimationView(xcord: Int(totalWidth) - 55, ycord: 240)
        setImageAnimationView(xcord: Int(totalWidth) - 55, ycord: 320)
        
        // add tennis background
        setBackground()
//        setLabel()
        
    }
    
    func setImageAnimationView(xcord: Int, ycord: Int) {
        print("Made it to animation view")
        
        let totalWidth : CGFloat = UIScreen.main.bounds.width
        let totalHeight = UIScreen.main.bounds.height
        
        print("total width is \(totalWidth)")
        print("total height is \(totalHeight)")
        
        let iav = UIImageView()
        iav.frame = CGRect(x: xcord, y: ycord, width: 50, height: 50)
        
        let i1 = UIImage(named: "cheer_1.png")!
        let i2 = UIImage(named: "cheer_2.png")!
        let i3 = UIImage(named: "cheer_3.png")!
        let i4 = UIImage(named: "cheer_4.png")!
        iav.animationImages = [i1, i2, i3, i4]
        iav.animationDuration = 1
        iav.startAnimating()
        view?.addSubview(iav)
    }
    
    func setBackground() {
        setLabel()
        
        // start to draw
        let defaultLineWidth : CGFloat = 5
        
        let tennisCourt = UIView(frame: CGRect(x: 80, y: 80, width: 216, height: 468)) // Make a black background for the blue ball
        tennisCourt.backgroundColor = .systemGreen
        view?.addSubview(tennisCourt)
        
        rackets.frame = CGRect(x: 0, y: 0, width: 216, height: 468)
        rackets.backgroundColor = .clear
        tennisCourt.addSubview(rackets)
        
        tennisBall.frame = CGRect(x: 0, y: 0, width: 216, height: 468)
        tennisBall.backgroundColor = .clear
        tennisCourt.addSubview(tennisBall)
        
        // Draw court
        let tennisFrame = CGRect(x: 80, y: 80, width: 216, height: 468)
        
        UIGraphicsBeginImageContextWithOptions(tennisFrame.size, false, 0.0)
        // outside lines
        let color:UIColor = UIColor.white
        let bpath:UIBezierPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 216, height: 468))
        bpath.lineWidth = defaultLineWidth
        color.set()
        bpath.stroke()
        
        // service lane 1
        let linePath: UIBezierPath = UIBezierPath()
        linePath.move(to: CGPoint(x: 27, y: 108))
        linePath.addLine(to: CGPoint(x: 189, y: 108))
        linePath.lineWidth = 3
        color.set()
        linePath.stroke()
        
        // service lane 2
        let linePath2: UIBezierPath = UIBezierPath()
        linePath2.move(to: CGPoint(x: 27, y: 360))
        linePath2.addLine(to: CGPoint(x: 189, y: 360))
        linePath2.lineWidth = 3
        color.set()
        linePath2.stroke()
        
        // singles sideline 1
        let linePath3: UIBezierPath = UIBezierPath()
        linePath3.move(to: CGPoint(x: 27, y: 0))
        linePath3.addLine(to: CGPoint(x: 27, y: 468))
        linePath3.lineWidth = 3
        color.set()
        linePath3.stroke()
        
        // singles sideline 2
        let linePath4: UIBezierPath = UIBezierPath()
        linePath4.move(to: CGPoint(x: 189, y: 0))
        linePath4.addLine(to: CGPoint(x: 189, y: 468))
        linePath4.lineWidth = 3
        color.set()
        linePath4.stroke()
        
        // service line
        let linePath5: UIBezierPath = UIBezierPath()
        linePath5.move(to: CGPoint(x: 108, y: 108))
        linePath5.addLine(to: CGPoint(x: 108, y: 360))
        linePath5.lineWidth = 3
        color.set()
        linePath5.stroke()
        
        // net
        let color2:UIColor = UIColor.black
        let linePath6: UIBezierPath = UIBezierPath()
        linePath6.move(to: CGPoint(x: 0, y: 234))
        linePath6.addLine(to: CGPoint(x: 216, y: 234))
        linePath6.lineWidth = 3
        color2.set()
        linePath6.stroke()
        
        
        
        
        let saveImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let iv = UIImageView()
        iv.frame = tennisFrame
        iv.image = saveImage
        view?.addSubview(iv)
        
        
    }
        
    // USED FOR THE BACKS OF EVERYONE ELSE'S CARDS
    func setAttributeTextView() {
        let totalWidth : CGFloat = UIScreen.main.bounds.width
        let totalHeight = UIScreen.main.bounds.height
        
        let label = UILabel()
        label.frame = CGRect(x: totalWidth/2-50, y: 20, width: 200, height: 20)
        label.text = "Description"
        label.textColor = .white
        view.addSubview(label)
        
        // result label
        let resultLabel = UILabel()
        resultLabel.frame = CGRect(x: 65, y: 200, width: 250, height: 200)
        resultLabel.text = displayPerson.description
        resultLabel.textColor = .white
        resultLabel.textAlignment = .center
        resultLabel.lineBreakMode = .byWordWrapping
        resultLabel.numberOfLines = 8
        view.addSubview(resultLabel)
    }
    
    @objc func flipCardBack() {
        performSegue(withIdentifier: "flipSegueBack", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
