//
//  RevolvTabBar.swift
//  RevolvTabBar
//
//  Created by Aykhan Hajiyev on 23.06.24.
//

import UIKit

open class RevolvTabBar: UIViewController {
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tabBarView: RevolvTabBarView = {
        let tabBarView = RevolvTabBarView()
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        return tabBarView
    }()
    
    open var viewControllers: [UIViewController] {
        []
    }
    
    open var items: RevolvTabBarView.Item {
        .defaultStyle
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        view.addSubview(tabBarView)
        configureConstraints()
        setup()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let firstVC = viewControllers.first {
            contentView.addSubview(firstVC.view)
            firstVC.didMove(toParent: self)
        }
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tabBarView.addShadow()
    }
}

private extension UIView {
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.24
        layer.shadowOffset = .zero
        layer.shadowRadius = 15
    }
}

private extension RevolvTabBar {
    func configureConstraints() {
        configureContentView()
        configureTabBarView()
        
        // Inner functions
        func configureContentView() {
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: view.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
        func configureTabBarView() {
            NSLayoutConstraint.activate([
                tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                tabBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }
    
    func setup() {
        tabBarView.configure(items)
        tabBarView.delegate = self
    }
}

extension RevolvTabBar: RevolvTabBarViewProtocol {
    func didTapItem(_ item: RevolvTabBarItemView, tapIndex: Int) {
        if let tappedIndexVC = viewControllers[safe: tapIndex] {
            contentView.addSubview(tappedIndexVC.view)
            tappedIndexVC.didMove(toParent: self)
        }
    }
}
