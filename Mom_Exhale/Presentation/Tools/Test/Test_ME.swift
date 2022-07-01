//
//  Test_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 01.07.2022.
//

//import Foundation


//private lazy var scrollView: UIScrollView = {
//    let scroll = UIScrollView()
//    scroll.isPagingEnabled = true
//    //        scroll.contentSize = CGSize(width: self.bounds.width * 6,
//    //                                    height: self.bounds.height)
//    scroll.showsHorizontalScrollIndicator = false
//    scroll.layer.cornerRadius = 15
//    scroll.translatesAutoresizingMaskIntoConstraints = false
//    scroll.delegate = self
//    return scroll
//}()


//        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true


//    private func setupBanners(_ banners: [Banner_ME]) {
//        pageControl.numberOfPages = banners.count
//        scrollView.contentSize = CGSize(width: self.bounds.width * CGFloat(banners.count),
//                                        height: self.bounds.height)
//        let colorsArr: [UIColor] = [.red, .green, .magenta, .blue, .tintColor, .brown, .cyan]
//        for x in 0..<banners.count {
//            let view = UIView()
//            view.backgroundColor = colorsArr.randomElement()
//            view.frame = CGRect(x: self.bounds.maxX * CGFloat(x),
//                                y: self.bounds.minY,
//                                width: self.bounds.width,
//                                height: self.bounds.height)
//            scrollView.addSubview(view)
//        }
//    }
