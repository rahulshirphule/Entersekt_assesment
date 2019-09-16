# Entersekt_assesment
Rahul Shirphule Assessment


# General Information

This project is to serve with Data for Shops across the Country in South Africa.


# Technology 

Swift 5

Xcode 10.3

# SetUP

add Entersekt_asses.framework in you Xcode project under linked Framework and library

# Development 

This framework have bleow methods and all these methods are async methods

> func getListofCities() -> will return list of cities.

> func getCity(cityID: Int) -> will return particular  city.

> func getListofMallsInCity(cityID: Int) -> will return list of malls in city.

> func getListofShopsInMall(cityId: Int, mallId: Int, shopId: Int) -> will return list of shops in mall.

> func getShopInMall(cityId: Int, mallId: Int, shopId: Int) -> will return perticular shop in Mall.

> func getListofShopsInMall(cityID: Int, mallId: Int) -> will return list of shops in mall.

> func getListofShopsInCity(cityID: Int) -> will return list of shops in city.


# How to use

`import Entersekt_asses`

`let entersketSDK = EntersketSDK();`
        `entersketSDK.getListofCities{ (data)`
            `in`
            `if data != nil {`
                 `// success`
            `} else {`
                `// failure`
            `}`
        `};`
        
# Common problems

In as case to server with Data you need to be online atleast for first call..then after it will store the latest recoed in Json file locally.




