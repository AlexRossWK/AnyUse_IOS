//
//  AppFlowCoordinator.swift
//  AnyUse
//
//  Created by Алексей on 24-Feb-22.
//  Copyright © 2022 AlexRoss. All rights reserved.
//

import UIKit

final class AppFlowCoordinator {
    
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        //        // In App Flow we can check if user needs to login, if yes we would run login flow
        //        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        //        let flow = moviesSceneDIContainer.makeMoviesSearchFlowCoordinator(navigationController: navigationController)
        //        flow.start()
    }
}
