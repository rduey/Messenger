package edu.ucsc.cse118.assignment3.ui.workspace

import android.view.LayoutInflater
import edu.ucsc.cse118.assignment3.R
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class WorkspaceAdapter(private val channels: ArrayList<edu.ucsc.cse118.assignment3.data.Channel>, private val listener: WorkspaceListener) :
  RecyclerView.Adapter<WorkspaceAdapter.Channel>()
{
  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): Channel {
    val view = LayoutInflater.from(parent.context)
      .inflate(R.layout.card_view_master, parent, false)
    return Channel(view)
  }
  override fun onBindViewHolder(holder: Channel, position: Int) {
    holder.bind(channels[position])
    holder.itemView.setOnClickListener { listener.onClick(channels[position]) }
  }
  override fun getItemCount(): Int {
    return channels.size
  }
  class Channel(ItemView: View) : RecyclerView.ViewHolder(ItemView) {
    private val name: TextView = itemView.findViewById(R.id.name)
    private val count : TextView = itemView.findViewById(R.id.count)
    fun bind(channel: edu.ucsc.cse118.assignment3.data.Channel) {
      name.text = channel.name
      count.text = channel.messages.toString().plus(" Messages")
    }
  }
}