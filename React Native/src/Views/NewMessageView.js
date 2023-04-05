/*
 * Resources:
 * https://stackoverflow.com/questions/45489343/react-navigation-back-and-goback-not-working
 */
import React, {useState} from 'react';
import {StyleSheet, View, Button} from 'react-native';
import {TextInput} from 'react-native-gesture-handler';
import {ViewModel} from '../Main';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 10,
    backgroundColor: 'seashell',
  },
  textInput: {
    height: 100,
    backgroundColor: 'white',
    textAlignVertical: 'top',
    paddingHorizontal: 10,
    borderWidth: 1,
    borderRadius: 10,
    borderColor: 'gray',
  },
  options: {
    flexDirection: 'row',
    justifyContent: 'space-evenly',
    paddingTop: 20,
    paddingHorizontal: 80,
  },
});

const NewMessageView = ({route, navigation}) => {
  const user = route.params.user;
  const channel = route.params.channel;
  const [content, setContent] = useState();

  const {getMessages} = React.useContext(ViewModel);

  const backToMessages = async () => {
    await getMessages(user, channel);
    navigation.goBack();
  };

  const addMessage = async () => {
    await fetch(`https://cse118.com/api/v1/channel/${channel.id}/message`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Accept: 'application/json',
        Authorization: `Bearer ${user.accessToken}`,
      },
      body: JSON.stringify({
        content: content,
      }),
    });
    backToMessages();
  };
  return (
    <View style={styles.container}>
      <TextInput
        style={styles.textInput}
        placeholderTextColor="cornflowerblue"
        onChangeText={_content => setContent(_content)}
        accessibilityLabel="content"
      />
      <View style={styles.options}>
        <Button
          onPress={() => navigation.goBack()}
          title="Cancel"
          accessibilityLabel="cancel"
        />
        <Button
          onPress={() => addMessage()}
          title="Add"
          accessibilityLabel="add"
        />
      </View>
    </View>
  );
};

export default NewMessageView;
