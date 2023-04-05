package edu.ucsc.cse118.assignment3.repo
/*
 * Resources:
 * https://docs.oracle.com/javase/7/docs/api/java/net/HttpURLConnection.html
 */
import com.google.android.material.snackbar.Snackbar
import edu.ucsc.cse118.assignment3.data.*
import edu.ucsc.cse118.assignment3.data.Member
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.URL
import javax.net.ssl.HttpsURLConnection

class MessageRepository {

  fun getAll(member: Member?, channel: Channel?): ArrayList<Message> {
    val path = "$url/channel/${channel?.id}"
    with(URL(path).openConnection() as HttpsURLConnection) {
      requestMethod = "GET"
      setRequestProperty("Content-Type", "text/html; charset=UTF-8n")
      setRequestProperty("Accept", "application/json")
      setRequestProperty("Authorization", "Bearer ${member?.accessToken}")
      val response = StringBuffer()
      BufferedReader(InputStreamReader(inputStream)).use {
        var inputLine = it.readLine()
        while (inputLine != null) {
          response.append(inputLine)
          inputLine = it.readLine()
        }
        it.close()
      }
      if (responseCode == HttpsURLConnection.HTTP_OK) {
        return Json.decodeFromString(response.toString())
      }
      throw Exception("Failed to GET HTTP $responseCode")
    }
  }

  fun addOne(member: Member?, channel: Channel?, message: Message?): Message {
    val path = "$url/message/${channel?.id}"
    with(URL(path).openConnection() as HttpsURLConnection) {
      requestMethod = "POST"
      setRequestProperty("Content-Type", "application/json")
      setRequestProperty("Accept", "application/json")
      setRequestProperty("Authorization", "Bearer ${member?.accessToken}")
      val contentString = "{\n  \"content\": \"${message?.content}\"\n}"
      //outputStream.write(Json.encodeToString(message?.content).toByteArray())
      outputStream.write(contentString.toByteArray())
      if (responseCode == HttpsURLConnection.HTTP_CREATED) {
        return Json.decodeFromString(inputStream.bufferedReader().use { it.readText() })
      }
      if (responseCode == HttpsURLConnection.HTTP_CONFLICT) {
        throw Exception("Message with id ${message?.id} exists!")
      }
      throw Exception("Failed to PUT HTTP $responseCode")
    }
  }

  fun deleteOne(member: Member?, message: Message?) {
    val path = "$url/message/${message?.id}"
    with(URL(path).openConnection() as HttpsURLConnection) {
      requestMethod = "DELETE"
      //setRequestProperty("Content-Type", "application/json")
      //setRequestProperty("Accept", "application/json")
      setRequestProperty("Authorization", "Bearer ${member?.accessToken}")
      //val contentString = "{\n  \"content\": \"${message?.content}\"\n}"
      //outputStream.write(Json.encodeToString(message?.content).toByteArray())
      if (responseCode == HttpsURLConnection.HTTP_OK) {
        return //Json.decodeFromString(inputStream.bufferedReader().use { it.readText() })
      }
      if (responseCode == HttpsURLConnection.HTTP_NOT_FOUND) {
        throw Exception("Message with id ${message?.id} does not exist!")
      }
      throw Exception("Failed to PUT HTTP $responseCode")
    }
  }

  companion object {
    private const val url = "https://cse118.com/api/v0"
  }
}