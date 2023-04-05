import React, {useState} from 'react';
import {FlatList, StyleSheet, View} from 'react-native';

import ChannelCard from '../Cards/ChannelCard';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 10,
    backgroundColor: 'seashell',
  },
});

const ChannelList = ({route, navigation}) => {
  const user = route.params.user;
  const workspace = route.params.workspace;
  const members = route.params.members;
  const [channels, setChannels] = useState();

  const getChannels = async () => {
    await fetch(`https://cse118.com/api/v1/workspace/${workspace.id}/channel`, {
      method: 'GET',
      headers: {
        Accept: 'application/json',
        Authorization: `Bearer ${user.accessToken}`,
      },
    })
      .then(response => {
        return response.json();
      })
      .then(json => {
        setChannels(json);
      });
  };
  /*
        useEffect(() => {
          const unsubscribe = navigation.addListener('focus', () => {
            // The screen is focused
            // Call any action
            getChannels();
          });
          // Return the function to unsubscribe from the event so it gets removed on unmount
          return unsubscribe;
        }, [getChannels, navigation]);
        */
  if (channels === undefined) {
    getChannels();
  }
  return (
    <View style={styles.container}>
      <FlatList
        data={channels}
        keyExtractor={item => item.id}
        renderItem={({item}) => (
          <ChannelCard
            user={user}
            members={members}
            channel={item}
            navigation={navigation}
          />
        )}
      />
    </View>
  );
};

export default ChannelList;
