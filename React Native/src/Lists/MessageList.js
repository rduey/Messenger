/*
 * Resources:
 * https://reactnavigation.org/docs/function-after-focusing-screen/
 */

import React from 'react';
import {FlatList, StyleSheet, View, TouchableOpacity, Text} from 'react-native';

import MessageCard from '../Cards/MessageCard';
import {ViewModel} from '../Main';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 10,
    backgroundColor: 'seashell',
    flexDirection: 'column-reverse',
  },
  buttonContainer: {
    flex: 1,
    position: 'absolute',
    padding: 40,
    alignSelf: 'flex-end',
  },
  button: {
    width: 60,
    borderRadius: 30,
    height: 60,
    alignItems: 'center',
    backgroundColor: '#00173A',
    borderColor: '#FFCC00',
    justifyContent: 'center',
    textAlign: 'center',
    textAlignVertical: 'center',
  },
  buttonText: {
    color: '#FFCC00',
    fontSize: 30,
    fontWeight: 'bold',
  },
});

const MessageList = ({route, navigation}) => {
  const user = route.params.user;
  const members = route.params.members;
  //const [messages, setMessages] = useState();
  const {messages} = React.useContext(ViewModel);
  /*
        useEffect(() => {
          const unsubscribe = navigation.addListener('focus', () => {
            // The screen is focused
            // Call any action
            getMessages();
          });
          // Return the function to unsubscribe from the event so it gets removed on unmount
          return unsubscribe;
        }, [getMessages, navigation]);
        */
  return (
    <View style={styles.container}>
      <FlatList
        data={messages}
        keyExtractor={item => item.id}
        renderItem={({item}) => (
          <MessageCard
            user={user}
            members={members}
            message={item}
            navigation={navigation}
          />
        )}
      />
      <View style={styles.buttonContainer}>
        {/*
                <Button
                    style={styles.button}
                    onPress={() => navigation.navigate('New Message', {
                        user: route.params.user,
                        members: route.params.members,
                        channel: route.params.channel,
                    })}
                    title="New"
                //accessibilityLabel='new message'
                />
                */}
        <TouchableOpacity
          style={styles.button}
          accessibilityLabel="add message"
          onPress={() =>
            navigation.navigate('New Message', {
              user: route.params.user,
              members: route.params.members,
              channel: route.params.channel,
            })
          }>
          <Text style={styles.buttonText}>{'\uFF0B'}</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

export default MessageList;
