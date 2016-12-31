
/*
    Developer: Warren Seto
          File: updateFile.playground
       Purpose: A playground that shows one way to update a file on a device from a server based on the 'Last-Modified' part of a HTTP response
*/


import UIKit

func updateFile(url:String, folder:FileManager.SearchPathDirectory, fileName:String)
{
    let tempURL = URL(string: url)!
    
    var request = URLRequest(url: tempURL)
    request.httpMethod = "HEAD"

    URLSession.shared.dataTask(with: request, completionHandler:
        {
            (data, res, err) -> Void in
            
            if let httpResponse = res as? HTTPURLResponse
            {
                if let onlineModify = httpResponse.allHeaderFields["Last-Modified"] as? String
                {
                    let dateFormatter:DateFormatter = {
                        $0.dateFormat = "EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss ZZZZ"
                        return $0
                    } (DateFormatter())
                    
                    let onlineDate = dateFormatter.date(from: onlineModify)
                    
                    if let localDate = UserDefaults.standard.object(forKey: "\(fileName)_Last-Modified") as? Date
                    {
                        if onlineDate == localDate
                        {
                            return
                        }
                    }
                    
                    URLSession.shared.dataTask(with: tempURL, completionHandler:
                        {
                            (data, res, err) -> Void in
                            
                            if (data != nil)
                            {
                                try? data?.write(to: URL(fileURLWithPath: "\(NSSearchPathForDirectoriesInDomains(folder, .userDomainMask, true).first!)/\(fileName)"), options: .atomic)
                                
                                UserDefaults.standard.set(onlineDate, forKey: "\(fileName)_Last-Modified")
                            }
                    }).resume()
                }
            }
    }).resume()
}

