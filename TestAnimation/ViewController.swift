//
//  ViewController.swift
//  TestAnimation
//
//  Created by Egor Badaev on 21.04.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var tapMeLabel: UILabel!
    @IBOutlet weak var animatedImageView: UIImageView!
    
    private lazy var commonConstraints = [
        animatedView.widthAnchor.constraint(equalTo: animatedView.heightAnchor),
        animatedImageView.widthAnchor.constraint(equalTo: animatedImageView.heightAnchor),
    ]

    private lazy var collapsedContraints = [
        animatedView.heightAnchor.constraint(equalToConstant: 150),
        animatedImageView.heightAnchor.constraint(equalToConstant: 130)
    ]

    private lazy var expandedConstraints = [
        animatedView.heightAnchor.constraint(equalToConstant: 300),
        animatedImageView.heightAnchor.constraint(equalToConstant: 65)
    ]

    private var isExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        NSLayoutConstraint.activate(commonConstraints)
        NSLayoutConstraint.activate(collapsedContraints)

        let viewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        animatedView.addGestureRecognizer(viewGestureRecognizer)

        let labelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        tapMeLabel.addGestureRecognizer(labelGestureRecognizer)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeAnimatedViewRound()
    }

    @objc private func viewTapped(_ sender: Any) {

        let labelScale: CGFloat

        if !isExpanded {
            NSLayoutConstraint.deactivate(collapsedContraints)
            NSLayoutConstraint.activate(expandedConstraints)
            labelScale = 3
        } else {
            NSLayoutConstraint.deactivate(expandedConstraints)
            NSLayoutConstraint.activate(collapsedContraints)
            labelScale = 1
        }
        isExpanded.toggle()

        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.makeAnimatedViewRound()
            self.tapMeLabel.transform = CGAffineTransform(scaleX: labelScale, y: labelScale)
        }
    }

    private func makeAnimatedViewRound() {
        animatedView.layer.cornerRadius = animatedView.bounds.width / 2
        animatedImageView.layer.cornerRadius = animatedImageView.bounds.width / 2
    }
}

