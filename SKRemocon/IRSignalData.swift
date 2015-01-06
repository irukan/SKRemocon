//
//  IRSignalData.swift
//  iRKit
//
//  Created by kayama on 2015/01/04.
//  Copyright (c) 2015年 kayama. All rights reserved.
//


class IRSignalData {
    
    var m_dataFilePath: String!
    var m_signals: Dictionary<String, IRSignal>
    
    
    init(dataPath: String) {
        m_dataFilePath = dataPath
        m_signals = Dictionary<String, IRSignal>()
        
        let rawData = FileIO.readFromFile(m_dataFilePath)
        
        for line in rawData.componentsSeparatedByString("\n")
        {
            if ( countElements(line) == 0)
            {
                continue
            }
            
            let split = line.componentsSeparatedByString(",")
            let m_name = split[0]
            
            m_signals[m_name] = IRSignal()
            m_signals[m_name]?.name = m_name
            m_signals[m_name]?.format = split[1]
            m_signals[m_name]?.frequency = NSNumber(long:(split[2] as String).toInt()!)
            m_signals[m_name]?.hostname = split[3]
            m_signals[m_name]?.data = self.StringToNSArray(split[4])
        }
    }
    
    func getIRSignal(name: String)->IRSignal
    {
        return m_signals[name]!
    }
    
    func writeToDataFile(signal: IRSignal!)
    {
        let dic : NSDictionary = signal.asDictionary()
        let data = dic.objectForKey("data") as NSArray
        let freq = dic.objectForKey("freq") as NSNumber
        let format = dic.objectForKey("format") as String
        let hostname = dic.objectForKey("hostname") as String
        let name =  dic.objectForKey("name") as String
        
        var str: String = name + ","
        str += format + ","
        str += freq.stringValue + ","
        str += hostname + ","
        str += IRSignalData.NSArrayToString(data)
        str += "\n"
        
        // ファイルに追記
        FileIO.writeToFile(m_dataFilePath, content: str, append: true)
    }
    
    // NSArrayを文字列に変換
    class func NSArrayToString(arr: NSArray!)->String!
    {
        var ret : String = ""
        for(var i = 0; i < arr.count - 1 ; i++)
        {
            ret += (arr.objectAtIndex(i) as NSNumber).stringValue
            ret += ":"
        }
        ret += (arr.objectAtIndex(arr.count - 1 ) as NSNumber).stringValue
        
        return ret
    }
    
    // 文字列をNSArrayに変換
    func StringToNSArray(str: String!)->NSArray!
    {
        // let strArr = str.componentsSeparatedByString(":")
        //return NSArray().arrayByAddingObjectsFromArray(strArr)
        
        let longArr = NSMutableArray()
        
        for line in str.componentsSeparatedByString(":")
        {
            longArr.addObject(line.toInt()!)
        }
        
        return longArr as NSArray
    }
    
}

