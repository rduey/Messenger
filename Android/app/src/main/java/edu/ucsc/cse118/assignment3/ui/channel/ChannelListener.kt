/*
 * UCSC CSE118 Mobile Applications
 *
 * Assignment 3 : Simple multi-fragment message app that displays workspaces, channels, and messages from a json file
 *
 * Copyright (C) 2022 David C. Harrison
 *
 * Resources:
 */

package edu.ucsc.cse118.assignment3.ui.channel

import edu.ucsc.cse118.assignment3.data.Message

interface ChannelListener {
  fun onClick(message: Message)
  fun onSwiped(message: Message)
}