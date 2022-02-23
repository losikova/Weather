//
//  LoginFormController.swift
//  Weather
//
//  Created by Анастасия Лосикова on 06.01.2022.
//

import UIKit

class LoginFormController: UIViewController {


    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authButton: UIButton!
    
    var interactiveAnimator: UIViewPropertyAnimator!
    
    let webService = WeatherService()
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        // Получаем текст логина
        let login = loginInput.text!
        // Получаем текст-пароль
        let password = passwordInput.text!
        
        // Проверяем, верны ли они
        if login == "admin" && password == "123456" {
            print("успешная авторизация")
        } else {
            print("неуспешная авторизация")
        }

    }
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
      // Получаем размер клавиатуры
      let info = notification.userInfo! as NSDictionary
      let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
      let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
      
      // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
      self.scrollView?.contentInset = contentInsets
      scrollView?.scrollIndicatorInsets = contentInsets
    }
      
  //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
      // Устанавливаем отступ внизу UIScrollView, равный 0
      let contentInsets = UIEdgeInsets.zero
      scrollView?.contentInset = contentInsets
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
//        animateTitlesAppearing()
//        animateTitleAppearing()
//        animateFieldsAppearing()
//        animateAuthButton()
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.view.addGestureRecognizer(recognizer)
        
        keyframeAnimationLabels()
        keyframeAnimationTextFields()
        
        webService.loadWeather(for: "Moscow")
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        let checkOutResult = checkUserData()
        
        if !checkOutResult {
            showLoginError()
        }
        
        return checkOutResult
    }
    
    func checkUserData() -> Bool {
        guard let login = loginInput.text,
              let password = passwordInput.text else {return false}
        
        if login == "admin" && password == "123456" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        let alert = UIAlertController(title: "Ошибка", message: "Введены неправильные данные пользователя", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
//    func animateTitlesAppearing() {
//        let offset = view.bounds.width
//        loginLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
//        passwordLabel.transform = CGAffineTransform(translationX: offset, y: 0)
//
//        UIView.animate(withDuration: 1,
//                       delay: 1,
//                       options: .curveEaseOut,
//                       animations: {
//                            self.loginLabel.transform = .identity
//                            self.passwordLabel.transform = .identity
//                        },
//                       completion: nil)
//    }
//
    func animateTitleAppearing() {
        self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height/2)

//        UIView.animate(withDuration: 1,
//                       delay: 1,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 0,
//                       options: .curveEaseOut,
//                       animations: {
//                            self.titleLabel.transform = .identity
//                        },
//                       completion: nil)
        let animator = UIViewPropertyAnimator(duration: 1,
                                              dampingRatio: 0.5,
                                              animations: {
            self.titleLabel.transform = .identity
        })
        
        animator.startAnimation(afterDelay: 1)

    }
//
//    func animateFieldsAppearing() {
//        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
//        fadeInAnimation.fromValue = 0
//        fadeInAnimation.toValue = 1
//        fadeInAnimation.duration = 1
//        fadeInAnimation.beginTime = CACurrentMediaTime() + 1
//        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
//
//        self.loginInput.layer.add(fadeInAnimation, forKey: nil)
//        self.passwordInput.layer.add(fadeInAnimation, forKey: nil)
//    }
//
//    func animateAuthButton() {
//        let animation = CASpringAnimation(keyPath: "transform.scale")
//        animation.fromValue = 0
//        animation.toValue = 1
//        animation.stiffness = 200
//        animation.mass = 2
//        animation.duration = 2
//        animation.beginTime = CACurrentMediaTime() + 1
//        animation.fillMode = CAMediaTimingFillMode.backwards
//
//        self.authButton.layer.add(animation, forKey: nil)
//    }
    
    func keyframeAnimationLabels() {
        let offset = abs(loginLabel.frame.midY - passwordLabel.frame.midY)
        
        loginLabel.transform = CGAffineTransform(translationX: 0, y: offset)
        passwordLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
        
        UIView.animateKeyframes(withDuration: 1,
                                delay: 1,
                                options: .calculationModePaced,
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.5,
                               animations: {
                self.loginLabel.transform = CGAffineTransform(translationX: 150, y: 50)
                self.passwordLabel.transform = CGAffineTransform(translationX: -150, y: -50)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5,
                               relativeDuration: 0.5,
                               animations: {
                self.loginLabel.transform = .identity
                self.passwordLabel.transform = .identity
            })
        },
                                completion: nil)
    }
    
    func keyframeAnimationTextFields() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        
        let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.stiffness = 150
        scaleAnimation.mass = 2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1
        animationGroup.beginTime = CACurrentMediaTime() + 1
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animationGroup.fillMode = .backwards
        animationGroup.animations = [fadeInAnimation, scaleAnimation]
        
        self.loginInput.layer.add(animationGroup, forKey: nil)
        self.passwordInput.layer.add(animationGroup, forKey: nil)
    }
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveAnimator?.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         dampingRatio: 0.5,
                                                         animations: {
                self.authButton.transform = CGAffineTransform(translationX: 0, y: 150)
            })
            
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: self.view)
            interactiveAnimator.fractionComplete = translation.y / 100
        case .ended:
            interactiveAnimator.stopAnimation(true)
            interactiveAnimator.addAnimations {
                self.authButton.transform = .identity
            }
            interactiveAnimator.startAnimation()
        default: return
        }
    }
}
