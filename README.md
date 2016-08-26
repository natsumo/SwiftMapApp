# 【iOS Swift】地図アプリを作ろう！
![画像001](/readme-img/001.png)

## 概要
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)(通称mBaaS)の『位置情報検索』機能を利用して、「現在地情報（緯度経度）をクラウドに保存する・保存したデータを取得して地図に表示する」内容を実装したサンプルプロジェクトです
* 簡単な操作ですぐに [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の機能を体験いただけます★☆

## ニフティクラウドmobile backendって何？？
スマートフォンアプリのバックエンド機能（プッシュ通知・データストア・会員管理・ファイルストア・SNS連携・位置情報検索・スクリプト）が**開発不要**、しかも基本**無料**(注1)で使えるクラウドサービス！

注1：詳しくは[こちら](http://mb.cloud.nifty.com/price.htm)をご覧ください

![画像002](/readme-img/002.png)

## 事前準備
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のアカウントの取得（無料登録）
* Googleアカウント（gmailアカウント）の取得

## 動作環境
※下記内容で動作確認をしています

* Mac OS X 10.10.5(Yosemite)
* Xcode ver. 7.2.1
* iPhone6 ver. 8.2
* iPad mini ver.9.2
 * このサンプルアプリは、端末の位置情報を使用するため、実機ビルドが必要です

## サンプルアプリ概要と使い方

![画像005](/readme-img/005.png)

* 端末の位置情報を許可すると、位置情報の取得が開始されます
 * 起動時、地図は新宿駅を中心として表示されます
 * 現在地を表示するには、地図の現在地ボタンをタップします
* 取得した位置情報（現在地）は右上の「保存」をタップすることでmBaaSに保存できます
 * 位置情報にタイトル・コメントをつけて保存が可能です
* 保存した位置情報は地図上に青いマーカーで表示されます
* また、「保存した場所をみる」ボタンをタップすると、既存お店情報と追加で保存した位置情報を地図に表示することができます
 * 全件検索・現在地から半径5km以内、1km以内の円形検索・新宿駅と西新宿駅の間の矩形検索が可能です

![画像012](/readme-img/012.png)

* 事前にインポートしたお店とニフティ株式会社の位置情報を右下のボタンをタップすることで地図に表示可能です
* 表示したマーカーを消す場合は左下のゴミ箱ボタンをタップします


## サンプルアプリビルドまでの流れ

1. サンプルプロジェクトのダウンロード
1. CocoapodsでmBaaS SDKとGoogle Map SDKのインストール
1. mBaaSでアプリ作成とAPIキーの発行
1. mBaaSにお店データとアイコン画像をインポート
1. Google Cloud platform でプロジェクトの作成とAPIキーの発行、Google Maps SDK for iOS の許可
1. mBaaSとGoogle Map 双方のAPIキーを設定
1. 実機ビルドして動作確認

## 作業手順

### 1. サンプルプロジェクトのダウンロード

下記リンクをクリックしてサンプルプロジェクトをダウンロードします▼

　　　　　[__SwiftMapApp__](https://github.com/natsumo/SwiftMapApp/archive/master.zip)

* フォルダを確認します

![画像010](/readme-img/010.png)

### 2. CocoapodsでmBaaS SDKとGoogle Map SDKのインストール

* ダウンロードしたフォルダ内にある「SwiftMapApp.xcodeproj」と同じディレクトリにターミナル上で移動します
 * 注意：これをやっておかないと失敗します！

```bash
$ cd [指定ディレクトリ]
```

* CocoaPodsを「はじめて使う場合」→ CocoaPodsをインストールする

```bash
$ sudo gem install cocoapods
```

* CocoaPodsを「既にインストールしている場合」→CocoaPodsのバージョンアップをする

```bash
$ sudo gem update --system
```

* インストールが初めての場合あるいは、アップグレードして最初の起動の場合はセットアップをする

```bash
$ pod setup
```

* バージョン確認をします
 * 最新バージョンが確認できれば準備OKです

```bash
$ pod --version
```

* 既存のPodfileにそれぞれのSDKをインストールする内容が記載してあります
* Podfileの内容をインストールして、「workspace」を作成します

```bash
$ pod install --no-repo-update
```

* フォルダを確認します
 * 下記のように、「Podfile.lock」ファイル, 「Pods」フォルダと「SwiftMapApp.xcworkspace」の３点が増えていることが確認できればOKです

![画像011](/readme-img/011.png)

### 3. [mBaaS](http://mb.cloud.nifty.com/)でアプリ作成とAPIキーの発行

* ログイン後、下図のように「アプリの新規作成」画面が表示されるのでアプリを作成します

![画像003](/readme-img/003.png)

* アプリ作成されると下図のような画面になります
* この２種類のAPIキー（アプリケーションキーとクライアントキー）はXcodeで作成するiOSアプリに[mBaaS](http://mb.cloud.nifty.com/)を紐付けるために使用します

![画像004](/readme-img/004.png)

### 4. [mBaaS](http://mb.cloud.nifty.com/)にお店データとアイコン画像をインポート

* ダウンロードしたプロジェクトフォルダ内にある「setting」フォルダ内のデータをmBaaSにインポートします

![画像013](/readme-img/013.png)

* まず「Shop.json」をインポートして、mBaaSのデータストアにお店情報を保存します

![画像008](/readme-img/008.png)

※クラス名に「Shop」（"S"は大文字）を指定していない場合、アプリからデータを読み込めませんのでご注意ください！

* 下記のように５つのお店が登録されます

![画像009](/readme-img/009.png)

※ここで使用しているデータはデモのために作成した架空のもので、位置情報等も実在するお店とは関係ありませんので、ご了承ください。

* 次に「image」フォルダ内にあるアイコン画像をファイルストアにインポートします
 * まとめてアップロードすることが可能です

![画像015](/readme-img/015.png)

* 下記のように５つのお店のアイコンとmBaaSのアイコンが登録されます

![画像016](/readme-img/016.png)

### 5. [Google Cloud platform](https://console.cloud.google.com/)でプロジェクトの作成とAPIキーの発行、Google Maps SDK for iOS の許可

*  [Google Cloud platform](https://console.cloud.google.com/)にログインします
* プリジェクトを作成します
 * プロジェクト名は任意で作成します　例）MapApp

![画像GCP001](/readme-img/GCP001.png)

* GoogleAPI呼び出し用のAPIキーを作成します

![画像GCP002](/readme-img/GCP002.png)
![画像GCP003](/readme-img/GCP003.png)
![画像GCP004](/readme-img/GCP004.png)

* Google Maps SDK for iOSを有効にします

![画像GCP005](/readme-img/GCP005.png)

### 6. mBaaSとGoogle Map 双方のAPIキーを設定
* 「SwiftMapApp.xcworkspace」をダブルクリックしてXcodeを起動します

![画像014](/readme-img/014.png)

* プロジェクトが開いたら、`AppDelegate.swift`を編集します
* 先程[mBaaS](http://mb.cloud.nifty.com/)のダッシュボード上で確認したAPIキーと[Google Cloud platform](https://console.cloud.google.com/)で発行したAPIキーを貼り付けます

![画像007](/readme-img/007.png)

* それぞれ`YOUR_NCMB_APPLICATION_KEY`と`YOUR_NCMB_CLIENT_KEY`の部分を書き換えます
 * このとき、ダブルクォーテーション（`"`）を消さないように注意してください！
* 書き換え終わったら`command + s`キーで保存をします

### 7. 実機ビルドして動作確認

* lightningケーブルで動作確認用端末をMacにつなぎます
 * 実機ビルドが初めての場合は[こちら](http://qiita.com/natsumo/items/3f1dd0e7f5471bd4b7d9)をご覧いただき、実機ビルドの準備をお願いします
* Xcode画面で左上で、接続したiPhoneを選び、実行ボタン（さんかくの再生マーク）をクリックします

※__ビルド時にエラーが発生した場合の対処方法__：Xcodeのバージョンが古い場合`import NCMB`にエラーが発生し、上手くSDKが読み込めないことがあります。その場合はXcodeのバージョンアップをお願いします。

* アプリが起動したら、アプリ位置情報を許可します
* 現在地の緯度経度と新宿駅を中心とした地図が表示されます
* 現在地ボタンをタップすると現在地が表示されます

![画像017](/readme-img/017.png)

* 右上の「保存」ボタンをタップすると位置情報の保存ができます
* タイトルとコメントを記入するアラートが表示されますので、入力し「保存」をタップします

![画像018](/readme-img/018.png)

* mBaaSに位置情報とタイトル・コメントが保存され、画面にマーカーが表示されます
 * マーカーをタップするとタイトル・コメントが表示されます

-----

* 保存に成功したら、[mBaaS](http://mb.cloud.nifty.com/)のダッシュボードから保存先の「データストア」を確認してみましょう！
* 新しく「GeoPoint」クラスが作成され、その中にデータが保存されていることを確認できます
 * 下の例は、タイトルに「和食」、コメントに「ワンコインで食べられる！」と入れた場合です

![画像019](/readme-img/019.png)

* 簡単に位置情報がクラウドに保存できました☆★
* 他、保存した情報は「保存した場所をみる」ボタンで表示可能ですので触ってみてください！

## 解説
サンプルプロジェクトに実装済みの内容のご紹介

### mBaaSの初期設定
* SDKの詳しい導入方法は、mBaaS の[ドキュメント（クイックスタート）](http://mb.cloud.nifty.com/doc/current/introduction/quickstart_ios.html)をSwift版に書き換えたドキュメントをご用意していますので、ご活用ください

　　　　　__[【Swift版】ドキュメント（クイックスタート）](https://github.com/NIFTYCloud-mbaas/NCMB_SwiftQuickStart)__


* SDKの読み込みは下記のコードで行っています
```swift
import NCMB
```
* SDKの初期化は下記のコードで行っています
```swift
// mBaaS APIkey
let applicationkey = "YOUR_NCMB_APPLICATIONKEY"
let clientkey = "YOUR_NCMB_CLIENTKEY"
// mBaaS初期化
NCMB.setApplicationKey(applicationkey, clientKey: clientkey)
```
※「`YOUR_NCMB_APPLICATIONKEY`」と「`YOUR_NCMB_CLIENTKEY`」は、mBaaSのダッシュボードで発行したAPIキーに置き換えます

### Google Map を表示するための初期設定

* SDKの詳しい導入方法は、[Google Maps API](https://developers.google.com/maps/)のiOS向け（Maps SDK for iOS）__[スタートガイド](https://developers.google.com/maps/documentation/ios-sdk/start)__（日本語）をご活用ください

* SDKの読み込みは下記のコードで行っています
```swift
import GoogleMaps
```
* SDKの初期化は下記のコードで行っています
```swift
// Google Maps APIkey
let googleMapsAPIkey = "YOUR_GOOGLE_MAPS_APIKEY"
// GoogleMaps初期化
GMSServices.provideAPIKey(googleMapsAPIkey)
```
※「`YOUR_GOOGLE_MAPS_APIKEY`」は、Google Cloud Platformのダッシュボードで発行したAPIキーに置き換えます

### 位置情報取得のための設定

* `CoreLocation.framework`を追加をし、ViewcControllerで読み込みをしています


```swift
import CoreLocation
```

* `Info.plist`に`NSLocationWhenInUseUsageDescription`を追記しています
 * Valueは任意の文字列が設定でき、位置情報許可アラート画面に表示されるものです

![画像020](/readme-img/020.png)


※コードの場合は`<dict>~</dict>`内に下記を追記

```
<key>NSLocationWhenInUseUsageDescription</key>
<string>Location Demo</string>
```

### ロジックの紹介
* `Main.storyboard`でデザインを作成し、`ViewController.swift`にロジックを書いています
* mBaaSに位置情報を保存するコードと取得するコードについて抜粋して紹介します

#### 位置情報の保存・取得

* 位置情報の保存

```swift
 /** 【mBaaS：データストア】位置情報の保存 **/
 // NCMBGeoPointの生成
let geoPoint = NCMBGeoPoint(latitude: atof(lat), longitude: atof(lon))
// NCMBObjectを生成
let object = NCMBObject(className: "GeoPoint")
// 値を設定
object.setObject(geoPoint, forKey: "geolocation")
object.setObject(title, forKey: "title")
object.setObject(snippet, forKey: "snippet")
// 保存の実施
object.saveInBackgroundWithBlock { (error: NSError!) -> Void in
    if error != nil {
        // 位置情報保存失敗時の処理

     } else {
         // 位置情報保存成功時の処理

    }
}
```

#### 位置情報取得

* 全件検索（検索条件なし）の場合

```swift
/** 【mBaaS：データストア(位置情報)】 保存データの取得 **/
// クラスの検索クエリを作成
let queryGeoPoint = NCMBQuery(className: "GeoPoint")
// データストアを検索
queryGeoPoint.findObjectsInBackgroundWithBlock({ (objects: Array!, error: NSError!) -> Void in
    if error != nil {
        // 検索失敗時の処理

    } else {
        // 検索成功時の処理

    }
})
```

* 検索条件ありの場合
 * それぞれ以下のように検索条件を追加しています

__＜円形検索＞__

```swift
// 現在地から半径5km以内に該当する位置情報を検索
queryGeoPoint.whereKey("geolocation", nearGeoPoint: geoPoint, withinKilometers: 5.0)

```

__＜矩形検索＞__
```swift
// 新宿駅と西新宿駅の間
queryGeoPoint.whereKey("geolocation", withinGeoBoxFromSouthwest: shinjukuGeoPoint, toNortheast: westShinjukuGeoPoint)
```

## 参考
* mBaaS(iOS)の[ドキュメント](http://mb.cloud.nifty.com/doc/current/#/iOS)
* Google MAps for iOS の[ドキュメント](https://developers.google.com/maps/documentation/ios-sdk/start)
* 同じ内容の【Objective-C】版もご用意しています
 * https://github.com/natsumo/ObjcMapApp
