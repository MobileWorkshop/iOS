//
//  ViewControllerSpec.swift
//  HelloRest
//
//  Created by Venkat on 6/24/16.
//  Copyright © 2016 Venkat. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
import OHHTTPStubs
import Alamofire
@testable import HelloRest

import UIKit


class FakeViewController: ViewController {
    var getDataCalled: Bool = false
    
    
    override func getData() {
        getDataCalled = true;
    }
}

class ViewControllerSpec: QuickSpec {
    override func spec() {
        beforeEach { 
            stub(condition: isHost("localhost") && isPath("/listall") && isMethodGET()) { request in
                
                let obj = [["key1":"value1"], ["key2":["value2A","value2B"]]]
                
                return OHHTTPStubsResponse(jsonObject: obj, statusCode: 200, headers: nil).responseTime(OHHTTPStubsDownloadSpeed3G)
                
            }
        }
        
        afterEach { 
            OHHTTPStubs.removeAllStubs()
        }
        
        describe(".getData") {
            it("should get data from list all") {
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                
                let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                
                vc.getData();
                
                expect(vc.jsonResults).toEventually(haveCount(2))
            }
            
        }
        
        describe(".viewDidLoad") {
            var fakeVC: FakeViewController!
            
            beforeEach{
                fakeVC = FakeViewController()
                fakeVC.viewDidLoad()
            }
            
            it("should fetch data from server"){
                expect(fakeVC.getDataCalled).to(beTrue())
            }
            
            it("should setup title and adapter"){
                expect(fakeVC.title).to(equal("Hello Rest!"))
                
                let adapter = fakeVC.tableAdapter
                expect(adapter).toNot(beNil())
                
                expect(adapter?.items).to(haveCount(0))
            }
        }
    }
}
