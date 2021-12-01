//
//  SurveyViewController.swift
//  Nimble
//
//  Created by Abdul Rahim on 30/11/21.
//

import UIKit
import AlamofireImage

class SurveyViewController: UIViewController {
    
    
    //MARK:- View  & properties
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var survey: Survey?
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let survey = survey else { return }
        
        coverImageView.af.setImage(withURL: URL(string: survey.coverImageURL+"l")!)
        titleLabel.text = survey.title
        descriptionLabel.text = survey.description
    }
    
    
    //MARK:- Action methods
    
    @IBAction func navButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SurveyDetailViewController") as! SurveyDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

