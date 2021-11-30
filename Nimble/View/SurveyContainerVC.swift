//
//  SurveyContainerVC.swift
//  Nimble
//
//  Created by Abdul Rahim on 30/11/21.
//

import UIKit

class SurveyContainerVC: UIViewController {
    
    //MARK:- View  & properties
    
    @IBOutlet weak var loadingAnimationView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var surveyPageControl: UIPageControl!
    
    
    //MARK:- Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}


extension SurveyContainerVC: SurveyPageViewControllerDelegate {
    func surveyPageViewController(surveyPageViewController: SurveyPageViewController, didUpdatePageIndex index: Int) {
        surveyPageControl.currentPage = index
    }
}

