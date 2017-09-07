//
//  ShopTests.swift
//  MadridShopsTests
//
//  Created by Carlos on 7/9/17.
//  Copyright © 2017 THO. All rights reserved.
//

import XCTest
//OJO: Esto se salta la protección de público o no
// Mejor no usarlos para testear lo público
//@testable import MadridShops
//OJO: Mejor hacer
import MadridShops

class ShopTests: XCTestCase {
    
    func testGivenEmptyShopsNumberShopsIsZero() {
        // sut -> System Under Test
        let sut = Shops()
        XCTAssertEqual(0, sut.count())
    }
    
    func testGivenShopsWithOneElementNumberShopsIsOne() {
        let sut = Shops()
        sut.add(shop: Shop(name:"Shop"))
        XCTAssertEqual(1, sut.count())
    }
    
}
