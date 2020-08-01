//
//  APIError.swift
//  Testing
//
//  Created by Danil Blinov on 01.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import UIKit

enum APIError: Error {
	case noInternet
	case requestFailed
	case jsonConversionFailure
	case invalidData
	case invalidCredentials
	case responseUnsuccessful
	case jsonParsingFailure
	case tokenExpired
	case serverError(_ message: String)
	
	var image: UIImage {
		switch self {
			case .noInternet:
				return #imageLiteral(resourceName: "ic_connection_error")
			case .requestFailed:
				return #imageLiteral(resourceName: "ic_server_error")
			default:
				return #imageLiteral(resourceName: "ic_server_error")
		}
	}
	
	var description: String {
		switch self {
			case .noInternet:
				return "Соединение с интернетом пропало. Попробуйте перезагрузить страницу"
			case .requestFailed:
				return "Возникла ошибка на сервере. Попробуйте перезагрузить страницу"
			default:
				return ""
		}
	}
	
	var title: String {
		switch self {
			case .noInternet:
				return "Нет соединения с интернетом"
			case .requestFailed:
				return "Что-то пошло не так"
			case .invalidData:
				return "Невалидные данные"
			case .responseUnsuccessful:
				return "Response Unsuccessful"
			case .jsonParsingFailure:
				return "Json Parsing Failure"
			case .invalidCredentials:
				return "Введен неверный логин или пароль"
			case .jsonConversionFailure:
				return "json Conversion Failure"
			case .tokenExpired:
				return "Token Expired"
			case .serverError(let message):
				return message
		}
	}
	
}
