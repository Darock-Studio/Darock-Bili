# CI Docs
What is CI? It means *Continuous integration*. Speak in easily, this is a machine that can compiling and more.

CI Darock using is from Github Actions and XCode Cloud. Xcode Cloud's call is automatic, and you cannot call it manually. So this docs is mainly introduce Github Actions.
## Call
You can commit under Pull Request to call CI.
### compileable Check
 All Pull Requests need to pass compileable check before it merge to **main** branch. This operation is complete by CI.

Send `!Run check` to perform compileable check workflow.
### Export IPA
 You can export an signed IPA through CI in roder for test. However, you cannot distribute it.

Send `!Export IPA` to perform Export IPA workflow.
### Upload to TestFlight
You can compile and upload a branch to Testflight through CI in order for test. However, you cannot use it for distribution.

**This workflow will cause whole project build number +1**

Send `!Deploy TF` to perform upload workflow.
## View Status
As soon as workflow started, you can find status under pull request or Actions page.

In Actions' **Summary** page, if this operation include file (e.g. `Export IPA`), you can get attachment below.
