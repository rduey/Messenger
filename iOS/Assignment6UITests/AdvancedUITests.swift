import XCTest

final class AdvancedUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    private func waitFor(_ element : XCUIElement, timeout: Double = 5.0) -> XCUIElement{
        let expectation = expectation(
            for: NSPredicate(format: "exists == true"),
            evaluatedWith: element,
            handler: .none
        )
        let _ = XCTWaiter.wait(for: [expectation], timeout: timeout)
        return element
    }
    
    private func login(_ email: String = "email@email.com", passwd: String = "password") {
        let email = app.textFields["EMail"]
        email.tap()
        email.typeText(email)
        let password = app.secureTextFields["Password"]
        password.tap()
        password.typeText(passwd)
        app.buttons["Login"].tap()
    }
    
    private func find(string: String) {
        var count = 0
        while(!app.staticTexts[string].exists) {
            app.swipeUp()
            if (count == 10) { break }
            count += 1
        }
    }
    
    func testAddWorkspaceCancel() {
        login()
        app.navigationBars["Workspaces"].buttons["New Workspace"].tap()
        let name = app.textFields["Name"]
        name.tap()
        name.typeText("Cancelled Workspace")
        app.buttons["Cancel"].tap()
        XCTAssert(app.staticTexts["Testing Workspace"].waitForExistence(timeout: 5))
        XCTAssertFalse(app.staticTexts["Cancelled Workspace"].exists)
    }
    
    func testDeleteWorkspace() throws {
        login()
        app.navigationBars["Workspaces"].buttons["New Workspace"].tap()
        let name = app.textFields["Name"]
        name.tap()
        name.typeText("Workspace for Deletion")
        app.buttons["OK"].tap()
        XCTAssert(app.staticTexts["Workspace for Deletion"].waitForExistence(timeout: 5))
        app.staticTexts["Workspace for Deletion"].swipeLeft()
        app.buttons["Delete"].tap()
        XCTAssertFalse(app.staticTexts["Workspace for Deletion"].exists)
    }
    
    func testDeleteChannel() throws {
        login()
        waitFor(app.collectionViews.buttons["Testing Workspace"]).tap()
        app.navigationBars["Testing Workspace"].buttons["New Channel"].tap()
        let name = app.textFields["Name"]
        name.tap()
        name.typeText("Channel for Deletion")
        app.buttons["OK"].tap()
        XCTAssert(app.staticTexts["Channel for Deletion"].waitForExistence(timeout: 5))
        app.staticTexts["Channel for Deletion"].swipeLeft()
        app.buttons["Delete"].tap()
        XCTAssertFalse(app.staticTexts["Channel for Deletion"].exists)
    }
    
    func testAddMember() {
        login()
        waitFor(app.collectionViews.buttons["Testing Workspace"]).tap()
        app.navigationBars["Testing Workspace"].buttons["Add Members"].tap()
        app.navigationBars["Members"].buttons["Add Member"].tap()
        find(string: "Molly Member")
        app.staticTexts["Molly Member"].swipeLeft()
        app.buttons["Add"].tap()
        app.navigationBars["Members"].buttons["Members"].tap()
        XCTAssert(app.staticTexts["Molly Member"].waitForExistence(timeout: 5))
        app.staticTexts["Molly Member"].swipeLeft()
        app.buttons["Delete"].tap()
        XCTAssertFalse(app.staticTexts["Molly Member"].exists)
    }
}
