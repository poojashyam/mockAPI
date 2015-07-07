//
//  ViewController.swift
//  clientAPI
//
//  Created by pooja on 7/7/15.
//  Copyright (c) 2015 pooja. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    var baseURL : String = "http://www.mocky.io/v2/"
    var request : NSMutableURLRequest = NSMutableURLRequest()
    var compareEmail = "test01@mail.com"
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        self.getRequest();
//        self.PostLogin();
        self.createNewUser();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //display credentials of a user from the server
    //GET
    func getRequest(){
        var extenstion : String = "559c4ff4d797efa11655a573"
        var url = baseURL + extenstion
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            var getEmail = jsonResult["email"] as? String;
            if (jsonResult != nil) {
                
                //let str = NSString(data:getEmail, encoding: NSUTF8StringEncoding)
                println(getEmail)
                // process jsonResult
            } else {
                println("couldnt load json");
                // couldn't load JSON, look at error
            }
        })
    }
    
    
    //validate security key answer for a certain user.
    //POST
    func PostLogin(){
        
        var validateChallengeAnswer = "new Whale";
        println("Enter challengeAnswer");
        
        var extenstion : String = "559c4ff4d797efa11655a573"
        var url = baseURL + extenstion
        let email = "test01@mail.com"
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"

        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSMutableDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSMutableDictionary
            var postAnswer = jsonResult["email"] as? String;
            
            if(jsonResult != nil){
                
                if(email == postAnswer){
                    
                    jsonResult["security"]!.setValue("new Whale", forKey:"answer")
                    //println(jsonResult["security"]!["question"])
                    println("New object value : ",jsonResult);
                    
                }
            }
        })
        
    }
    
    //creating a new user
    
    func createNewUser(){
        var extenstion : String = "559c4ff4d797efa11655a573"
        var url = baseURL + extenstion
        
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POSTS"
        
        var newPost: NSDictionary = ["email": "Frist Psot"];
        var postJSONError: NSError?
        var jsonPost = NSJSONSerialization.dataWithJSONObject(newPost, options: nil, error:  &postJSONError)
        request.HTTPBody = jsonPost
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{
            (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if let anError = error
            {
                // got an error in getting the data, need to handle it
                println("error calling POST on /posts")
            }
            else
            {
                // parse the result as json, since that's what the API provides
                var jsonError: NSError?
                let post = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSMutableDictionary
                if let aJSONError = jsonError
                {
                    // got an error while parsing the data, need to handle it
                    println("error parsing response from POST on /posts")
                }
                else
                {
                    // we should get the post back, so print it to make sure all the fields are as we set to and see the id
                    println("The post is: " + post.description)
                }
            }
        })
    }
    
    
    //Delete
    
    func deleteFromAPI(){
        var extenstion : String = "559c4ff4d797efa11655a573"
        var url = baseURL + extenstion
        
        request.URL = NSURL(string: url)
        request.HTTPMethod = "DELETE"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{
            (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if let anError = error
            {
                // got an error while deleting, need to handle it
                println("error calling DELETE on /posts/1")
                println(anError)
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

