# MadridShops

Practical exercise for the KeepCoding advanced iOS course.

A map with 'activities' or 'shops' information will be displayed on separate screens. Data will be downloaded from an external json file and will be stored with Core Data.


# Installation

You have to clone the project:

> git clone https://github.com/TheHandyOwl/MadridShops.git AnotherShopApp

In the folder's project you should install the CocoaPods dependencies:

> pod install

You can find more information about CocoaPods in:

[https://guides.cocoapods.org/using/getting-started.html](https://guides.cocoapods.org/using/getting-started.html "CocoaPods - Getting Started")

It's time to run the project!

> open MadridShops.xcworkspace


# Requirements

1. When starting the App for the first time, if there's Internet connection it will download all information from the Shops access point (see below), including all images.
2. The App will cache everything locally: images, data, etc. Even images of the maps. See below for tips.
3. Cache is never invalidated, so once everything has been saved, set a flag and never ever access to the network again.
4. If there's no Internet connection a message will be shown to the user.
5. While caching the App will show an Activity indicator or other loader. Until you finish caching you don't get to the Main menu.
6. The app will have a main menu screen where we'll add one button & a logo. The button takes us to the list of shops.
7. The list of Shops will show in the upper 50% screen a map with one pin for each shop.
8. The list of Shops will show in the lower 50% screen. Logo to the left, background image taking all the row, shop name in the front. Tapping a row takes us to the detail shop screen.
9. All info should be read from a Core Data database.
10. If you tap on a pin in the map a callout will open with the logo + shop name. Taping the callout takes us to the detail shop screen.
11. The map will be always centered in madrid, showing also the user location.
12. All data is at least in Spanish & English: should cache all and display in Spanish (if that's our phone's language) or English otherwise
13. Shop detail screen should show shop name, description, address, and a map showing the shops's location without any pin.


# Web services

## Activities

> GET http://madrid-shops.com/json_new/getActivities.php

## Shops

> GET http://madrid-shops.com/json_new/getShops.php


# MadridShops Repository

[MadridShops](https://github.com/TheHandyOwl/MadridShops "MadridShops")
