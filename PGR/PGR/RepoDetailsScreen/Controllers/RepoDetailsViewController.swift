//
//  RepoDetailsViewController.swift
//  PGR
//
//  Created by Ibram on 26/11/2020.
//  Copyright © 2020 Ibram. All rights reserved.
//

import UIKit
import Kingfisher

class RepoDetailsViewController: UIViewController {

    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoOwnerImage: UIImageView!
    @IBOutlet weak var repoOwnerName: UILabel!
    @IBOutlet weak var repoURL: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    
    var repoDetailsData: ReposModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillDetailsData()
        addTapToLabel()
    }
    
    private func addTapToLabel(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(RepoDetailsViewController.tapURLFunction))
        repoURL.isUserInteractionEnabled = true
        repoURL.addGestureRecognizer(tap)
    }
    
    private func fillDetailsData(){
        repoName.text = repoDetailsData?.name
        repoOwnerImage.kf.setImage(with: URL(string: repoDetailsData?.owner.avatar_url ?? ""))
        repoOwnerName.text = repoDetailsData?.owner.login
        repoURL.text = repoDetailsData?.owner.repos_url
        repoDescription.text = repoDetailsData?.description
    }
    
    /* open safari method */
    @objc private func tapURLFunction(){
        guard let url = URL(string: repoDetailsData?.owner.repos_url ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
}
