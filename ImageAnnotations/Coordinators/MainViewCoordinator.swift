//
//  MainViewCoordinator.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 23/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class MainViewCoordinator: Coordinator {
    
    var presenter: MainViewController
    
    init(presenter: MainViewController) {
        self.presenter = presenter
    }
    
    func start() {
        
    }
}

extension MainViewCoordinator: MenuProtocol {
    
    func quit(sender: AnyObject) {
        print(#function)
    }
    
    func selectImages(sender: AnyObject) {
        print(#function)
    }
    
    func export(sender: AnyObject) {
        print(#function)
    }

}
