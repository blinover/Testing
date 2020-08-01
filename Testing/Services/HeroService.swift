//
//  HeroService.swift
//  Testing
//
//  Created by Danil Blinov on 01.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import Moya
import ReactiveMoya
import RxSwift

struct HeroService {
	private let apiManager = ApiManager(configuration: Enviorment())
	
	func getHero(by id: Int) -> Observable<Result<HeroApiModel, APIError>> {
		return apiManager.provider.request(HeroApiTarget.hero(id: id).asMultiTarget).map(to: HeroApiModel.self)
	}
}
