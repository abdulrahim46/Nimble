//
//  SurveyContainerVC.swift
//  Nimble
//
//  Created by Abdul Rahim on 30/11/21.
//

import UIKit
import SkeletonView
import AlamofireImage

class SurveyContainerVC: UIViewController {
    
    //MARK:- View  & properties
    
    @IBOutlet weak var loadingAnimationView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var surveyPageControl: UIPageControl!
    
    var surveyPageViewController: SurveyPageViewController!
    
    var userProfile: UserProfile?
    var surveys: [Survey]?
    let viewModel =  SurveyViewModel()
    
    
    //MARK:- Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = SkeletonGradient(baseColor: UIColor.darkGray, secondaryColor: UIColor.gray)
        view.showAnimatedGradientSkeleton(usingGradient: gradient)
        profileImageView.layer.cornerRadius = 18
        fetchProfile()
        fetchSurveyList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func fetchProfile() {
        viewModel.getUserProfile(completion: { [weak self] response in
            if let response = response {
                self?.userProfile = response
                self?.setupProfile()
            }
            self?.view.stopSkeletonAnimation()
            self?.loadingAnimationView.isHidden = true
        })
    }
    
    
    private func fetchSurveyList()  {
        viewModel.getSurveyList(completion: { [weak self] response in
            if let response = response {
                self?.surveys = response
                self?.setupSurvey()
            }
            self?.view.stopSkeletonAnimation()
            self?.loadingAnimationView.isHidden = true
        })
    }
    
    
    private func setupProfile() {
        if let imageUrl = userProfile?.avatarURL {
            profileImageView.af.setImage(withURL: URL(string: imageUrl)!, placeholderImage: UIImage(named: "ProfilePlaceholder"))
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        dateLabel.text = dateFormatter.string(from: Date())
    }
    
    private func setupSurvey() {
        surveyPageControl.numberOfPages = surveys?.count ?? 0
        if let surveys = surveys {
            surveyPageViewController.updatePageViewWith(surveys)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SurveyPageViewController {
            
            surveyPageViewController = controller
            surveyPageViewController.surveyPageDelegate = self
        }
    }
}


extension SurveyContainerVC: SurveyPageViewControllerDelegate {
    func surveyPageViewController(surveyPageViewController: SurveyPageViewController, didUpdatePageIndex index: Int) {
        surveyPageControl.currentPage = index
    }
}

