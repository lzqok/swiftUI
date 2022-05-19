//
//  CustomPageVC.swift
//  TestSwiftUI
//
//  Created by 柳宗青 on 2022/5/11.
//

import UIKit

class CustomPageVC: UIViewController, UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    lazy var pageViewVC:UIPageViewController = {
        let pageViewVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.interPageSpacing:10])
        pageViewVC.delegate = self
        pageViewVC.dataSource = self
        return pageViewVC
    }()

    private let pageCtrl = UIPageControl()
    
    let viewCtrls = [BeforPageVC(),AfterPageVC(),FirstVC()]

    private var currentIndex = 0 {
        didSet {
//            pageCtrl.currentPage = currentIndex
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChild(pageViewVC)
        self.view.addSubview(pageViewVC.view)
        pageViewVC.view.frame = self.view.frame
        pageViewVC.didMove(toParent: self)
        
        pageViewVC.setViewControllers([viewCtrls[currentIndex]], direction: .forward, animated: true, completion: nil)
        
        pageCtrl.numberOfPages = viewCtrls.count
        pageCtrl.currentPage = currentIndex
//        pageCtrl.isUserInteractionEnabled = false
        pageCtrl.pageIndicatorTintColor = UIColor.blue
        pageCtrl.currentPageIndicatorTintColor = UIColor.red
//        pageCtrl.addTarget(self, action: #selector(pageAction(_:)), for: .valueChanged)
        self.view.addSubview(pageCtrl)
        
        for (index,view) in pageCtrl.subviews.first!.subviews.first!.subviews.enumerated() {
            print("ccc",pageCtrl.subviews.first!.subviews.first!.subviews.count)
            if let imageView = view as? UIImageView {
                print("gg",index)
                imageView.isUserInteractionEnabled = true
                let btn = UIButton()
                btn.tag = index
                btn.addTarget(self, action: #selector(pageForwardAction), for: .touchUpInside)
                imageView.addSubview(btn)
                btn.translatesAutoresizingMaskIntoConstraints = false
                btn.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
                btn.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
                btn.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
                btn.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
            }
        }
        
        pageCtrl.translatesAutoresizingMaskIntoConstraints = false
        pageCtrl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageCtrl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        let backBtn = UIButton()
        backBtn.setTitle("back", for: .normal)
        backBtn.setTitleColor(UIColor.black, for: .normal)
        backBtn.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        self.view.addSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
    }
    
    @objc func backAction(_ sender:UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = viewCtrls.firstIndex(of: viewController) {
            if index > 0 {
                return viewCtrls[index - 1]
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = viewCtrls.firstIndex(of: viewController) {
            if index < viewCtrls.count - 1 {
                return viewCtrls[index + 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed,
           let visibleViewController = pageViewController.viewControllers?.first,
           let index = viewCtrls.firstIndex(of: visibleViewController) {
            currentIndex = index
        }
    }
    
    @objc func pageForwardAction(_ sender:UIButton) {
        print("btn",sender.tag)
        pageCtrl.currentPage = sender.tag
        pageViewVC.setViewControllers([viewCtrls[sender.tag]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func pageAction(_ sender:UIPageControl) {
        print(sender.currentPage)
//        pageViewVC.setViewControllers([viewCtrls[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    deinit {
        print("deinit",self)
    }
}

class BeforPageVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
    }
    deinit {
        print("deinit",self)
    }
}

class AfterPageVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
    }
    deinit {
        print("deinit",self)
    }
}
