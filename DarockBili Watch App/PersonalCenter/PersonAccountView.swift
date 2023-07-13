//
//  PersonAccountView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

import SwiftUI
import DarockKit
import Alamofire
import SwiftyJSON
import SDWebImageSwiftUI

struct PersonAccountView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var isLoginPresented = false
    @State var username = ""
    @State var userSign = ""
    @State var userFaceUrl = ""
    @State var isLogoutAlertPresented = false
    @State var isUserDetailSelfPresented = false
    @State var isNetworkFixPresented = false
    var body: some View {
        NavigationStack {
            List {
                //VStack {
                    if sessdata == "" {
                        Button(action: {
                            isLoginPresented = true
                        }, label: {
                            Text("点击登录")
                        })
                        .sheet(isPresented: $isLoginPresented, content: {LoginView()})
                    } else {
                        VStack {
                            NavigationLink("", isActive: $isUserDetailSelfPresented, destination: {UserDetailView(uid: dedeUserID)})
                                .frame(width: 0, height: 0)
                            HStack {
                                if userFaceUrl != "" {
                                    WebImage(url: URL(string: userFaceUrl + "@28w"), options: [.progressiveLoad])
                                        .cornerRadius(.infinity)
                                } else {
                                    Image("Placeholder")
                                        .resizable()
                                        .frame(width: 28, height: 28)
                                        .redacted(reason: .placeholder)
                                        .cornerRadius(100)
                                }
                                VStack {
                                    if username != "" {
                                        Text(username)
                                            .font(.system(size: 15))
                                    } else {
                                        Text("Jst Placeholder")
                                            .font(.system(size: 15))
                                            .redacted(reason: .placeholder)
                                    }
                                }
                            }
                            .onTapGesture {
                                isUserDetailSelfPresented = true
                            }
                        }
                            Group {
                                Section {
                                    NavigationLink(destination: {FollowListView(viewUserId: dedeUserID)}, label: {
                                        HStack {
                                            HStack {
                                                Image(systemName: "person.2.fill")
                                                    .foregroundColor(.accentColor)
                                                    .offset(x: -3)
                                                Text("我的好友")
                                                    .offset(x: -6)
                                            }
                                            .font(.system(size: 16))
                                            Spacer()
                                        }
                                    })
                                    .buttonBorderShape(.roundedRectangle(radius: 13))
                                    NavigationLink(destination: {DownloadsView()}, label: {
                                        HStack {
                                            HStack {
                                                Image(systemName: "square.and.arrow.down.fill")
                                                    .foregroundColor(.accentColor)
                                                Text("离线缓存")
                                            }
                                            .font(.system(size: 16))
                                            Spacer()
                                        }
                                    })
                                    .buttonBorderShape(.roundedRectangle(radius: 13))
                                    NavigationLink(destination: {HistoryView()}, label: {
                                        HStack {
                                            HStack {
                                                Image(systemName: "clock.arrow.circlepath")
                                                    .foregroundColor(.accentColor)
                                                Text("历史记录")
                                            }
                                            .font(.system(size: 16))
                                            Spacer()
                                        }
                                    })
                                    .buttonBorderShape(.roundedRectangle(radius: 13))
                                    NavigationLink(destination: {FavoriteView()}, label: {
                                        HStack {
                                            HStack {
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.accentColor)
                                                Text("我的收藏")
                                            }
                                            .font(.system(size: 16))
                                            Spacer()
                                        }
                                    })
                                    .buttonBorderShape(.roundedRectangle(radius: 13))
                                    NavigationLink(destination: {WatchLaterView()}, label: {
                                        HStack {
                                            HStack {
                                                Image(systemName: "memories")
                                                    .foregroundColor(.accentColor)
                                                Text("稍后再看")
                                            }
                                            .font(.system(size: 16))
                                            Spacer()
                                        }
                                    })
                                    .buttonBorderShape(.roundedRectangle(radius: 13))
                                }
                                
                            }
                            .navigationTitle("我的")
                            .navigationBarTitleDisplayMode(.large)
                            .toolbar {
                                ToolbarItem(placement: .topBarLeading) {
                                    NavigationLink(destination: {SettingsView()}, label: {
                                        Image(systemName: "gear")
                                            .foregroundColor(.accentColor)
                                    })
                                }
                            }
                        .onAppear {
                            let headers: HTTPHeaders = [
                                "cookie": "SESSDATA=\(sessdata);"
                            ]
                            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/member/web/account", headers: headers) { respJson, isSuccess in
                                if isSuccess {
                                    username = respJson["data"]["uname"].string!
                                    userSign = respJson["data"]["sign"].string!
                                } else {
                                    isNetworkFixPresented = true
                                }
                            }
                            DarockKit.Network.shared.requestString("https://api.darock.top/bili/wbi/sign/\("mid=\(dedeUserID)".base64Encoded())") { respStr, isSuccess in
                                if isSuccess {
                                    debugPrint(respStr.apiFixed())
                                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/space/wbi/acc/info?\(respStr.apiFixed())", headers: headers) { respJson, isSuccess in
                                        if isSuccess {
                                            debugPrint(respJson)
                                            userFaceUrl = respJson["data"]["face"].string!
                                        } else {
                                            isNetworkFixPresented = true
                                        }
                                    }
                                } else {
                                    isNetworkFixPresented = true
                                }
                            }
                        }
                        .sheet(isPresented: $isNetworkFixPresented, content: {NetworkFixView()})
                    }
                //}
            }
        }
    }
}

struct PersonAccountView_Previews: PreviewProvider {
    static var previews: some View {
        PersonAccountView()
    }
}

