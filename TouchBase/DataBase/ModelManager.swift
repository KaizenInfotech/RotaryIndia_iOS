//1 nov 5.58pm

import UIKit
let sharedInstance = ModelManager()

class ModelManager: NSObject
{
    var groupIDs:String!=""
    var database: FMDatabase? = nil
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("Calendar.sqlite"))
        }
        return sharedInstance
    }
    func getAllStudentData(_ stringMonth:String,stringYear:String,groupID:String) -> NSMutableArray
    {
        
        
        print(stringMonth , stringYear , "111121212121212121212121212121212")
        
        let  group_ID = groupID
        groupIDs = group_ID
        //set today date
        functionForSetTodayDate()
        sharedInstance.database!.open()
        
        
      //  let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("select WeekDayName,WeekDay,TotalDay,FullDate,Day,Month,Year,EventDonAnniv,Remark,NotificationCount,IsThisTodayDate,IsThisTodayDate,IsThisTodayDate,NotificationCount,WeekDay,FullDate,'0' as Count from  tableCalendar where Month="+stringMonth+" and Year="+stringYear+" and day='0' union all  select t1.WeekDayName,t1.WeekDay,t1.TotalDay,t1.FullDate,t1.Day,t1.Month,t1.Year,t1.EventDonAnniv,t1.Remark,t1.NotificationCount,t1.IsThisTodayDate,t1.IsThisTodayDate,t1.IsThisTodayDate,t1.NotificationCount,t1.WeekDay,t1.FullDate,count(t2.NotificationCount) as Count from  tableCalendar as t1 left join tableCalendarMonth as t2 on  t1.FullDate=t2.FullDate  where t1.Month="+stringMonth+" and t1.Year="+stringYear+"  group by t1.FullDate ORDER BY Day ", withArgumentsIn: nil)
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("select WeekDayName,WeekDay,TotalDay,FullDate,Day,Month,Year,EventDonAnniv,Remark,NotificationCount,IsThisTodayDate,IsThisTodayDate,IsThisTodayDate,NotificationCount,WeekDay,FullDate,'0' as Count from  tableCalendar where Month="+stringMonth+" and Year="+stringYear+" ORDER BY Day ", withArgumentsIn: nil)

        
        let marrCalendarInfo : NSMutableArray = NSMutableArray()
        let marrDay : NSMutableArray = NSMutableArray()
        let marrIsThisTodayDate : NSMutableArray = NSMutableArray()
        let marrCount : NSMutableArray = NSMutableArray()

        if (resultSet != nil)
        {
            while resultSet.next()
            {
                print("Day in result calendar \(resultSet.string(forColumn: "Day"))")
                let objCalendarInfo : CalendarInfo = CalendarInfo()
                objCalendarInfo.WeekDayName = resultSet.string(forColumn: "WeekDayName")
                objCalendarInfo.WeekDay = resultSet.string(forColumn: "WeekDay")
                objCalendarInfo.TotalDay = resultSet.string(forColumn: "TotalDay")
                objCalendarInfo.FullDate = resultSet.string(forColumn: "FullDate")
                objCalendarInfo.Day = resultSet.string(forColumn: "Day")
                objCalendarInfo.Month = resultSet.string(forColumn: "Month")
                objCalendarInfo.Year = resultSet.string(forColumn: "Year")
                objCalendarInfo.EventDonAnniv = resultSet.string(forColumn: "EventDonAnniv")
                objCalendarInfo.Remark = resultSet.string(forColumn: "Remark")
                objCalendarInfo.NotificationCount = resultSet.string(forColumn: "NotificationCount")
                objCalendarInfo.IsThisTodayDate = resultSet.string(forColumn: "IsThisTodayDate")
                objCalendarInfo.Count = resultSet.string(forColumn: "Count")
                //print("Deepak       ",objCalendarInfo.Count)
                
                marrCalendarInfo.add(objCalendarInfo)
                // print(resultSet.stringForColumn("IsThisTodayDate"))
                // print(resultSet.string(forColumn: "NotificationCount"))
                //--
                marrDay.add(resultSet.string(forColumn: "Day"))
                marrIsThisTodayDate.add(resultSet.string(forColumn: "IsThisTodayDate"))
                marrCount.add(resultSet.string(forColumn: "Count"))
            }
        }
        print(marrDay)
        
        print("Patidar            ",marrCount)
        sharedInstance.database!.close()
        return marrCalendarInfo
    }
    //code by Rajendra Jat need to set today date in calendar
    func functionForSetTodayDate()
    {
        
        let date = Date()
        let calendar = Calendar.current
        
        var varPassYear = calendar.component(.year, from: date)
        var varPassMonth = calendar.component(.month, from: date)
        var varPassDay = calendar.component(.day, from: date)
        
        
        let  letGetCurrentDay = String(varPassDay)
        let  letGetCurrentMonth = String(varPassMonth)
        let  letGetCurrentYear = String(varPassYear)
        
        
        
        
        
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate("UPDATE tableCalendar SET IsThisTodayDate='0'", withArgumentsIn:nil)
        sharedInstance.database!.close()
        //2.
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate("UPDATE tableCalendar SET IsThisTodayDate="+letGetCurrentDay+"  WHERE Day="+letGetCurrentDay+" and Month="+letGetCurrentMonth+" and Year="+letGetCurrentYear+" " , withArgumentsIn:nil)
        sharedInstance.database!.close()
    }
    //code by Rajendra Jat for new event
 
    func functionForAddUpdateDeleteNewEvent(_ arrayNew:NSArray,arrayUpdate:NSArray,arrayDelete:NSArray,stringLastUpdateDate:String,stringMonth:String,stringYear:String,GroupID:String)
    {
        
         print(arrayNew)
         print(arrayUpdate)
         print(arrayDelete)
        
        
        let result3 = String(stringMonth.dropFirst(9))    // "he"
        print(result3)
        let result4 = String(result3.dropLast(1))   // "o"
        print("2222222222222222222222222222222222222222222222",result4)
        
        
        let result5 = String(stringYear.dropFirst(9))    // "he"
        print(result5)
        let result6 = String(result5.dropLast(1))   // "o"
        print("===**=*=*=*=*=*=*=*=**=*=*=**=*=*=*=*=*=*=*=*=",result6)
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate("DELETE FROM tableCalendarMonth where Month="+result4+" and Year="+result6+"", withArgumentsIn:nil)
        sharedInstance.database!.close()
        
        // functionForDelete()
        
        //insert
        for i in 00..<arrayNew.count
        {
            
            let mudict:NSDictionary=arrayNew.object(at: i)as! NSDictionary
            let varGetTitle=mudict.value(forKey: "title")as! String
            let varGetEventDate=mudict.value(forKey: "eventDate")as! String
            var varSplitDate=varGetEventDate.components(separatedBy: " ")
            var varSplitDateAgain=varSplitDate[0].components(separatedBy: "-")
            let varGetDay=varSplitDateAgain[2]
            let varGetMonth=varSplitDateAgain[1]
            let varGetYear=varSplitDateAgain[0]
            let varGetGroupID=mudict.value(forKey: "groupID")as! String
            let varGetType=mudict.value(forKey: "type")as! String
            let varGetTypeId=mudict.value(forKey: "typeID")as! String
            let varGetUniqueId=mudict.value(forKey: "uniqueID")as! String
            
            var varGetNewDay:String!=""
            varGetNewDay=varGetDay
            
            
            if(varGetDay=="01" || varGetDay=="1")
            {
                varGetNewDay="1"
            }
            else if(varGetDay=="02" || varGetDay=="2")
            {
                varGetNewDay="2"
            }
            else if(varGetDay=="03" || varGetDay=="3")
            {
                varGetNewDay="3"
            }
            else if(varGetDay=="04" || varGetDay=="4")
            {
                varGetNewDay="4"
            }
            else if(varGetDay=="05" || varGetDay=="5")
            {
                varGetNewDay="5"
            }
            else if(varGetDay=="06" || varGetDay=="6")
            {
                varGetNewDay="6"
            }
            else if(varGetDay=="07" || varGetDay=="7")
            {
                varGetNewDay="7"
            }
            else if(varGetDay=="08" || varGetDay=="8")
            {
                varGetNewDay="8"
            }
            else if(varGetDay=="09" || varGetDay=="9")
            {
                varGetNewDay="9"
            }
            
            
            var varGetNewMonth:String!=""
            varGetNewMonth=result4
            
            if(varGetMonth=="01" || varGetMonth=="1")
            {
                varGetNewMonth="1"
            }
            else if(varGetMonth=="02" || varGetMonth=="2")
            {
                varGetNewMonth="2"
            }
            else if(varGetMonth=="03" || varGetMonth=="3")
            {
                varGetNewMonth="3"
            }
            else if(varGetMonth=="04" || varGetMonth=="4")
            {
                varGetNewMonth="4"
            }
            else if(varGetMonth=="05" || varGetMonth=="5")
            {
                varGetNewMonth="5"
            }
            else if(varGetMonth=="06" || varGetMonth=="6")
            {
                varGetNewMonth="6"
            }
            else if(varGetMonth=="07" || varGetMonth=="7")
            {
                varGetNewMonth="7"
            }
            else if(varGetMonth=="08" || varGetMonth=="8")
            {
                varGetNewMonth="8"
            }
            else if(varGetMonth=="09" || varGetMonth=="9")
            {
                varGetNewMonth="9"
            }
            
            
            // print(stringMonth)
            // print(stringYear)
            let varGetTitles  = (varGetTitle as NSString).replacingOccurrences(of: "'", with: "`")
            let FullDate=stringYear+"-"+varGetNewMonth+"-"+varGetNewDay
            sharedInstance.database!.open()
            // print(varGetType)
            sharedInstance.database!.executeUpdate("INSERT INTO tableCalendarMonth (Day,Month,Year,eventDate,groupID,title,type,typeID,uniqueID,FullDate,NotificationCount) VALUES ("+"'"+varGetDay+"'"+","+"'"+result4+"'"+","+"'"+result6+"'"+","+"'"+varGetEventDate+"'"+","+"'"+GroupID+"'"+","+"'"+varGetTitles+"'"+","+"'"+varGetType+"'"+","+"'"+varGetTypeId+"'"+","+"'"+varGetUniqueId+"'"+","+"'"+FullDate+"'"+","+"1"+")", withArgumentsIn:nil)
            /*
             if(varGetType=="Event")
             {
             sharedInstance.database!.executeUpdate("INSERT INTO tableCalendarMonth (Day,Month,Year,eventDate,groupID,title,type,typeID,uniqueID,FullDate,NotificationCount) VALUES ("+"'"+varGetDay+"'"+","+"'"+varGetMonth+"'"+","+"'"+varGetYear+"'"+","+"'"+varGetEventDate+"'"+","+"'"+varGetGroupID+"'"+","+"'"+varGetTitle+"'"+","+"'"+varGetType+"'"+","+"'"+varGetTypeId+"'"+","+"'"+varGetUniqueId+"'"+","+"'"+FullDate+"'"+","+"1"+")", withArgumentsInArray:nil)
             }
             else
             {
             
             
             sharedInstance.database!.executeUpdate("INSERT INTO tableCalendarMonth (Day,Month,Year,eventDate,groupID,title,type,typeID,uniqueID,FullDate,NotificationCount) VALUES ("+"'"+varGetDay+"'"+","+"'"+stringMonth+"'"+","+"'"+stringYear+"'"+","+"'"+varGetEventDate+"'"+","+"'"+varGetGroupID+"'"+","+"'"+varGetTitle+"'"+","+"'"+varGetType+"'"+","+"'"+varGetTypeId+"'"+","+"'"+varGetUniqueId+"'"+","+"'"+FullDate+"'"+","+"1"+")", withArgumentsInArray:nil)
             }
             */
            // print("INSERT INTO tableCalendarMonth (Day,Month,Year,eventDate,groupID,title,type,typeID,uniqueID,FullDate,NotificationCount) VALUES ("+"'"+varGetDay+"'"+","+"'"+stringMonth+"'"+","+"'"+stringYear+"'"+","+"'"+varGetEventDate+"'"+","+"'"+GroupID+"'"+","+"'"+varGetTitle+"'"+","+"'"+varGetType+"'"+","+"'"+varGetTypeId+"'"+","+"'"+varGetUniqueId+"'"+","+"'"+FullDate+"'"+","+"1"+")")
            
            sharedInstance.database!.close()
            
        }
        //update
        for j in 00..<arrayUpdate.count
        {
            // print(j)
            // print(arrayUpdate)
            
            
            let mudict:NSDictionary=arrayUpdate.object(at: j)as! NSDictionary
            let varGetTitle=mudict.value(forKey: "title")as! String
            let varGetEventDate=mudict.value(forKey: "eventDate")as! String
            var varSplitDate=varGetEventDate.components(separatedBy: " ")
            var varSplitDateAgain=varSplitDate[0].components(separatedBy: "-")
            let varGetDay=varSplitDateAgain[2]
            let varGetMonth=varSplitDateAgain[1]
            let varGetYear=varSplitDateAgain[0]
            //let varGetGroupID=mudict.valueForKey("groupID")as! String
            let varGetType=mudict.value(forKey: "type")as! String
            // let varGetTypeId=mudict.valueForKey("typeID")as! String
            let varGetUniqueId=mudict.value(forKey: "uniqueID")as! String
            
            let varGetTitles  = (varGetTitle as NSString).replacingOccurrences(of: "'", with: "`")
            
            
            sharedInstance.database!.open()
            
            if(varGetType=="Event")
            {
                sharedInstance.database!.executeUpdate("UPDATE tableCalendarMonth SET eventDate='"+varGetEventDate+"',title='"+varGetTitles+"', type='"+varGetType+"', groupID='"+GroupID+"' WHERE Day='"+varGetDay+"' and Month='"+result4+"' and Year='"+result6+"' and uniqueID='"+varGetUniqueId+"'", withArgumentsIn: nil)
            }
            else
            {
                sharedInstance.database!.executeUpdate("UPDATE tableCalendarMonth SET eventDate='"+varGetEventDate+"',title='"+varGetTitles+"', type='"+varGetType+"', groupID='"+GroupID+"' WHERE Day='"+varGetDay+"' and Month='"+result4+"' and Year='"+result6+"' and uniqueID='"+varGetUniqueId+"'", withArgumentsIn: nil)
            }
            
            // print("UPDATE tableCalendarMonth SET eventDate='"+varGetEventDate+"',title='"+varGetTitle+"', type='"+varGetType+"' , groupID='"+GroupID+"' WHERE Day='"+varGetDay+"' and Month='"+stringMonth+"' and Year='"+stringYear+"' and uniqueID='"+varGetUniqueId+"'")
            
            //  print("UPDATE tableCalendarMonth SET eventDate='"+varGetEventDate+"',title='"+varGetTitle+"', type='"+varGetType+"' WHERE Day='"+varGetDay+"' and Month='"+varGetMonth+"' and Year='"+varGetYear+"' and uniqueID='"+varGetUniqueId+"'")
            
            sharedInstance.database!.close()
            
        }
        //delete
        for k in 00..<arrayDelete.count
        {
            //5662 print(k)
            //  print(arrayDelete)
            
            let mudict:NSDictionary=arrayDelete.object(at: k)as! NSDictionary
            let varGetTitle=mudict.value(forKey: "title")as! String
            let varGetEventDate=mudict.value(forKey: "eventDate")as! String
            var varSplitDate=varGetEventDate.components(separatedBy: " ")
            var varSplitDateAgain=varSplitDate[0].components(separatedBy: "-")
            let varGetDay=varSplitDateAgain[2]
            let varGetMonth=varSplitDateAgain[1]
            let varGetYear=varSplitDateAgain[0]
            //let varGetGroupID=mudict.valueForKey("groupID")as! String
            let varGetType=mudict.value(forKey: "type")as! String
            // let varGetTypeId=mudict.valueForKey("typeID")as! String
            let varGetUniqueId=mudict.value(forKey: "uniqueID")as! String
            sharedInstance.database!.open()
            // if(varGetType=="Event")
            // {
            //  sharedInstance.database!.executeUpdate("DELETE FROM tableCalendarMonth WHERE Day='"+varGetDay+"' and Month='"+varGetMonth+"' and Year='"+varGetYear+"' and uniqueID='"+varGetUniqueId+"'", withArgumentsInArray:nil)
            //}
            /// else
            //{
            sharedInstance.database!.executeUpdate("DELETE FROM tableCalendarMonth WHERE Day='"+varGetDay+"' and Month='"+result4+"' and Year='"+result6+"' and uniqueID='"+varGetUniqueId+"'", withArgumentsIn:nil)
            // }
            sharedInstance.database!.close()
            //  print("DELETE FROM tableCalendarMonth WHERE Day='"+varGetDay+"' and Month='"+stringMonth+"' and Year='"+stringYear+"' and uniqueID='"+varGetUniqueId+"'")
        }
        //--need to update lastupdatedate after setting insert update and delete operation
        
        //  print(stringLastUpdateDate)
        //   print(stringMonth)
        //  print(stringYear)
        
        //---
        var varGetMonthValue:String!=""
        varGetMonthValue = result4
        if(stringMonth=="01" || stringMonth=="1")
        {
            varGetMonthValue="1"
        }
        else if(stringMonth=="02" || stringMonth=="2")
        {
            varGetMonthValue="2"
        }
        else if(stringMonth=="03" || stringMonth=="3")
        {
            varGetMonthValue="3"
        }
        else if(stringMonth=="04" || stringMonth=="4")
        {
            varGetMonthValue="4"
        }
        else if(stringMonth=="05" || stringMonth=="5")
        {
            varGetMonthValue="5"
        }
        else if(stringMonth=="06" || stringMonth=="6")
        {
            varGetMonthValue="6"
        }
        else if(stringMonth=="07" || stringMonth=="7")
        {
            varGetMonthValue="7"
        }
        else if(stringMonth=="08" || stringMonth=="8")
        {
            varGetMonthValue="8"
        }
        else if(stringMonth=="09" || stringMonth=="9")
        {
            varGetMonthValue="9"
        }
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate("UPDATE tableCalendar SET LastUpdateDate='"+stringLastUpdateDate+"' WHERE Month="+varGetMonthValue+" and Year="+result6+"" , withArgumentsIn:nil)
        
        //print("UPDATE tableCalendar SET LastUpdateDate='"+stringLastUpdateDate+"' WHERE Month="+varGetMonthValue+" and Year="+stringYear+"")
        
        sharedInstance.database!.close()
        
        //-----NotificationCount
        //-------------------update notification in tableCalendar table count purpose
        sharedInstance.database!.open()
        let resultSett: FMResultSet! = sharedInstance.database!.executeQuery("select Day,Month,Year,groupID,count(*)Count from  tableCalendarMonth where Month="+result4+" and Year="+result6+" and groupID="+GroupID+" group by day", withArgumentsIn: nil)
        
        //select Day,Month,Year,count(*)Counts from  tableCalendarMonth where Month=3 and Year=2017  group by day
        
        
        // print("select Day,Month,Year,count(*)Count from  tableCalendarMonth where Month="+stringMonth+" and Year="+stringYear+"")
        
        
        if (resultSett != nil)
        {
            while resultSett.next()
            {
                // print(resultSett)
                let letDayr = resultSett.string(forColumn: "Day")
                let letMonthr = resultSett.string(forColumn: "Month")
                let letYearr = resultSett.string(forColumn: "Year")
                
                let groupID = resultSett.string(forColumn: "groupID")
                
                
                let letCountr = resultSett.string(forColumn: "Count")
                //print(resultSett.stringForColumn("Day"))
                
                var nRows = resultSett.int(forColumnIndex: 0)
                // print(nRows)
                //----update notification in main tableCalndar
                
                
               // var query = "UPDATE tableCalendar SET NotificationCount="+letCountr+",groupID='"+GroupID+"' WHERE Day="+letDayr+" and Month="+letMonthr+" and Year="+letYearr+""
                
                var query1 = "UPDATE tableCalendar SET NotificationCount="+letCountr!+",groupID='"+GroupID+"'"
                var query2 = " WHERE Day="+letDayr!+""
                var query3 = " and Month="+letMonthr!+" and Year="+letYearr!+""

                var query = query1+" "+query2+" "+query3
                // sharedInstance.database!.open()
                sharedInstance.database!.executeUpdate(query , withArgumentsIn:nil)
                
                //  print("UPDATE tableCalendar SET NotificationCount="+letCountr+",groupID='"+GroupID+"' WHERE Day="+letDayr+" and Month="+letMonthr+" and Year="+letYearr+"")
                
                
            }
        }
        sharedInstance.database!.close()
        
        
        
        
        
        
    }

    func functionForGetLastUpdateDateFromMonthTable(_ stringMonth:String,stringYear:String,GroupID:String)->String
    {
        
        var result4:String!=""
        var result6:String!=""
        if(stringMonth.hasPrefix("Optional("))
        {
            let result3 = String(stringMonth.dropFirst(9))    // "he"
            print(result3)
             result4 = String(result3.dropLast(1))   // "o"
            print("31313113133131131331313131311331133131313131",result4)
            
        }
        else
        {
           result4 = stringMonth
        }
        
        if(stringYear.hasPrefix("Optional("))
        {
            let result5 = String(stringYear.dropFirst(9))    // "he"
            print(result5)
             result6 = String(result5.dropLast(1))   // "o"
            print("**********************************",result6)
            
        }
        else
        {
          result6 = stringYear
        }
        
        
        
        
        var letGetLastUpdateDate:String!=""
        sharedInstance.database!.open()
//        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("select LastUpdateDate from tableCalendar where Month="+result4+" and Year="+result6+"", withArgumentsIn: nil)

        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("select LastUpdateDate from tableCalendar where Month=\(result4) and Year=\(result6)", withArgumentsIn: nil)

        // print("select LastUpdateDate from tableCalendar where Month="+stringMonth+" and Year="+stringYear+"")
        
        
        if (resultSet != nil)
        {
            while resultSet.next()
            {
                letGetLastUpdateDate = resultSet.string(forColumn: "LastUpdateDate")
                break
            }
        }
        sharedInstance.database!.close()
        // print(letGetLastUpdateDate)
        return letGetLastUpdateDate
    }
    func functionForGetEventBirthdayAnnivversaryData(_ stringDay:String,stringMonth:String,stringYear:String)->NSMutableArray
    {
        
        
        print(stringDay , stringMonth , stringYear ,"55555555555555555555555")
        
        var result2:String!=""
        var result4:String!=""
        var result6:String!=""
        if(stringDay.hasPrefix("Optional("))
        {
            let result1 = String(stringDay.dropFirst(9))    // "he"
            print(result1)
             result2 = String(result1.dropLast(1))   // "o"
            print("Dayyyyyyyy2222222222222222222222222222222222222222222222",result2)
            
        }
        else
        {
           result2 = stringDay
        }
        
        if(stringMonth.hasPrefix("Optional("))
        {
            let result3 = String(stringMonth.dropFirst(9))    // "he"
            print(result3)
             result4 = String(result3.dropLast(1))   // "o"
            print("Monthhhhhhh2222222222222222222222222222222222222222222222",result4)
            
        }
        else
        {
            result4 = stringMonth
        }
        
        if(stringYear.hasPrefix("Optional("))
        {
            let result5 = String(stringYear.dropFirst(9))    // "he"
            print(result5)
             result6 = String(result5.dropLast(1))   // "o"
            print("Yearrrrrrrrr===**=*=*=*=*=*=*=*=**=*=*=**=*=*=*=*=*=*=*=*=",result6)
            
        }
        else{
            result6 = stringYear
        }
        
        
        
        
        
        //---Day
        var varGetNewDay:String!=""
        varGetNewDay=result2
        if(stringDay=="01" || stringDay=="1")
        {
            varGetNewDay="01"
        }
        else if(stringDay=="02" || stringDay=="2")
        {
            varGetNewDay="02"
        }
        else if(stringDay=="03" || stringDay=="3")
        {
            varGetNewDay="03"
        }
        else if(stringDay=="04" || stringDay=="4")
        {
            varGetNewDay="04"
        }
        else if(stringDay=="05" || stringDay=="5")
        {
            varGetNewDay="05"
        }
        else if(stringDay=="06" || stringDay=="6")
        {
            varGetNewDay="06"
        }
        else if(stringDay=="07" || stringDay=="7")
        {
            varGetNewDay="07"
        }
        else if(stringDay=="08" || stringDay=="8")
        {
            varGetNewDay="08"
        }
        else if(stringDay=="09" || stringDay=="9")
        {
            varGetNewDay="09"
        }
        //----
        //---Month
        var varGetNewMonth:String!=""
        varGetNewMonth=result4
        if(stringMonth=="01" || stringMonth=="1")
        {
            varGetNewMonth="1"
        }
        else if(stringMonth=="02" || stringMonth=="2")
        {
            varGetNewMonth="2"
        }
        else if(stringMonth=="03" || stringMonth=="3")
        {
            varGetNewMonth="3"
        }
        else if(stringMonth=="04" || stringMonth=="4")
        {
            varGetNewMonth="4"
        }
        else if(stringMonth=="05" || stringMonth=="5")
        {
            varGetNewMonth="5"
        }
        else if(stringMonth=="06" || stringMonth=="6")
        {
            varGetNewMonth="6"
        }
        else if(stringMonth=="07" || stringMonth=="7")
        {
            varGetNewMonth="7"
        }
        else if(stringMonth=="08" || stringMonth=="8")
        {
            varGetNewMonth="8"
        }
        else if(stringMonth=="09" || stringMonth=="9")
        {
            varGetNewMonth="9"
        }
        //----
        
        
        
        
        
        var muarrGetEventBirthAnniv:NSMutableArray=NSMutableArray()
        
        //        if(stringDay=="0")
        //        {
        //            sharedInstance.database!.open()
        //            let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("select * from tableCalendar where  Month="+stringMonth+" and Year="+stringYear+"", withArgumentsInArray: nil)
        //
        //            if (resultSet != nil)
        //            {
        //                while resultSet.next()
        //                {
        //                    let objCalendarInfo : CalendarInfo = CalendarInfo()
        //                    objCalendarInfo.stringEventDate = resultSet.stringForColumn("LastUpdateDate")
        //                    objCalendarInfo.stringTitle = resultSet.stringForColumn("LastUpdateDate")
        //                    objCalendarInfo.stringType = resultSet.stringForColumn("LastUpdateDate")
        //                    objCalendarInfo.stringTime = resultSet.stringForColumn("LastUpdateDate")
        //                    objCalendarInfo.stringTypeID = resultSet.stringForColumn("LastUpdateDate")
        //                    muarrGetEventBirthAnniv.addObject(objCalendarInfo)
        //                }
        //
        //                /*
        //
        //                 var stringEventDate: String = String()
        //                 var stringTitle: String = String()
        //                 var stringType: String = String()
        //                 var stringTime: String = String()
        //                 var stringTypeID: String = String()
        //
        //                 */
        //
        //
        //            }
        //            sharedInstance.database!.close()
        //            return muarrGetEventBirthAnniv
        //        }
        //        else
        //        {

        sharedInstance.database!.open()
//        var query :String! = "select * from tableCalendarMonth where Day='"+varGetNewDay+"' and Month='"+varGetNewMonth+"' and Year='"+result6+"'"

        
        var query :String! = "select * from tableCalendarMonth where Day='\(varGetNewDay)' and Month='\(varGetNewMonth)' and Year='\(result6)'"

        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(query, withArgumentsIn: nil)
        
        // print("select * from tableCalendarMonth where Day='"+varGetNewDay+"' and Month='"+varGetNewMonth+"'   ")
        //print("select * from tableCalendarMonth where Day='"+varGetNewDay+"' and Month='"+varGetNewMonth+"' and Year='"+stringYear+"'")
        
        
        if (resultSet != nil)
        {
            
            while resultSet.next()
            {
                let objCalendarInfo : CalendarInfo = CalendarInfo()
                objCalendarInfo.stringEventDate = resultSet.string(forColumn: "eventDate")
                objCalendarInfo.stringTitle = resultSet.string(forColumn: "title")
                objCalendarInfo.stringType = resultSet.string(forColumn: "type")
                objCalendarInfo.stringTime = resultSet.string(forColumn: "eventDate")
                objCalendarInfo.stringTypeID = resultSet.string(forColumn: "typeID")
                objCalendarInfo.stringDateMonth = resultSet.string(forColumn: "typeID")
                var varGetMonth = commonClassFunction().functionForMonthWordWise( resultSet.string(forColumn: "Month"))
                var varDay =  resultSet.string(forColumn: "Day")
                objCalendarInfo.stringDateMonth = varDay!+" "+varGetMonth
                print(objCalendarInfo)
                muarrGetEventBirthAnniv.add(objCalendarInfo)
                print(muarrGetEventBirthAnniv)
            }
        }
        sharedInstance.database!.close()
        return muarrGetEventBirthAnniv
        //}
        
    }
    func functionForDelete()
    {
        sharedInstance.database!.open()
        sharedInstance.database!.executeUpdate("DELETE FROM tableCalendarMonth", withArgumentsIn:nil)
        sharedInstance.database!.close()
    }
    //-----select Country from country_master
    func functionForSelectCountry()->NSMutableArray
    {
        var letGetLastUpdateDate:String!=""
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("select * from country_master", withArgumentsIn: nil)
        let muarrGetCountry:NSMutableArray=NSMutableArray()
        if (resultSet != nil)
        {
            while resultSet.next()
            {
                let objCalendarInfo : CalendarInfo = CalendarInfo()
                objCalendarInfo.stringCountryMasterId = resultSet.string(forColumn: "country_master_id")
                objCalendarInfo.stringCountryMasterName = resultSet.string(forColumn: "country_master_name")
                objCalendarInfo.stringCountryMasterCode = resultSet.string(forColumn: "country_code")
                muarrGetCountry.add(objCalendarInfo)
                
                //print(resultSet.stringForColumn("country_master_name"))
                
            }
        }
        sharedInstance.database!.close()
        // print(letGetLastUpdateDate)
        return muarrGetCountry
    }
}








