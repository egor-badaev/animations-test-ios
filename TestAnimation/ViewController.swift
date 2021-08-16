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

        transformLabel()

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

        if !isExpanded {
            NSLayoutConstraint.deactivate(collapsedContraints)
            NSLayoutConstraint.activate(expandedConstraints)
        } else {
            NSLayoutConstraint.deactivate(expandedConstraints)
            NSLayoutConstraint.activate(collapsedContraints)
        }
        isExpanded.toggle()

        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.makeAnimatedViewRound()
            self.transformLabel()
        }
    }

    private func makeAnimatedViewRound() {
        animatedView.layer.cornerRadius = animatedView.bounds.width / 2
        animatedImageView.layer.cornerRadius = animatedImageView.bounds.width / 2
    }

    private func transformLabel() {
        let scale: CGFloat = isExpanded ? 1 : 0.333333
        tapMeLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}

