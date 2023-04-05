/*
 * Resources:
 * https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/DateTimeFormat/DateTimeFormat#options
 * https://stackoverflow.com/questions/8888491/how-do-you-display-javascript-datetime-in-12-hour-am-pm-format
 */
import React from 'react';
import {TouchableWithoutFeedback, StyleSheet, Text, View} from 'react-native';
import {GestureHandlerRootView, Swipeable} from 'react-native-gesture-handler';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    padding: 5,
    borderWidth: 0.5,
    borderColor: 'white',
    borderRadius: 10,
    marginVertical: 3,
    backgroundColor: 'snow',
  },
  messageBubbleRight: {
    paddingLeft: 30,
    alignItems: 'flex-end',
  },
  messageBubbleLeft: {
    paddingRight: 30,
    alignItems: 'flex-start',
  },
  incoming: {
    paddingLeft: 10,
    paddingRight: 10,
    paddingVertical: 4,
    fontSize: 18,
    color: 'black',
    borderWidth: 1,
    borderColor: 'white',
    borderRadius: 10,
    marginVertical: 2,
    backgroundColor: 'honeydew',
  },
  outgoing: {
    paddingLeft: 10,
    paddingRight: 10,
    paddingVertical: 4,
    fontSize: 18,
    color: 'black',
    borderWidth: 1,
    borderColor: 'white',
    borderRadius: 10,
    marginVertical: 2,
    backgroundColor: 'aliceblue',
  },
  date: {
    paddingRight: 10,
    fontSize: 16,
    alignSelf: 'flex-end',
  },
  name: {
    paddingLeft: 5,
    fontSize: 16,
    fontWeight: 'bold',
    color: 'black',
  },
  nameRight: {
    alignSelf: 'flex-end',
    paddingRight: 5,
    fontSize: 16,
    fontWeight: 'bold',
    color: 'black',
  },
  delete: {
    backgroundColor: 'red',
    textAlignVertical: 'center',
    fontWeight: 'bold',
    fontSize: 16,
    padding: 10,
    borderRadius: 10,
    margin: 3,
  },
});

const MessageCard = ({user, members, message, navigation}) => {
  const swipeableRef = React.useRef(null);
  //const [visible, setVisible] = useState(true);

  /*
  const deleteMessage = async () => {
    await fetch(`https://cse118.com/api/v1/message/${message.id}`, {
      method: 'DELETE',
      headers: {
        Accept: 'application/json',
        Authorization: `Bearer ${user.accessToken}`,
      },
    });
  };

  const del = () => {
    deleteMessage();
    swipeableRef.current.close();
    setVisible(false);
  };
  */
  const rightSwipeActions = () => {
    return (
      <Text
        style={styles.delete}
        //onPress={() => del()}
        accessibilityLabel="delete message">
        DELETE
      </Text>
    );
  };

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

  function messageBubble() {
    /*
        if (message.member === user.id) {
            return styles.messageBubbleRight;
        } else {
            return styles.messageBubbleLeft;
        }
        */
    return styles.messageBubbleLeft;
  }

  function nameStyle() {
    /* if (message.member === user.id) {
            return styles.nameRight;
        } else {
            return styles.name;
        } */
    return styles.name;
  }

  function bubbleColor() {
    /* if (message.member === user.id) {
            return styles.outgoing;
        } else {
            return styles.incoming;
        } */
    return styles.incoming;
  }

  let memberName = members.find(x => x.id === message.member).name;
  //if (visible) {
  return (
    <TouchableWithoutFeedback
      onPress={() =>
        navigation.navigate('Message', {
          message: message,
          members: members,
        })
      }>
      <GestureHandlerRootView>
        <Swipeable ref={swipeableRef} renderRightActions={rightSwipeActions}>
          <View style={styles.container}>
            <Text style={nameStyle()}>{memberName}</Text>
            <View style={messageBubble()}>
              <Text style={bubbleColor()}>{message.content}</Text>
            </View>
            <Text style={styles.date}>{dateString}</Text>
          </View>
        </Swipeable>
      </GestureHandlerRootView>
    </TouchableWithoutFeedback>
  );
  //}
};

export default MessageCard;
