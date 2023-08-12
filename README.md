# Application


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


## {NEW PROJECT} Intro
