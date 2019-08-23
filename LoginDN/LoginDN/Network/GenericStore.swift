//
//  GenericStore.swift
//  LoginDN
//
//  Created by Mac Pro on 08/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation
// Essa função é um helper que todo StoreAuth e APIAuthStore irá herdar e implementar utilizando os patterns de polimorfismo!

protocol GenericStore {
    var error: NSError { set get }
    typealias completion <T> = (_ result: T, _ failure: Bool) -> Void
}

class GenericAPIStore {
    var error = NSError(domain: "----Erro :(", code: 400, userInfo: [NSLocalizedDescriptionKey : "Tivemos um problema ao obter as informações no servidor!"])
}
