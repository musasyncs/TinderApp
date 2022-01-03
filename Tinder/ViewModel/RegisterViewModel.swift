//
//  RegisterViewModel.swift
//  Tinder
//
//  Created by Ewen on 2021/9/10.
//

import Foundation
import RxSwift
import RxCocoa

class RegiserViewModel {
    private let disposeBag = DisposeBag()
    
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
        
    // observers
    var nameTextInput: AnyObserver<String> { nameTextOutput.asObserver() }
    var emailTextInput: AnyObserver<String> { emailTextOutput.asObserver() }
    var passwordTextInput: AnyObserver<String> { passwordTextOutput.asObserver() }
    
    var validRegisterSubject = BehaviorSubject<Bool>(value: false)
    
    // validRegisterDriver
    var validRegisterDriver: Driver<Bool> = Driver.never()
    
    init() {
        validRegisterDriver = validRegisterSubject
            .asDriver(onErrorDriveWith: Driver.empty())
        
        let nameValid = nameTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 1
            }
        let emailValid = emailTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 6
            }
        let passwordValid = passwordTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 6
            }
        
        Observable.combineLatest(nameValid, emailValid, passwordValid) { $0 && $1 && $2 }
            .subscribe { allValid in
                self.validRegisterSubject.onNext(allValid)
            }
            .disposed(by: disposeBag)
    }
    
}
