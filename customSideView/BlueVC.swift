//
//  ViewController.swift
//  customSideView
//
//  Created by Rustem Manafov on 13.01.23.
//

import UIKit

class BlueVC: MainVC {
    
    struct SideBar {
        let icon: UIImage
        let title: String
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var blurView: UIView!
    
    private var clearView: UIView!
    
    var presented: Bool = true
    var count: Int = 0
    
    var menu: [SideBar] = [
        SideBar(icon: UIImage(named: "menu_icon_2")!, title: "Home"),
        SideBar(icon: UIImage(named: "profile_icon")!, title: "Profile"),
        SideBar(icon: UIImage(named: "nearby_icon")!, title: "Nearby"),
        SideBar(icon: UIImage(named: "bookmark_icon")!, title: "Bookmark"),
        SideBar(icon: UIImage(named: "notification_icon")!, title: "Notification"),
        SideBar(icon: UIImage(named: "message_icon")!, title: "Message"),
        SideBar(icon: UIImage(named: "setting_icon_1")!, title: "Setting"),
        SideBar(icon: UIImage(named: "help_icon")!, title: "Help"),
        SideBar(icon: UIImage(named: "logout_icon")!, title: "Logout")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (UIApplication.shared.delegate as! AppDelegate).blueMenu = self
        view.backgroundColor = UIColor(red: 0.04, green: 0.56, blue: 0.85, alpha: 1.00)
        
        let panGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(panHandler))
        panGR.edges = .left
        self.containerView.addGestureRecognizer(panGR)
        
        blurView.removeFromSuperview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if clearView != nil {
            clearView.frame = containerView.frame
        }
    }
    
    @objc func panHandler(gesture: UIScreenEdgePanGestureRecognizer){
        let deltaX = gesture.location(in: gesture.view!).x
        let horizontalPercentage = deltaX / self.view.frame.size.width
        
        var scale = 1 - horizontalPercentage
        var translation = deltaX / 2
        
        if scale <= 0.8 {
            scale = 0.8
        }
        
//        if scale <= 1 {
//            blurEffect()
//        }
        
            if translation >= self.view.frame.size.width / 2 {
                translation = self.view.frame.size.width / 2
            }
        
        print(scale)
        
        containerView.transform = CGAffineTransform(scaleX: scale , y: scale).translatedBy(x: translation, y: 0)
        
        let corner = 32 * (1 - scale)
        
        containerView.layer.cornerRadius = corner
        
        if gesture.state == .ended {
            if scale > 0.8 {
                animationOut()
            } else {
                animationIn()
            }
        }
    }
    
    @objc func tapHandler(gesture: UITapGestureRecognizer){
        animationOut()
    }
    
    @objc func swipe(gesture: UISwipeGestureRecognizer) {
        animationOut()
    }
    
    private func createClearView() {
        if presented {
            if clearView != nil {
                clearView.removeFromSuperview()
                clearView = nil
            } else {
                clearView = UIView()
                clearView.backgroundColor = .clear
                self.view.addSubview(clearView)
                
                clearView.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint(item: clearView!, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint(item: clearView!, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint(item: clearView!, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint(item: clearView!, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 1, constant: 0).isActive = true
                
                let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
                clearView.addGestureRecognizer(tapGR)
                
                let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
                swipe.direction = .left
                clearView.addGestureRecognizer(swipe)
            }
        } else {
            if clearView != nil {
                clearView.removeFromSuperview()
                clearView = nil
            }
        }
    }
    
    private func blurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        if blurView != nil {
            blurEffectView.frame = blurView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurView.addSubview(blurEffectView)
        }
    }
    
    func animation() {
        if presented {
            animationOut()
        } else {
            animationIn()
        }
    }
    
    func animationIn() {
        print(containerView.bounds)
        var size = self.view.frame.size.width/2
        
        if UIDevice.isPhone {
            size = self.view.frame.size.width/2
        } else if UIDevice.isPad {
            size = self.view.frame.size.width/4
        }
        
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).translatedBy(x: size, y: 0)
            self.containerView.layer.cornerRadius = 16
        } completion: { _ in
            self.presented = true
            self.createClearView()
        }
    }
    
    func animationOut() {
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.containerView.transform = .identity
            self.containerView.layer.cornerRadius = 0
        } completion: { _ in
            self.presented = false
            self.createClearView()
        }
    }
}

extension BlueVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideTableViewCell", for: indexPath) as! SideTableViewCell
        cell.iconImageView.image = self.menu[indexPath.row].icon
        cell.titleLabel.text = self.menu[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! SideTableViewCell
//        print(cell.titleLabel?.text ?? "")
        
        switch indexPath.row {
        case 0:
            ((UIApplication.shared.delegate as! AppDelegate).VCInsideRedView as! RedVC).homeVC()
            animationOut()
        case 1:
            ((UIApplication.shared.delegate as! AppDelegate).VCInsideRedView as! RedVC).profileVC()
            animationOut()
        case 2:
            ((UIApplication.shared.delegate as! AppDelegate).VCInsideRedView as! RedVC).nearbyVC()
            animationOut()
        default:
            print("There is not any controller to show")
        }
    }
}

public extension UIDevice {

    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    class var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }

    class var isCarPlay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
}

