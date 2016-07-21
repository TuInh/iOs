//
//  ReadXml.swift
//  Lozi5
//
//  Created by AnhLtv on 4/12/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import Foundation
import CoreData
class ReadXml : NSObject, NSXMLParserDelegate
{
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    var nameOfFile = ""
    var currentElement : String?
    var myList:NSMutableArray = NSMutableArray()
    var xmlConsumer : TextViewController? = nil
    init(fileName :String, consumer: TextViewController)
    {
        self.nameOfFile = fileName;
        self.xmlConsumer = consumer;
    }
    
    func parserDidEndDocument(parser: NSXMLParser)
    {
        if (self.xmlConsumer != nil)
        {
            self.xmlConsumer?.loadXMLCompleted();
        }
    }
    
    func beginParsing()
    {
        posts = []
        let path = NSBundle.mainBundle().pathForResource(nameOfFile, ofType: "xml")
        if path != nil {
            
            parser = NSXMLParser(contentsOfURL: NSURL(fileURLWithPath: path!))!
            
            
        } else {
            NSLog("Failed to find MyFile.xml")
        }
        parser.delegate = self
        parser.parse()
    }
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "birth" {
            currentElement = ""
        } else {
            currentElement = nil
        }
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "birth" {
            if let name = currentElement {
            
                myList.addObject(name)
            }
        }
        currentElement = nil
        
    }
    func parser(parser: NSXMLParser, foundCharacters string: String) {
       
        currentElement? += string ?? ""
    }
    func saveCoreData()
    {
        
    }

}