//
//  TabPageViewController.swift
//  TabPageViewController
//
//  Created by EndouMari on 2016/02/24.
//  Copyright © 2016年 EndouMari. All rights reserved.
//

import UIKit

public class TabPageViewController: UIPageViewController {
    public var isInfinity: Bool = false
    public var option: TabPageOption = TabPageOption()
    public var tabItems: [(viewController: UIViewController, title: String)] = [] {
        didSet {
            tabItemsCount = tabItems.count
        }
    }

    var currentIndex: Int? {
        guard let viewController = viewControllers?.first else {
            return nil
        }
        return tabItems.map{ $0.viewController }.indexOf(viewController)
    }
    private var beforeIndex: Int = 0
    private var tabItemsCount = 0
    private var defaultContentOffsetX: CGFloat {
        return self.view.bounds.width
    }
    private var shouldScrollCurrentBar: Bool = true
    lazy private var tabView: TabView = self.configuredTabView()

    public static func create() -> TabPageViewController {
        let sb = UIStoryboard(name: "TabPageViewController", bundle: NSBundle(forClass: TabPageViewController.self))
        return sb.instantiateInitialViewController() as! TabPageViewController
    }
    
    override public func viewDidLayoutSubviews() {
        self.navigationController! .setNavigationBarHidden(false, animated: false)
        self.navigationItem .setHidesBackButton(true, animated: true)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        generalConfiguration()
        


        setupPageViewController()
        setupScrollView()
        updateNavigationBar()
    }
    
    func generalConfiguration() {
        
        let btnMenu = UIButton(type: .Custom)
        btnMenu .setImage(UIImage(named: "hamburguer"), forState: .Normal)
        btnMenu.frame = CGRectMake(0.0, 0.0, 34.0, 32.0)
        btnMenu.addTarget(self, action: #selector(TabPageViewController.popToViewController), forControlEvents: .TouchUpInside)
        btnMenu.adjustsImageWhenHighlighted = false
        let btnMenuItem = UIBarButtonItem(customView: btnMenu)
        self.navigationItem.setLeftBarButtonItem(btnMenuItem, animated: true)
        
        let btnRadioEnVivo = UIButton(type: .Custom)
        btnRadioEnVivo .setImage(UIImage(named: "en_vivo"), forState: .Normal)
        btnRadioEnVivo.frame = CGRectMake(0.0, 0.0, 34.0, 32.0)
        btnRadioEnVivo.addTarget(self, action: #selector(TabPageViewController.loadRadioInLive), forControlEvents: .TouchUpInside)
        btnRadioEnVivo.adjustsImageWhenHighlighted = false
        let btnRadioEnVivoItem = UIBarButtonItem(customView: btnRadioEnVivo)
        self.navigationItem.setRightBarButtonItem(btnRadioEnVivoItem, animated: true)
        
    }
    
    func popToViewController() {
        print("call to menu")
    }
    
    func loadRadioInLive() {
        print("loadRadioInLive")
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("NowPlayingViewController") as! NowPlayingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        if tabView.superview == nil {
            tabView = configuredTabView()
        }

        if let currentIndex = currentIndex where isInfinity {
            tabView.updateCurrentIndex(currentIndex, shouldScroll: true)
        }
    }

    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        updateNavigationBar()
    }

    override public func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
    }
}


// MARK: - Public Interface

public extension TabPageViewController {

    public func displayControllerWithIndex(index: Int, direction: UIPageViewControllerNavigationDirection, animated: Bool) {

        beforeIndex = index
        shouldScrollCurrentBar = false
        let nextViewControllers: [UIViewController] = [tabItems[index].viewController]

        let completion: (Bool -> Void) = { [weak self] _ in
            self?.shouldScrollCurrentBar = true
            self?.beforeIndex = index
        }

        setViewControllers(
            nextViewControllers,
            direction: direction,
            animated: animated,
            completion: completion)
    }
}


// MARK: - View

extension TabPageViewController {

    private func setupPageViewController() {
        dataSource = self
        delegate = self
        automaticallyAdjustsScrollViewInsets = false

        setViewControllers([tabItems[beforeIndex].viewController],
            direction: .Forward,
            animated: false,
            completion: nil)
    }

