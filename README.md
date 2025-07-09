# 🎉 Baby Birthday App

## ✨ Features

- 🎂 **Details Screen**  
  - Enter baby's name and birthday  
  - Add photo (from camera or photo library)  
  - Data persists across launches
  - UI here is basic just default elements(as instructed)

- 🎉 **Birthday Screen**  
  - Displays a randomly selected celebratory design  
  - Automatically calculates baby's age (months < 1y, years ≥ 1y)  
  - Shows number using image assets  
  - Handles long names, missing images gracefully  
  - Shareable via iOS share sheet (UI trimmed for shared image)
  - UI made very close to example

## 📁 Architecture

Follows a simple **MVP (Model-View-Presenter)** architecture:
- `ViewController` handles UI
- `Presenter` handles logic
- `Model` (`BabyInfo`) holds the data

## 🛠 Requirements

- iOS 15.0+
- Swift
- Xcode 14+

## 🚀 Run

1. Clone the repo
2. Open `BabyBirthday.xcodeproj`
3. Run on simulator or device

## 📌 Notes

- UI built entirely using **Interface Builder (IB)**(with some exceptions for calculated elemetents for bonus points)
