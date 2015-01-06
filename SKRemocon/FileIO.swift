//
//  FileIO.swift
//  SKRemocon
//
//  Created by kayama on 2015/01/06.
//  Copyright (c) 2015年 kayama. All rights reserved.
//

import UIKit

class FileIO {
   
    class func getHomePath()->String!
    {
        return  NSBundle.mainBundle().bundlePath
    }
    
    class func readFromFile(path: String!)->String!
    {
        // ファイルハンドルを作成する
        let fileHandle = NSFileHandle(forReadingAtPath: path)

        // 失敗したか?
        if (fileHandle == nil) {
            println("File " + path + "not found..")
            return "";
        }
        
        // ファイルの末尾まで読み込む
        let data: NSData = fileHandle!.readDataToEndOfFile()
        
        // データを文字列に変換
        let str: NSString = NSString(data: data, encoding:NSUTF8StringEncoding)!
        //NSString *str = [[NSString alloc]initWithData:data
        //  encoding:NSUTF8StringEncoding];
        
        // ファイルを閉じる
        fileHandle!.closeFile()
        
        return str;
        
    }
    
    class func writeToFile(path: String!, content: String!, append: Bool)->Bool
    {
        // 存在していたら何もしない
        makeBlankFile(path)
        
        // ファイルハンドルを作成する
        let fileHandle = NSFileHandle(forWritingAtPath: path)

        // 失敗したか?
        if (fileHandle == nil) {
            println("File " + path + "not found..")
            return false;
        }
        
        // ファイルに書き込むデータを作成
        let writeLine: NSString = content
        let data: NSData = NSData(bytes: writeLine.UTF8String, length: writeLine.length)
        
        if(append)
        {
            // 書き込み位置をファイルの末尾に設定(追記設定)
            fileHandle?.seekToEndOfFile()
        }
        
        // ファイルに書き込み
        fileHandle?.writeData(data)
        
        // ファイルへのフラッシュ
        fileHandle?.synchronizeFile()
        
        // ファイルを閉じる
        fileHandle?.closeFile()
        
        return true
    }
    
    class func isExist(path: String!)->Bool
    {
        let fileMan : NSFileManager = NSFileManager.defaultManager()
        
        return fileMan.fileExistsAtPath(path)
    }
    
    class func makeBlankFile(path: String!)->Bool
    {
        // ファイルがあった場合は何もしない
        if (isExist(path))
        {
            return false
        }

        let fileMan : NSFileManager = NSFileManager.defaultManager()
        
        // 空ファイル作成
        fileMan.createFileAtPath(path, contents: NSData(), attributes: nil)
    
        return true
    }
    
}
