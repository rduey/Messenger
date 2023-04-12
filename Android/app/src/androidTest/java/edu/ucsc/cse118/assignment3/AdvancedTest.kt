package edu.ucsc.cse118.assignment3

import androidx.test.ext.junit.rules.ActivityScenarioRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.filters.LargeTest
import com.adevinta.android.barista.interaction.BaristaClickInteractions.clickOn
import com.adevinta.android.barista.interaction.BaristaEditTextInteractions.typeTo
import edu.ucsc.cse118.assignment3.TestHelper.waitForText

import org.junit.Test
import org.junit.Rule
import org.junit.runner.RunWith
import kotlin.random.Random

@RunWith(AndroidJUnit4::class)
@LargeTest
class AdvancedTest {
    /**
     * Create and launch the activity under test before each test,
     * and close it after each test.
     */
    @get:Rule
    var activityScenarioRule = ActivityScenarioRule(MainActivity::class.java)

    // TEST ID
    private val id = 3

    private fun login() {
        typeTo(R.id.email, "email@email.com")
        typeTo(R.id.password, "password")
        clickOn("LOGIN")
    }

    private fun construction(channel: String) {
        login()
        waitForText("Construction")
        clickOn("Construction")
        waitForText(channel)
        clickOn(channel)
    }
    private fun movies(channel: String) {
        login()
        waitForText("Movies")
        clickOn("Movies")
        waitForText(channel)
        clickOn(channel)
    }
    private fun add_message(message: String) {
        clickOn(R.id.fab)
        typeTo(R.id.content, message)
        clickOn("ADD")
    }
    private fun test_message() {
        add_message("this is an automated test (id: $id)")
        waitForText("this is an automated test (id: $id)")
    }

    @Test
    fun add_message_rebar() {
        construction("Rebar & Wire Mesh Install")
        test_message()
    }
    @Test
    fun add_message_framing() {
        construction("Framing (Wood)")
        test_message()
    }
    @Test
    fun add_message_masonry() {
        construction("Masonry")
        test_message()
    }
    @Test
    fun add_message_drywall() {
        construction("Drywall")
        test_message()
    }
    @Test
    fun add_message_electrical() {
        construction("Electrical")
        test_message()
    }
    @Test
    fun add_message_asphalt() {
        construction("Asphalt Paving")
        test_message()
    }
    @Test
    fun add_message_doors() {
        construction("Doors, Frames & Hardware")
        test_message()
    }
    @Test
    fun add_message_roofing() {
        construction("Roofing (Metal)")
        test_message()
    }

    @Test
    fun add_message_documentary() {
        movies("Documentary")
        test_message()
    }
    @Test
    fun add_message_romance() {
        movies("Romance")
        test_message()
    }
    @Test
    fun add_message_Drama() {
        movies("Drama")
        test_message()
    }

}