package edu.ucsc.cse118.assignment3.ui.channel

/*
 * Resources:
 * https://developer.android.com/reference/androidx/recyclerview/widget/ItemTouchHelper
 */

import android.content.DialogInterface
import android.view.LayoutInflater
import edu.ucsc.cse118.assignment3.R
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.fragment.app.DialogFragment
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.RecyclerView
import java.time.Instant
import java.time.LocalDateTime
import java.time.ZoneId
import java.time.format.DateTimeFormatter

class ChannelAdapter(private val messages: ArrayList<edu.ucsc.cse118.assignment3.data.Message>, private val listener: ChannelListener) :
  RecyclerView.Adapter<ChannelAdapter.Message>()
{
  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): Message {
    val view = LayoutInflater.from(parent.context)
      .inflate(R.layout.card_view_channel, parent, false)
    return Message(view)
  }
  override fun onBindViewHolder(holder: Message, position: Int) {
    holder.bind(messages[position])
    holder.itemView.setOnClickListener { listener.onClick(messages[position]) }
  }
  override fun getItemCount(): Int {
    return messages.size
  }

  fun deleteItem(position: Int) {
    listener.onSwiped(messages[position])
    //messages.remove(messages[position])
    notifyItemChanged(position)
  }

  class Message(ItemView: View) : RecyclerView.ViewHolder(ItemView) {
    private val name: TextView = itemView.findViewById(R.id.name)
    private val date: TextView = itemView.findViewById(R.id.date)
    private val content : TextView = itemView.findViewById(R.id.content)
    fun bind(message: edu.ucsc.cse118.assignment3.data.Message) {
      name.text = message.poster
      val parsedDate = Instant.parse(message.date)
      val localDate = LocalDateTime.ofInstant(parsedDate, ZoneId.of("UTC"))
      val formatter = DateTimeFormatter.ofPattern("MMM d, yyyy, hh:mm:ss a")
      val dateString = localDate.format(formatter)
      date.text = dateString
      content.text = message.content
    }
  }
}

class SwipeToDelete(private val channelAdapter: ChannelAdapter): ItemTouchHelper.SimpleCallback(0, ItemTouchHelper.END) {
  override fun onMove(
    recyclerView: RecyclerView,
    viewHolder: RecyclerView.ViewHolder,
    target: RecyclerView.ViewHolder
  ): Boolean {
    return true
  }

  override fun onSwiped(viewHolder: RecyclerView.ViewHolder, direction: Int) {
    val position = viewHolder.adapterPosition
    channelAdapter.deleteItem(position)
  }
}