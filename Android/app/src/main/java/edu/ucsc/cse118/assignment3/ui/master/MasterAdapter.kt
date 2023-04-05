package edu.ucsc.cse118.assignment3.ui.master

import android.view.LayoutInflater
import edu.ucsc.cse118.assignment3.R
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class MasterAdapter(private val workspaces: ArrayList<edu.ucsc.cse118.assignment3.data.Workspace>, private val listener: MasterListener) :
  RecyclerView.Adapter<MasterAdapter.Workspace>()
{
  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): Workspace {
    val view = LayoutInflater.from(parent.context)
      .inflate(R.layout.card_view_master, parent, false)
    return Workspace(view)
  }
  override fun onBindViewHolder(holder: Workspace, position: Int) {
    holder.bind(workspaces[position])
    holder.itemView.setOnClickListener { listener.onClick(workspaces[position]) }
  }
  override fun getItemCount(): Int {
    return workspaces.size
  }
  class Workspace(ItemView: View) : RecyclerView.ViewHolder(ItemView) {
    private val name: TextView = itemView.findViewById(R.id.name)
    private val count : TextView = itemView.findViewById(R.id.count)
    fun bind(workspace: edu.ucsc.cse118.assignment3.data.Workspace) {
      name.text = workspace.name
      count.text = workspace.channels.toString().plus(" Channels")
    }
  }
}