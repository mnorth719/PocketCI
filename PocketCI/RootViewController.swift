//
//  ViewController.swift
//  PocketCI
//
//  Created by Matt  North on 9/5/18.
//  Copyright © 2018 mmn. All rights reserved.
//

import UIKit
import BoneKit

class RootViewController: UIViewController {
    let service = ProjectService(webClient: WebClient(), requestAuthenticator: RequestAuthenticator())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        service.getProjects().then { projects in
            print(projects)
        }.catch { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

