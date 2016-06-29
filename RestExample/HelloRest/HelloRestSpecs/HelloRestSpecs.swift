//
//  HelloRestSpecs.swift
//  HelloRestSpecs
//
//  Created by Venkat on 6/23/16.
//  Copyright © 2016 Venkat. All rights reserved.
//

import Quick
import Nimble

class HelloRestSpecs: QuickSpec {
    
    override func spec() {
        describe("myfirsttest") {
            it("should validate true to be true") {
                expect(true).to(beTrue())
            }
            
        }
    }
    
}
