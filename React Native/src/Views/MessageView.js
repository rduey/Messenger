import React from 'react';
import {StyleSheet, Text, View} from 'react-native';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 10,
    backgroundColor: 'seashell',
  },
  messageBubble: {
    paddingRight: 50,
    alignItems: 'flex-start',
  },
  content: {
    paddingLeft: 10,
    paddingRight: 10,
    paddingVertical: 2,
    fontSize: 18,
    color: 'black',
    borderWidth: 1,
    borderColor: 'white',
    borderRadius: 10,
    marginVertical: 2,
    backgroundColor: 'aliceblue',
  },
  name: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  date: {
    paddingLeft: 10,
    fontSize: 16,
  },
});

const MessageView = ({route}) => {
  const {message} = route.params;
  let date = new Date(message.posted);
  let dateString = date.toLocaleString('en-US', {
    month: 'short',
    day: 'numeric',
    year: 'numeric',
  });
  dateString += ' at ';
  dateString += date.toLocaleString('en-US', {
    hour: 'numeric',
    minute: 'numeric',
    hour12: true,
  });
  return (
    <View style={styles.container}>
      <View style={styles.messageBubble}>
        <Text style={styles.content}>{message.content}</Text>
      </View>
      <Text style={styles.date}>{dateString}</Text>
    </View>
  );
};

export default MessageView;