func mainColors(image:UIImage, detail: Int) -> [UIColor] {
            //COLOR PROCESS STEP 1:
            //Determine the detail.
                var dimension = 10
                var flexibility = 2
                var range = 60

        //Low detail.
            if detail == 0 {
                dimension = 4
                flexibility = 1
                range = 100
            }
        //High detail.
            else if detail == 2 {
                dimension = 100
                flexibility = 10
                range = 20
            }

        //COLOR PROCESS STEP 2:
        //Determine the colors in the image.

        //Create an array to store the colors.
            var colors = Array<Array<CGFloat>>()

        //Get the bitmap data of the image.
            let imageRef = image.cgImage
        //Variable to store the color space, RGB in this case.
            let colorSpace = CGColorSpaceCreateDeviceRGB()
        //Additional CGContext data.
            let bytesPerPixel = 4
            let bytesPerRow = bytesPerPixel * dimension
            let bitsPerComponent = 8
        //Create the context. Data uses the memory pointer created above, the width and height determine the dimensions of the bitmap, the space is for the colorspace, the bitmap specifies the alpha channel.
            let context = CGContext(data: nil, width: dimension, height: dimension, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue)!
        //Draw the image.
            let rect = CGRect(x: 0, y: 0, width: dimension, height: dimension)
            context.draw(imageRef!, in: rect)

        //Iterate through the raw data in order to create a UIColor.
            var x = 0
            var y = 0

            for _ in 0..<(dimension * dimension) {
                let index = (bytesPerRow * y) + x * bytesPerPixel
                let red = CGFloat(index)
                let green = CGFloat(index + 1)
                let blue = CGFloat(index + 2)
                let alpha = CGFloat(index + 3)

                let color = [red, green, blue, alpha]
                colors.append(color)

                y += 1
                if y == dimension {
                    y = 0
                    x += 1
                }
            }

        //Deallocate the mutable pointer.
            //free(rawData)

        //COLOR PROCESS STEP 3:
        //Add some color flexibility.

        //Create an array containing the previous colored items and create another one for the flexible colors.
            var copiedColors = colors
            var flexibleColors = Array<String>()

        //Iterate through the copied colors in order to create an improved UIColor.
            let flexFactor = flexibility * 2 + 1
            let factor = flexFactor * flexFactor * 3

            for n in 0..<(dimension * dimension) {
                let pixelColors = copiedColors[n]

                var reds = Array<CGFloat>()
                var greens = Array<CGFloat>()
                var blues = Array<CGFloat>()

                for p in 0..<3 {
                    let rgb = pixelColors[p]

                    for f in -flexibility...flexibility {
                        var newRGB = rgb + CGFloat(f)

                        if newRGB < 0 {
                            newRGB = 0
                        }

                        switch p {
                            case 0:
                                reds.append(newRGB)
                            case 1:
                                greens.append(newRGB)
                            case 2:
                                blues.append(newRGB)
                            default:
                                print("Error! Loop out of range! \(p)")
                        }
                    }
                }

                var r = 0
                var g = 0
                var b = 0

                for _ in 0..<factor {
                    let red = reds[r]
                    let green = greens[g]
                    let blue = blues[b]

                    let rgbString = "\(red),\(green),\(blue)"
                    flexibleColors.append(rgbString)

                    b += 1
                    if b == flexFactor {
                        b = 0
                        g += 1
                    }
                    if g == flexFactor {
                        g = 0
                        r += 1
                    }
                }
            }

        //COLOR PROCESS STEP 4:
        //Distinguish the colors. Orders the flexible colors by their occurence and then keeps them if they are sufficiently disimilar.

        //Dictionary to store all the colors.
            let colorCounter = NSMutableDictionary()

        //Check the number of times item is in array.
            let countedSet = NSCountedSet(array: flexibleColors)

            for item in countedSet {
                let item = item as! String

                let count = countedSet.count(for: item)
                let value = NSNumber(integerLiteral: count)
                colorCounter.setValue(value, forKey: item)
            }

        //Sort keys from highest occurence to lowest.
            let orderedKeys = colorCounter.keysSortedByValue(comparator: {
                (obj1, obj2) in
                let x = obj1 as! NSNumber
                let y = obj2 as! NSNumber
                return x.compare(y)
            })

        //Check if the color is similar to another one already included.
            var ranges = Array<String>()

            for key in orderedKeys as! [String] {
                let rgb = key.components(separatedBy: ",")
                let r = NSString(string: rgb[0]).integerValue
                let g = NSString(string: rgb[1]).integerValue
                let b = NSString(string: rgb[2]).integerValue

                var exclude = false

                for rangedkey in ranges {
                    let rangedRGB = rangedkey.components(separatedBy: ",")

                    let ranged_r = NSString(string: rangedRGB[0]).integerValue
                    let ranged_g = NSString(string: rangedRGB[1]).integerValue
                    let ranged_b = NSString(string: rangedRGB[2]).integerValue

                    if r >= ranged_r - range && r <= ranged_r + range {
                        if g >= ranged_g - range && g <= ranged_g + range {
                            if b >= ranged_b - range && b <= ranged_b + range {
                                exclude = true
                            }
                        }
                    }
                }

                if exclude == false {
                    ranges.append(key)
                }
            }

        //Create the colors and fill them.
            var mainColors = Array<UIColor>()

            for key in ranges {
                let rgb = key.components(separatedBy: ",")
                let r = NSString(string: rgb[0]).floatValue
                let g = NSString(string: rgb[1]).floatValue
                let b = NSString(string: rgb[2]).floatValue

                let finalColor = UIColor(red: CGFloat((r / 255)), green: CGFloat((g / 255)), blue: CGFloat((b / 255)), alpha: CGFloat(1.0))

                mainColors.append(finalColor)
            }

            return mainColors
    }
