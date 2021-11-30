//
//  SurveyPageViewController.swift
//  Nimble
//
//  Created by Abdul Rahim on 30/11/21.
//

import UIKit

class SurveyPageViewController: UIPageViewController {
    
    var surveyList: [Survey]?
    weak var surveyPageDelegate: SurveyPageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }
}


extension SurveyPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? SurveyViewController,
           let currentSurvey = currentViewController.survey,
           let currentIndex = surveyList?.firstIndex(where: { $0.title == currentSurvey.title }) {
            return viewControllerAtIndex(index: currentIndex - 1)
        }

        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? SurveyViewController,
           let currentSurvey = currentViewController.survey,
           let currentIndex = surveyList?.firstIndex(where: { $0.title == currentSurvey.title }) {
            return viewControllerAtIndex(index: currentIndex + 1)
        }

        return nil
    }
    
    
}


extension SurveyPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentPageIndex = viewControllers?.first?.view.tag {
            surveyPageDelegate?.surveyPageViewController(surveyPageViewController: self, didUpdatePageIndex: currentPageIndex)
        }
    }
}

protocol SurveyPageViewControllerDelegate: class {
    func surveyPageViewController(surveyPageViewController: SurveyPageViewController,
            didUpdatePageIndex index: Int)
}
