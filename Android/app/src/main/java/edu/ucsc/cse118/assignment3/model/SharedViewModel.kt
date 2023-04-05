/*
 * UCSC CSE118 Mobile Applications
 *
 * Assignment 3 : Simple multi-fragment message app that displays workspaces, channels, and messages from a json file
 *
 * Copyright (C) 2022 David C. Harrison
 *
 * Resources:
 */

package edu.ucsc.cse118.assignment3.model

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import edu.ucsc.cse118.assignment3.data.*
import edu.ucsc.cse118.assignment3.repo.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class SharedViewModel : ViewModel() {

  private val _workspaces = MutableLiveData<ArrayList<Workspace>>()
  val workspaces: LiveData<ArrayList<Workspace>> = _workspaces

  private val _workspace = MutableLiveData<ViewModelEvent<Workspace>>()
  val workspace : LiveData<ViewModelEvent<Workspace>> = _workspace

  private val _channels = MutableLiveData<ArrayList<Channel>>()
  val channels: LiveData<ArrayList<Channel>> = _channels

  private val _channel = MutableLiveData<ViewModelEvent<Channel>>()
  val channel : LiveData<ViewModelEvent<Channel>> = _channel

  private val _messages = MutableLiveData<ArrayList<Message>>()
  val messages: LiveData<ArrayList<Message>> = _messages

  private val _message = MutableLiveData<ViewModelEvent<Message>>()
  val message : LiveData<ViewModelEvent<Message>> = _message

  private val _member = MutableLiveData<Member>()
  val member : LiveData<Member> = _member

  private val _error = MutableLiveData<ViewModelEvent<String>>()
  val error : LiveData<ViewModelEvent<String>> = _error

  fun login(email: String, password: String) {
    viewModelScope.launch(Dispatchers.IO) {
      try {
        _member.postValue(MemberRepository().login(email, password))
      } catch (e: Exception) {
        _error.postValue(ViewModelEvent(e.message.toString()))
      }
    }
  }

  fun getWorkspaces() {
    viewModelScope.launch(Dispatchers.IO) {
      try {
        _workspaces.postValue(WorkspaceRepository().getAll(member.value))
      } catch (e: Exception) {
        _error.postValue(ViewModelEvent(e.message.toString()))
      }
    }
  }

  fun setWorkspace(value: Workspace) {
    _workspace.value = ViewModelEvent(value)
  }

  fun getChannels() {
    viewModelScope.launch(Dispatchers.IO) {
      try {
        _channels.postValue(ChannelRepository().getAll(member.value, _workspace.value?.getRawContent()))
      } catch (e: Exception) {
        _error.postValue(ViewModelEvent(e.message.toString()))
      }
    }
  }

  fun setChannel(value: Channel) {
    _channel.value = ViewModelEvent(value)
  }

  fun getMessages() {
    viewModelScope.launch(Dispatchers.IO) {
      try {
        _messages.postValue(MessageRepository().getAll(member.value, _channel.value?.getRawContent()))
      } catch (e: Exception) {
        _error.postValue(ViewModelEvent(e.message.toString()))
      }
    }
  }

  fun addMessage(message: Message) {
    viewModelScope.launch(Dispatchers.IO) {
      try {
        MessageRepository().addOne(member.value, _channel.value?.getRawContent(), message)
        _message.postValue(ViewModelEvent(message))
      } catch (e: Exception) {
        _error.postValue(ViewModelEvent(e.message.toString()))
      }
    }
  }

  fun deleteMessage(message: Message) {
    viewModelScope.launch(Dispatchers.IO) {
      try {
        MessageRepository().deleteOne(member.value, message)
        //_message.postValue(ViewModelEvent(message))
      } catch (e: Exception) {
        _error.postValue(ViewModelEvent(e.message.toString()))
      }
    }
  }

  fun setMessage(value: Message) {
    _message.value = ViewModelEvent(value)
  }

}

