//
//  RouterTest.swift
//  NewsAppTests
//
//  Created by Danil Komarov on 31.08.2023.
//

import XCTest
@testable import NewsApp

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

final class RouterTest: XCTestCase {
    
    var router: RouterProtocol!
    var navigationCOntroller = MockNavigationController()
    let assembly = AsselderModuleBuilder()

    override func setUpWithError() throws {
        router = Router(navigationController: navigationCOntroller, assemblyBuilder: assembly)
        
    }

    override func tearDownWithError() throws {
        router = nil
    }
    
    func testRouter() {
        router.showDetail(article: nil)
        let detailViewControler = navigationCOntroller.presentedVC
        XCTAssertTrue(detailViewControler is DetailViewController)
    }

}
