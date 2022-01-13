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



}
