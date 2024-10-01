//
//  CommonHelper.swift
//  Sybrin.iOS.Common.Showcase
//
//  Created by Default on 2021/04/10.
//  Copyright © 2021 Sybrin Systems. All rights reserved.
//

struct CommonHelper {
    
    //Client
    // NEW
    static let clientLicenseKey = "gv18Obz8Ud4K4F/0vxzSisBVIJRAQ3BZvXH+Ua/bxZwNoHyZcnI43G7hU5gyEESmb1BQaOTZ/6u7yHzdxTKf3MXA8PHH9XrWPyUSdr6ZLkA1H8wfXbkvzCFwJPPTYRSWDCRmjXO5peq/ZIHkUYVVYygH04RKM25Gp+oDJ4i2mQgkmI5AIGM7pT5AYpuz1lrFCfY8Nvrj4d2trOzBJrEzU5/Uf73/zrFCYGU/7GG/7wFFpKlFT6i91Zml4y/mPviAnXC3lqYGmLx6iMve/FxyHlJWW4cytaxNOf1fcqdmnI7bWSFHtE0cRzFQ0hUxFR9QqAXw308vkfWreebcaiQznc2chkz+zw2JddIeqGPH08HUdgM/yxGbF5J5LkMKiuLejJRa3kTe+EhJOjvhzn6nRZsYEtEevpHSbXlgdm+3sU0jNEsYbYRMEJ+hG3obp1N163X5pwbwylE8YaDS4aUidoQVT9ZgpE7IH1CneATMabiNtzxBtx9t6cpLm5OTePTsXPsCBoczecjX9MKM4JxYUg=="
    // OLD
    // static let clientLicenseKey = "gv18Obz8Ud4K4F/0vxzSisBVIJRAQ3BZvXH+Ua/bxZwNoHyZcnI43G7hU5gyEESmb1BQaOTZ/6u7yHzdxTKf3KQkyP3xGbWjH4setfAhAT0sj5h4wkwBRG1WuSu/IU+gBLSzAW6AT7wfEs5eyd/I6oHHjdvbliFAh1ZsIXQF3kCoeNMClgbfOsfuv0t+rg1w5ZI439lqyokTUr61HvVuyQ0ps13IwPjTLC3nH14YzeA4a81exAOkK8bvtKdpgyVsW4FIJcRWoV7O12cVOhkRF56IL2qRvG/CCNsr9/1uXG8XzxDoI07iEbRZqSuDKfDP6+BKZEoCh3tpbsduSq7yJPLq3jwbjlbiTQRGm+u+S5+y6vGP3jDyI+BmKwp99lnaq372qWxaprh0D+zyuxoIFO5AiYKrpRJ4Jv5hAPjEvkq86/By8gG2V75VetBva0ctlVrlSq1QpGIIXm7YYrsSzznDoCUAFGXkO/0gUILEb17NbcBGSy1J4PNtZqj3FtcbRgnJQP988qnOMOfaZaYctw=="
    
    //Sybrin
    static let sybrinLicenseKey = "gv18Obz8Ud4K4F/0vxzSisBVIJRAQ3BZvXH+Ua/bxZwNoHyZcnI43G7hU5gyEESmb1BQaOTZ/6u7yHzdxTKf3K9uEteVQKVynWbZ00Ma5OgX69UD7i14QtXJC5RpN0VchLcfG04OgoQpWWD2Jjniqt4lWT3Ys2prqRm82OsJp5EPWHAuVjErH/nW9Qx32zog4jsieboWygkwm8/yaxCUdjVXB0re7eef2rC+6cYcH+FK6Sjzx4gYpGgjMxj5UAr2Teb46FiwmxhQVW3AR6KvYFY4AYRIoKeUpPVTQHpr8eCtQARjkhzW/p1MjWn5ajI72JgLM48XJu4thHD8faB7PdyK+6ag9Z1+2+yX5ByKf7a7jHIzSyeqIN83El9uPV/XG9l138qnpf6eXhfsj9+qs3Wa89A3Va+zrSTlogw4J4SZMKWjfzLNOBJ/IP6wXykn9+50XGNIP/BDtGFvcrYwERHXsdiHLQRGJ1u52ql9pH5eE0Yc3I6YtjJ0vAfTbL0d0nciK72n+p+Ccm+6ZSfrAQ=="
    
    static func executeWithDeveloperAccess(_ perform: @escaping () -> Void) {
        
        DeveloperSettings.enableDeveloperAccess(token: "zSssBA3k3B7o7aNUSYDnz9BTFmeuVTqVl5KXK6yIbBS3eD3zdyCMMgZ3ozaW4D06fMc4HjOpUew9IV96OxijqyslFtVJI2J7NInG3YySbb9Zao5U3BO597kFlXxMem8hW1CdNJ3tiOYI8E4eXkmhIjREnt1xWAJ7SO5aQwHRTRAV8MEqLjMPvk1J7Cc2wlTQPO78QUNE")
        
        perform()
        
        DeveloperSettings.disableDeveloperAccess()
        
    }
    
}
