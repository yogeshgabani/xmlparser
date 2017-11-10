//
//  ViewController.swift
//  xmlparserdemo
//
//  Created by MACOS on 9/2/17.
//  Copyright © 2017 MACOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,XMLParserDelegate {

    var arr :[Any] = []
    var brr :[Any] = []
    var str = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string:"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20cricket.player.profile%20where%20player_id%3D2962&diagnostics=true&env=store%3A%2F%2F0TxIGQMQbObzvU4Apia0V0")
        
        do {
            let data = try Data(contentsOf: url!)
            
            let parse = XMLParser(data: data)
            parse.delegate = self
            parse.parse()
            
            
        } catch {
            
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        arr = []
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "PlayerProfile" {
            brr = []
        }

    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "TransId" || elementName == "LastUpdated" || elementName == "ProviderName" || elementName == "run_id" {
            brr.append(str)
        }
        else if elementName == "PlayerProfile"
        {
            arr.append(brr)
            brr =  []
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        str = string
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        print(arr)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

