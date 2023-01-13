//
//  RedVC.swift
//  customSideView
//
//  Created by Rustem Manafov on 13.01.23.
//

import UIKit

class RedVC: MainVC {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle))
//        view.addGestureRecognizer(tap)
        
    }
    
//    @objc func tapHandle() {
//        ((UIApplication.shared.delegate as! AppDelegate).blueMenu as! SideViewController).animation()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (UIApplication.shared.delegate as! AppDelegate).VCInsideRedView = self
    }
    
    func homeVC() {
        if let nav = appDelegate.VCInsideRedView.navigationController {
            let navStack = nav.children
            let vc = storyboard?.instantiateViewController(withIdentifier: "RedVC") as! RedVC
            
            nav.pushViewController(vc, animated: true)
        }
    }
    
    func profileVC() {
        if let nav = appDelegate.VCInsideRedView.navigationController {
            let navStack = nav.children
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            
            nav.pushViewController(vc, animated: true)
        }
    }
    
    func nearbyVC() {
        if let nav = appDelegate.VCInsideRedView.navigationController {
            let navStack = nav.children
            let vc = storyboard?.instantiateViewController(withIdentifier: "NearbyViewController") as! NearbyViewController

            nav.pushViewController(vc, animated: true)
        }
    }
}

