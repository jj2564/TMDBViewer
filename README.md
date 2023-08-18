# Application


## How to use?

請先在 `Environment_DEV` & `Enviornment_PROD` 填寫 TMDB 的 Access Token
正常情況下不會採用這種方式來放置Token，現階段暫無製作登入取得Token的計畫，因此先採用此種方式來進行。

請透過 
```
/src/Application/Application.xcworkspace
```
來執行專案，本專案並無使用 `cocoapod` or `carthage` 等等的開發輔助工具，請正常的使用 `Xcode 14` 以上的版本進行開啟執行即可。


## Environment Intro

這是一個基礎的專案，可以用於快速建立一個專案的起始。
專案主程式放置於 

``` /src/Application ```

請先前往下述路徑有兩個 `xcconfig` ，分別提供 DEV & PROD 兩種環境變數，且會對應`Build scheme`做連動。

``` /src/Application/Application/Resources ``` 


---

本專案不使用 Storyboard 進行開發因此將相關設定移除，另外本專案也移除了`SceneDelegate`，如有需求可參考[網誌](https://medium.com/@jj2564/swift-紀錄-4-不使用storyboard開發的專案設定-d6c654db1cab)進行添加。

順便建置了我一直想要做的基礎專案設定
最終希望能夠把相關的 `framework` 都製成 `SwfitPackage` 這樣就能大幅縮短初始專案建置的時間。
應該也能節省編譯的時間。

---

在  `Application.workspace` 中我們可以看到有
> 01.Application
>> 用來放置與此 App 有關的 `Domain` 
>
> 02.Infrastructure
>> 用來放通用型的服務，如 `HttpClient`、`DataStorage`、`Logging`、`Identity`、`Security` 或是專案的 `Configuration`，不過還在思考與建製中，雖然目前工作上有在使用，但是並不是我個人期望的最終版本。


## TMDB Application Intro

圖片icon來自於[網路素材](https://iconscout.com/icon/the-movie-database-3627833)，採 1024x1024px 的 single size 。

同常完整的專案我會再建立一個 `Application.Core` 在 `01.Application` 用來放置專屬於這個 App 的相關設定，可能根據環境變化的網址(ex. DEV, STAGE, PROD)，或是一些引導ContextFactory的設置，但本專案功能較侷限因此採較迅速可以建立專案的方式來進行。

### NowPlaying

```
~/NowPlaying/NowPlayingViewController
```

會去偵測即將滑到底部的時候會去呼叫更多的資料回來實現可以一直瀏覽的效果，理應要加一個loading在footer，受限於時間先空下這塊。

MovieCardView的部分，沒有完全展現Summary，希望能讓使用者點選進去看詳細內容。

本頁面沒有製作讀取中的框架，因本頁尚未確定資料狀態我認為較不適合，再之後的`我的收藏`因資料庫中已儲存已知數量的movieId，故可先製成框架。