    private func setupScrollView() {
        // Disable PageViewController's ScrollView bounce
        let scrollView = view.subviews.flatMap { $0 as? UIScrollView }.first
        scrollView?.scrollsToTop = false
        scrollView?.delegate = self
        scrollView?.backgroundColor = option.pageBackgoundColor
    }

    /**
     Update NavigationBar
     */

    private func updateNavigationBar() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.shadowImage = UIImage()
            navigationBar.setBackgroundImage(option.tabBackgroundImage, forBarMetrics: .Default)
        }
    }

    private func configuredTabView() -> TabView {
        let tabView = TabView(isInfinity: isInfinity, option: option)
        tabView.translatesAutoresizingMaskIntoConstraints = false

        let height = NSLayoutConstraint(item: tabView,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Height,
            multiplier: 1.0,
            constant: option.tabHeight)
        tabView.addConstraint(height)
        view.addSubview(tabView)

        let top = NSLayoutConstraint(item: tabView,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: topLayoutGuide,
            attribute: .Bottom,
            multiplier:1.0,
            constant: 0.0)

        let left = NSLayoutConstraint(item: tabView,
            attribute: .Leading,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Leading,
            multiplier: 1.0,
            constant: 0.0)

        let right = NSLayoutConstraint(item: view,
            attribute: .Trailing,
            relatedBy: .Equal,
            toItem: tabView,
            attribute: .Trailing,
            multiplier: 1.0,
            constant: 0.0)

        view.addConstraints([top, left, right])

        tabView.pageTabItems = tabItems.map({ $0.title})
        tabView.updateCurrentIndex(beforeIndex, shouldScroll: true)

        tabView.pageItemPressedBlock = { [weak self] (index: Int, direction: UIPageViewControllerNavigationDirection) in
            self?.displayControllerWithIndex(index, direction: direction, animated: true)
        }

        return tabView
    }
}


// MARK: - UIPageViewControllerDataSource

extension TabPageViewController: UIPageViewControllerDataSource {
    
    private func nextViewController(viewController: UIViewController, isAfter: Bool) -> UIViewController? {

        guard var index = tabItems.map({$0.viewController}).indexOf(viewController) else {
            return nil
        }

        if isAfter {
            index += 1
        } else {
            index -= 1
        }

        if isInfinity {
            if index < 0 {
                index = tabItems.count - 1
            } else if index == tabItems.count {
                index = 0
            }
        }

        if index >= 0 && index < tabItems.count {
            return tabItems[index].viewController
        }
        return nil
    }

    public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: true)
    }

    public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: false)
    }
}


// MARK: - UIPageViewControllerDelegate

extension TabPageViewController: UIPageViewControllerDelegate {

    public func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        shouldScrollCurrentBar = true
        tabView.scrollToHorizontalCenter()

        // Order to prevent the the hit repeatedly during animation
        tabView.updateCollectionViewUserInteractionEnabled(false)
    }

    public func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentIndex = currentIndex where currentIndex < tabItemsCount {
            tabView.updateCurrentIndex(currentIndex, shouldScroll: false)
            beforeIndex = currentIndex
        }

        tabView.updateCollectionViewUserInteractionEnabled(true)
    }
}


// MARK: - UIScrollViewDelegate

extension TabPageViewController: UIScrollViewDelegate {

    public func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x == defaultContentOffsetX || !shouldScrollCurrentBar {
            return
        }

        // (0..<tabItemsCount)
        var index: Int
        if scrollView.contentOffset.x > defaultContentOffsetX {
            index = beforeIndex + 1
        } else {
            index = beforeIndex - 1
        }

        if index == tabItemsCount {
            index = 0
        } else if index < 0 {
            index = tabItemsCount - 1
        }

        let scrollOffsetX = scrollView.contentOffset.x - view.frame.width
        tabView.scrollCurrentBarView(index, contentOffsetX: scrollOffsetX)
    }

    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        tabView.updateCurrentIndex(beforeIndex, shouldScroll: true)
    }
}
